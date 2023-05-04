import socket
import shutil
from datetime import datetime
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from time import sleep
import hashlib

# https://github.com/knucklesuganda/send_socket_image
# https://github.com/abhishekdeokar/sockets-with-encryption


KEY = hashlib.sha256(b"capstone").digest()

IV = b"abcdefghijklmnop"
obj_enc = AES.new(KEY, AES.MODE_CFB, IV)						
obj_dec = AES.new(KEY, AES.MODE_CFB, IV)


while(True):
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(('', 5000))  
    server.listen()
    client_socket, client_address = server.accept()

    # create a file to store image in named with the time it is recieved
    filename = datetime.now().strftime("%d-%m-%Y_%H:%M:%S")+'.jpg'
    file = open(filename, "wb")

    image_enc = client_socket.recv(2048)
    image_chunk = obj_dec.decrypt(image_enc)
    file.write(image_chunk)

    while image_chunk:
        image_enc = client_socket.recv(2048)
        image_chunk = obj_dec.decrypt(image_enc)
        file.write(image_chunk)

    file.close()
    shutil.move(filename, "/home/thespotods/Receive/"+filename)

    client_socket.close()
    sleep(1)
