import requests

TELEGRAM_TOKEN = "8079984808:AAHrBjX1fFAqEjJwmTHHOoL5cvD53bMrqt0"
TELEGRAM_CHAT_ID = "401009278"

def send_telegram_message(message: str):
    url = f"https://api.telegram.org/bot{TELEGRAM_TOKEN}/sendMessage"
    payload = {
        "chat_id": TELEGRAM_CHAT_ID,
        "text": message
    }
    try:
        response = requests.post(url, json=payload)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"Telegram send error: {e}")