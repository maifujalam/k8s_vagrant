#!/bin/python3

# connection->socket->session->channel

import socket
from ssh2 import session

HOST_IP="master"
HOST_PORT=22
HOST_USER="vagrant"
HOST_PASSWORD="vagrant"
COMMAND="ps"

def open_socket():
    init_socket=socket.create_connection((HOST_IP,HOST_PORT))
    print("Socket opened")
    return init_socket

def close_socket(socket):
    socket.close()
    print("Socket closed")

def open_session(socket):
    init_session=session.Session()
    init_session.handshake(socket)
    init_session.userauth_password(HOST_USER,HOST_PASSWORD)
    print("Session opened")
    return init_session

def close_session(socket):
    close_socket(socket)
    print("Session closed")

def open_channel(session):
    channel=session.open_session()
    print("Channel created")
    return channel

def close_channel(channel):
    channel.close()
    print("Channel closed")

def run_command(channel):
    channel.execute(COMMAND)
    rc,output=channel.read()
    return rc,output

if __name__ == '__main__':
    socket_object=open_socket()
    if socket_object:
        session_object=open_session(socket_object)
        if session_object:
            new_channel=open_channel(session_object)
            if new_channel:
                command_output=run_command(new_channel)
                print(command_output)
            close_channel(new_channel)
        close_session(socket_object)