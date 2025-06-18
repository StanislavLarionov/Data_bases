 
import redis

r = redis.Redis(host='localhost', port=6379, decode_responses=True)

username = input("Enter your username: ")

while True:
    msg = input('> ')
    if msg!="":
        
        msg = f"{username}: {msg}"
        r.set('last_message', msg, ex=5)
