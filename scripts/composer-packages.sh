#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

PACKAGES=(
    "laravel/installer"
)

for package in "${PACKAGES[@]}"; do
	composer global require "$package"
done

finish
