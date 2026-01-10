#!/bin/bash
CURRENT=$(go version | awk '{print $3}' | sed 's/go//')
LATEST=$(curl -s https://go.dev/VERSION?m=text | head -1 | sed 's/go//')

if [ "${CURRENT}" != "${LATEST}" ]; then
    echo -e "\033[31mNew Go version available: ${LATEST} (current: ${CURRENT})\033[0m"
fi
