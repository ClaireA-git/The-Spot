import socket
from time import sleep
from picamera2 import Picamera2
from Crypto.Cipher import AES
import hashlib

# code references
# https://github.com/knucklesuganda/send_socket_image
# https://github.com/abhishekdeokar/sockets-with-encryption

# camera setup
camera = Picamera2()
# configure the camera to use the dimensions 4656x3496
camera_config = camera.create_still_configuration\
                (main={"size": (4656, 3496)}, lores={"size": (1920, 1080)}, display="lores")
camera.configure(camera_config)
# start the camera
camera.start()
# make the camera automatically focus
camera.set_controls({"AfMode": 2, "AfTrigger": 0})

# create key for AES encryption
KEY = hashlib.sha256(b"capstone").digest()  

# create 16 bit initialization vector
IV = b"abcdefghijklmnop"

# create an encryption object
obj_enc = AES.new(KEY, AES.MODE_CFB, IV)

# sleep for 1 second to allow the camera time to setup
sleep(1)
while(True):
    # take picture and save as client_picture.jpg
    camera.capture_file("client_picture.jpg")
    # create socket
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # AF_INET = IP, SOCK_STREAM = TCP
    # connect socket to cloud machine using port 5000
    client.connect(('34.174.27.196', 5000))
    # open the picture
    file = open('client_picture.jpg', 'rb')
    # save a chunk of image data
    image_data = file.read(2048)

    # stay in while loop until there is no more image data
    while image_data:
        # encrypt the image data
        data_enc = obj_enc.encrypt(image_data)
        # send to cloud machine
        client.send(data_enc)
        # get more image data
        image_data = file.read(2048)

    # close the file
    file.close()
    print("Picture sent")
    # close the connection
    client.close()
    # wait 30 seconds before sending another picture
    sleep(30)
