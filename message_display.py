import redis, time

r = redis.Redis(host='localhost', port=6379, decode_responses=True)

last_message = "" 
while True:
    message = r.get('last_message') or ""
    if message not in [last_message, ""]:
        print(f"{message}")
        last_message = message
    time.sleep(0.2)