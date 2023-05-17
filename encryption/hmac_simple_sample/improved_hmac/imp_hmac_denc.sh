#!/bin/bash

# Directory to decrypt
DIR="my_directory"

# RSA private and public keys
PRIVATE_KEY="mykey.pem"
PUBLIC_KEY="mykey.pub.pem"

# Decrypt the key with RSA
KEY=$(openssl rsautl -decrypt -inkey $PRIVATE_KEY -in key.enc)

# Verify and Decrypt files with AES-256
find $DIR -type f -name "*.enc" -print0 | while read -d $'\0' file
do
    # Verify HMAC
    HMAC=$(openssl dgst -sha256 -hmac $KEY -binary "${file%.enc}" | openssl base64)
    if [ "$HMAC" != "$(cat $file.hmac)" ]; then
        echo "HMAC verification failed for $file. Skipping."
        continue
    fi

    # Decrypt
    openssl enc -aes-256-cbc -d -in "$file" -out "${file%.enc}" -pass pass:$KEY
done

