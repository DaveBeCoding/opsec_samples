#!/bin/bash

# Directory to encrypt
DIR="my_directory"

# RSA private and public keys
PRIVATE_KEY="mykey.pem"
PUBLIC_KEY="mykey.pub.pem"

# Generate a random key for AES-256
KEY=$(openssl rand -hex 32)

# Encrypt files with AES-256
for file in $(find $DIR -type f); do
    openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -pass pass:$KEY
done

# Generate HMAC for each file
for file in $(find $DIR -type f -name "*.enc"); do
    openssl dgst -sha256 -hmac $KEY -binary $file | openssl base64 > $file.hmac
done

# Encrypt the key with RSA
echo $KEY | openssl rsautl -encrypt -pubin -inkey $PUBLIC_KEY -out key.enc

# At this point, you can safely delete the original files and the plaintext key

