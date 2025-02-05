#!/bin/python3
from ssh2 import session
import socket

HOST_IP="master"
HOST_PORT="22"
HOST_USER="vagrant"
HOST_PASSWORD="vagrant"


if __name__ == '__main__':
    print("Ok")
    socket=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socket.connect((HOST_IP, HOST_PORT))