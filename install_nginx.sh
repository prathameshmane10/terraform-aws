#!/bin/bash

set -e

echo "updating package lists..."
sudo apt-get update -y

echo "installing nginx..."
sudo apt-get install -y nginx

echo "starting and enabling nginx service..."
sudo systemctl start nginx
sudo systemctl enable --now nginx

echo "checking nginx status..."
sudo systemctl status nginx --no-pager


echo "<h1>Welcome to Terraform!</h1>" | sudo tee /var/www/html/index.html