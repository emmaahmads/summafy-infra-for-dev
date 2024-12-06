#!/bin/bash
set -e

db_username="na"
db_user_password="na"
db_host="na"
db_name="na"

echo "EMMA Install CLI 1"
#install AWS CLI
sudo apt update  -y
sudo apt upgrade -y
echo "EMMA Install CLI 2"
sudo apt install unzip -y
echo "EMMA Install CLI 3"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
echo "EMMA Install CLI 4"
sudo ./aws/install
echo "EMMA Install CLI 5"
#check version
aws --version

#configure aws cli
#aws configure