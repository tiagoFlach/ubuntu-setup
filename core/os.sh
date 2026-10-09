#!/bin/bash
# File: core/os.sh
# Author: Tiago Lucas Flach

require_distro() {
    local expected_id="$1"

    if [[ ! -r /etc/os-release ]]; then
        echo "Não foi possível detectar a distribuição Linux."
        return 1
    fi

    . /etc/os-release
    if [[ "${ID:-}" != "$expected_id" ]]; then
        echo "Este script exige ${expected_id} (detectado: ${PRETTY_NAME:-${ID:-desconhecido}})."
        return 1
    fi
}