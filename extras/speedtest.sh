#!/bin/bash
# File: extras/speedtest.sh
# Author: Tiago Lucas Flach
set -euo pipefail

if [[ ! -r /etc/os-release ]]; then
    echo "Não foi possível detectar a distribuição Linux."
    exit 1
fi
. /etc/os-release
if [[ "${ID:-}" != "ubuntu" ]]; then
    echo "Este instalador do Speedtest é exclusivo para Ubuntu."
    exit 1
fi

DIST="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
if [[ -z "$DIST" ]]; then
    echo "Não foi possível detectar o codinome desta versão do Ubuntu."
    exit 1
fi

GPG_KEY_URL="https://packagecloud.io/ookla/speedtest-cli/gpgkey"
APT_CONFIG_URL="https://packagecloud.io/install/repositories/ookla/speedtest-cli/config_file.list?os=Ubuntu&dist=${DIST}&source=script"
APT_SOURCE_PATH="/etc/apt/sources.list.d/ookla_speedtest-cli.list"
APT_KEYRING_PATH="/etc/apt/keyrings/ookla_speedtest-cli-archive-keyring.gpg"

sudo install -d -m 0755 /etc/apt/keyrings
if ! curl -fsSL "$APT_CONFIG_URL" | sudo tee "$APT_SOURCE_PATH" >/dev/null; then
    sudo rm -f "$APT_SOURCE_PATH"
    echo "O repositório Speedtest não oferece suporte ao Ubuntu ${DIST}."
    exit 1
fi

curl -fsSL "$GPG_KEY_URL" | sudo gpg --dearmor --yes -o "$APT_KEYRING_PATH"
sudo chmod 0644 "$APT_KEYRING_PATH"
sudo apt-get update
sudo apt-get install -y speedtest
