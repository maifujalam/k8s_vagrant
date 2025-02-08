#!/bin/python3
import socket

HOST_IP="master"
HOST_PORT=22


def new_client(host,port):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((host,port))
        print("Connected to %s:%d" % (host,port))
        return True
    except socket.error as msg:
        print("Failed to connect to %s:%d" % (host,port))
    return False


if __name__ == '__main__':
    print("Ok")
    connection_status=new_client(HOST_IP, HOST_PORT)
    print(connection_status)