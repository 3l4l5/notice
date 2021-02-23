import requests

def send_message(message):
    path = '../token/token.txt'
    f = open(path, 'r', encoding='UTF-8')
    token = f.read()
    f.close()

    url = "https://notify-api.line.me/api/notify"
    headers = {"Authorization" : "Bearer "+ token}

    payload = {"message" :  message}

    r = requests.post(url ,headers = headers ,params=payload)

