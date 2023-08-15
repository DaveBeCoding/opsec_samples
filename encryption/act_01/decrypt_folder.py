#!/usr/bin/env python3

import os
import subprocess

def decrypt_folder(encrypted_folder_name):
    # Assuming the encrypted file is named as `foldername.zip.enc`
    original_folder_name = encrypted_folder_name.replace(".zip.enc", "")

    # Decrypt the folder
    decryption_command = [
        "openssl", "enc", "-d", "-aes-256-cbc",
        "-in", encrypted_folder_name,
        "-out", f"{original_folder_name}.zip"
    ]
    subprocess.run(decryption_command, check=True)

    # Unzip the decrypted file
    unzip_command = ["unzip", f"{original_folder_name}.zip"]
    subprocess.run(unzip_command, check=True)

    # Optionally, remove the decrypted zip (uncomment below if you want this)
    # os.remove(f"{original_folder_name}.zip")

if __name__ == "__main__":
    encrypted_file = input("Enter the name of the encrypted file (e.g., myfolder.zip.enc): ")
    decrypt_folder(encrypted_file)

