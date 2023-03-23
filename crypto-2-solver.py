
from Crypto.Util.number import *

import requests

addr = "http://10.10.26.10:1177"

session = requests.session()

page = session.request("GET", addr).text
n = int(page.splitlines()[0].split('=')[1].strip().replace("</p>", ""))

def get_bit(index):
    for _ in range(100):
        guess = int(session.request("GET", addr+f'/guess_bit?bit={index}').json()["guess"])
        if guess < n // 2:
            return 1
    return 0


bits = ""
byte_idx = 0
try:
    while 1:
        for bit in range(8):
            bits += str(get_bit(bit + byte_idx*8))
        byte_idx += 1
except:
    pass

print(long_to_bytes(int(bits, 2)))
