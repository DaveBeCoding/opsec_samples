#!/bin/bash

# Set the path to your files directory
FILES_DIR="/path/to/files"

# Set the path to your public key
PUBLIC_KEY="/path/to/public_key.pem"

# Set the path to your private key
PRIVATE_KEY="/path/to/private_key.pem"

# Set the path to your encrypted files directory
ENCRYPTED_DIR="/path/to/encrypted_files"

# Create the encrypted files directory
mkdir -p "$ENCRYPTED_DIR"

# Encrypt each file in the directory using AES-256 encryption and your public key
for file in "$FILES_DIR"/*
do
    openssl rsautl -encrypt -inkey "$PUBLIC_KEY" -pubin -in "$file" -out "$ENCRYPTED_DIR/$(basename "$file").enc"
    openssl aes-256-cbc -salt -in "$ENCRYPTED_DIR/$(basename "$file").enc" -out "$ENCRYPTED_DIR/$(basename "$file").enc.aes" -pass file:"$PRIVATE_KEY"
    rm "$ENCRYPTED_DIR/$(basename "$file").enc"
done

echo "Encryption complete."

