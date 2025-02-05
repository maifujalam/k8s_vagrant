import socket
s = socket.socket()

HOST_IP="master"
HOST_PORT=22
HOST_USER="vagrant"
HOST_PASSWORD="vagrant"

def check_server():
    try:
        s=socket.socket()
        s.connect((HOST_IP,HOST_PORT))
        print("Connection established")
        return True
    except socket.error:
        return False

if __name__ == "__main__":
    print(check_server())