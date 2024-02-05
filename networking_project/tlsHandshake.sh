#!/bin/bash

# Step 1 - Client Hello
CLIENT_HELLO_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d '{
  "version": "1.3",
  "ciphersSuites": [
    "TLS_AES_128_GCM_SHA256",
    "TLS_CHACHA20_POLY1305_SHA256"
  ],
  "message": "Client Hello"
}' http://<public-ec2-instance-ip>:8080/clienthello)

# Check if Client Hello was successful
if [ $? -ne 0 ]; then
  echo "Client Hello failed."
  exit 1
fi

# Parse Client Hello Response
SERVER_VERSION=$(echo "$CLIENT_HELLO_RESPONSE" | jq -r '.version')
CIPHER_SUITE=$(echo "$CLIENT_HELLO_RESPONSE" | jq -r '.cipherSuite')
SESSION_ID=$(echo "$CLIENT_HELLO_RESPONSE" | jq -r '.sessionID')
SERVER_CERT=$(echo "$CLIENT_HELLO_RESPONSE" | jq -r '.serverCert')

# Step 2 - Server Hello
SERVER_HELLO_RESPONSE=$(curl -s http://13.212.249.91:8080/serverhello?version="$SERVER_VERSION"&sessionID="$SESSION_ID"&cipherSuite="$CIPHER_SUITE"&serverCert="$SERVER_CERT")

# Check if Server Hello was successful
if [ $? -ne 0 ]; then
  echo "Server Hello failed."
  exit 2
fi

# Parse Server Hello Response
SESSION_ID=$(echo "$SERVER_HELLO_RESPONSE" | jq -r '.sessionID')
SERVER_CERT=$(echo "$SERVER_HELLO_RESPONSE" | jq -r '.serverCert')

# Step 3 - Server Certificate Verification
CERT_CA_AWS_URL="https://raw.githubusercontent.com/alonitac/atech-devops-june-2023/main/networking_project/tls_webserver/cert-ca-aws.pem"
wget -O cert-ca-aws.pem "$CERT_CA_AWS_URL"

openssl verify -CAfile cert-ca-aws.pem "$SERVER_CERT"
if [ $? -ne 0 ]; then
  echo "Server Certificate is invalid."
  exit 5
fi

# Step 4 - Client-Server master-key exchange
MASTER_KEY=$(openssl rand -base64 32)
ENCRYPTED_MASTER_KEY=$(echo "$MASTER_KEY" | openssl smime -encrypt -aes-256-cbc -outform DER -binary "$SERVER_CERT" | base64 -w 0)

# Step 5 - Server verification message
ENCRYPTED_SAMPLE_MESSAGE=$(curl -s -X POST -H "Content-Type: application/json" -d '{
  "sessionID": "'"$SESSION_ID"'",
  "masterKey": "'"$ENCRYPTED_MASTER_KEY"'",
  "sampleMessage": "Hi server, please encrypt me and send to client!"
}' http://<public-ec2-instance-ip>:8080/keyexchange | jq -r '.encryptedSampleMessage')

# Step 6 - Client verification message
echo "$ENCRYPTED_SAMPLE_MESSAGE" | base64 -d | openssl enc -aes-256-cbc -d -K $(echo "$MASTER_KEY" | base64 -d) -iv 0

if [ $? -ne 0 ]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
fi

# Successful completion
echo "Client-Server TLS handshake has been completed successfully"
