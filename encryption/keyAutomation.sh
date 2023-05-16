#!/bin/bash

default_name="default"

if [ -z "$1" ]
then
    name=$default_name
else
    name=$1
fi

# Generate private key
openssl genpkey -algorithm RSA -out ${name}.pem -pkeyopt rsa_keygen_bits:2048

# Generate public key
openssl rsa -pubout -in ${name}.pem -out ${name}.pub.pem

echo "Keys generated: ${name}.pem and ${name}.pub.pem"

