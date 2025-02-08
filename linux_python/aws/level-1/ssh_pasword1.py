#!/bin/bash
import socket
from ssh2 import session, channel

HOST_IP = "master"
HOST_PORT = 22
HOST_USER = "vagrant"
HOST_PASSWORD = "vagrant"
COMMAND = "ls -al"


# channel->session(object,handshake,authentication,open)->socket->connection

def new_socket():
    try:
        init_socket = socket.create_connection((HOST_IP, HOST_PORT))
        print("Socket created")
        return init_socket
    except:
        print("Failed to create socket")
        return None

def close_socket(socket):
    socket.close()
    print("Socket closed")

def new_session(init_socket):
    try:
        session_obj = session.Session()
        session_obj.handshake(init_socket)
        session_obj.userauth_password(HOST_USER,HOST_PASSWORD)
        print("Session created")
        return session_obj
    except:
        print("Failed to create session")
        return None


def new_channel(session_obj):
    try:
        channel_obj = session_obj.open_session()
        print("Channel created")
        return channel_obj
    except Exception as e:
        print("Failed to create channel",e)
        return None

def close_channel(channel_obj):
    try:
        channel_obj.close()
        print("Channel closed")
        return channel_obj
    except Exception as ex:
        print("Failed to close channel",ex)
        return None


def exec_command(new_channel_obj):
    new_channel_obj.execute(COMMAND)
    rc, data = new_channel_obj.read()
    return rc,data

if __name__ == '__main__':
    new_socket_obj = new_socket()
    new_session_obj = new_session(new_socket_obj)
    new_channel_obj = new_channel(new_session_obj)
    rc,data = exec_command(new_channel_obj)
    print(data)
    print(rc)
    if new_channel_obj:
        close_channel(new_channel_obj)
        if new_session_obj:
            close_socket(new_socket_obj)