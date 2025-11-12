import boto3
import datetime
from playwright.sync_api import sync_playwright
import sys

## S3 configuration
s3_bucket = "lambda-production-bucket-7483-8939-6719"
s3_key_prefix = "exchange_rates/"  # optional folder prefix inside S3
s3 = boto3.client("s3")


def lambda_handler(event=None, context=None):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True, args=[
                "--no-sandbox",
                "--disable-gpu",
                "--disable-dev-shm-usage",
                "--disable-setuid-sandbox",
                "--disable-software-rasterizer",
                "--no-zygote",
                "--single-process",
                "--disable-dev-shm-usage",
                "--font-cache-shared-handle=0",
                "--use-gl=swiftshader",  # Software renderer
                "--disable-extensions",
                "--disable-background-networking",
                "--disable-sync",
            ],)
        context = browser.new_context()
        page = context.new_page()
        page.goto("https://www.cbsl.gov.lk/en/rates-and-indicators/exchange-rates/daily-buy-and-sell-exchange-rates")
        page.wait_for_selector("iframe#iFrameResizer2")

        frame = page.frame_locator("iframe#iFrameResizer2")

        frame.locator('button.btn.btn-default', has_text="Select All").click()
        page.wait_for_timeout(1000)

        
        frame.locator('button[name="submit_button"]').click()
        page.wait_for_timeout(1000)


        frame.locator('button.btn-link', has_text="1 Week").click()
        page.wait_for_timeout(1000)


         # Handle the CSV download        
        with page.expect_download() as download_info:
            frame.locator('button.btn-link', has_text="CSV").click()
        download = download_info.value
        

        temp_path = download.path()
        today = datetime.date.today().strftime("%Y%m%d")
        s3_key = f"{s3_key_prefix}exchange_rates_{today}.csv"
        # 🧭 Specify your desired location
        with open(temp_path, "rb") as f:
            s3.upload_fileobj(f, s3_bucket, s3_key)
        # save_path = r"C:\Users\Pasan\Downloads\exchange_rates.csv"
        # download.save_as(save_path)
        
        print(f"✅ Uploaded directly to s3://{s3_bucket}/{s3_key}")
        # print(f"✅ CSV file saved at: {save_path}")


        browser.close()

    sys.exit(0)

lambda_handler()




