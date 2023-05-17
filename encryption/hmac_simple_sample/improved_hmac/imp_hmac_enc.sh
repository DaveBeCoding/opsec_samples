#!/bin/bash

# Directory to encrypt
DIR="my_directory"

# RSA private and public keys
PRIVATE_KEY="mykey.pem"
PUBLIC_KEY="mykey.pub.pem"

# Generate a random key for AES-256
KEY=$(openssl rand -hex 32)

# Encrypt files with AES-256
find $DIR -type f -print0 | while read -d $'\0' file
do
    openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -pass pass:$KEY
    shred -u $file
done

# Generate HMAC for each file
find $DIR -type f -name "*.enc" -print0 | while read -d $'\0' file
do
    openssl dgst -sha256 -hmac $KEY -binary $file | openssl base64 > $file.hmac
done

# Encrypt the key with RSA
echo $KEY | openssl rsautl -encrypt -pubin -inkey $PUBLIC_KEY -out key.enc

# Securely delete the plaintext key
shred -u <<< "$KEY"

