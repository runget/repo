#!/bin/bash

# rungetrepoadd.sh . Created by Kolyadual in 2026.

if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script as root or using sudo."
    exit 1
fi

echo "Running as root! Continuing..."

if [ -d "/etc/apt/keyrings" ]; then
    echo "Directory /etc/apt/keyrings already exists. Continue..."
else
    echo "Directory /etc/apt/keyrings does not exist. Creating..."
    mkdir -p /etc/apt/keyrings
fi

curl -fsSL https://runget.github.io/repo/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/rungetrepo.gpg

echo "deb [signed-by=/etc/apt/keyrings/rungetrepo.gpg] https://runget.github.io/repo/ big main testing" | tee /etc/apt/sources.list.d/rungetrepo.list

apt update
