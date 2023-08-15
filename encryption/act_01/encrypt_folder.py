#!/usr/bin/env python3

import os
import subprocess

def encrypt_folder(folder_name):
    # Compress the folder first
    zip_command = ["zip", "-r", f"{folder_name}.zip", folder_name]
    subprocess.run(zip_command, check=True)

    # Encrypt the zipped folder
    encryption_command = [
        "openssl", "enc", "-aes-256-cbc", "-salt",
        "-in", f"{folder_name}.zip",
        "-out", f"{folder_name}.zip.enc"
    ]
    subprocess.run(encryption_command, check=True)

    # Optionally, remove the zipped folder (uncomment below if you want this)
    # os.remove(f"{folder_name}.zip")

if __name__ == "__main__":
    folder_to_encrypt = input("Enter the name of the folder to encrypt: ")
    encrypt_folder(folder_to_encrypt)

