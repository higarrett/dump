#!/usr/bin/env python3

from Crypto.Util.number import bytes_to_long, long_to_bytes
import sys
import textwrap
import socketserver
import string
import readline
import threading
from time import *

import getpass
import os
import subprocess
import open_door

username = long_to_bytes(29099066774615156) #garrett
password = long_to_bytes(7163082334141771109) #changeme


class Service(socketserver.BaseRequestHandler):
	
	def ask_creds(self):
		username_input = self.receive(b"Username: ").strip()
		password_input = self.receive(b"Password: ").strip()
	
		if username_input == username and password_input == password:
			return True
		else:
			return False
	
	def handle(self):
		loggedin = self.ask_creds()
		if not loggedin:
			self.send(b"Wrong Credentials!")
			return
			
		self.send(b"Successfully Logged In!")
		self.send(b"A door opened somewhere...Look up")
		execfile("open_door.py")
		
		
	
class ThreadedService(
		socketserver.ThreadingMixIn,
		socketserver.TCPServer,
		socketserver.DatagramRequestHandler,
):
	pass
	


def main():
	print("Starting server...")
	port = 2019
	host = "0.0.0.0"
	
	service = Service
	server = ThreadedService((host, port), service)
	server.allow_reuse_address = True
	
	server_thread = threading.Thread(target=server.serve_forever)
	
	server_thread.daemon = True
	server_thread.start()
	
	print("Server started on " + str(server.server_address) + "!")
	
	while True:
		sleep(10)


if __name__ == "__main__":
	main()