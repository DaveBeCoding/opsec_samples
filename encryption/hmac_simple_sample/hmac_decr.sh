#!/bin/bash

# Directory to decrypt
DIR="my_directory"

# RSA private and public keys
PRIVATE_KEY="mykey.pem"
PUBLIC_KEY="mykey.pub.pem"

# Decrypt the key with RSA
KEY=$(openssl rsautl -decrypt -inkey $PRIVATE_KEY -in key.enc)

# Decrypt files with AES-256
for file in $(find $DIR -type f -name "*.enc"); do
    openssl enc -aes-256-cbc -d -in "$file" -out "${file%.enc}" -pass pass:$KEY
done

# Verify HMAC for each file
for file in $(find $DIR -type f -not -name "*.enc" -and -not -name "*.hmac"); do
    if [[ $(openssl dgst -sha256 -hmac $KEY -binary $file | openssl base64) == $(cat $file.hmac) ]]; then
        echo "$file verified"
    else
        echo "$file verification failed"
    fi
done

