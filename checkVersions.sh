#!/bin/bash

check() {
  if [ "${CURRENT}" != "${LATEST}" ]; then
      echo -e "\033[31mNew ${NAME} version available: ${LATEST} (current: ${CURRENT})\033[0m"
  else
      echo -e "\033[32m${NAME} version is already the latest ${LATEST}\033[0m"
  fi
}

golang() {
  NAME="Golang"
  CURRENT='1.25.7'
  LATEST="$(curl -s https://go.dev/VERSION?m=text | head -1 | sed 's/go//')"
}

kubernetes() {
  NAME="Kubernetes"
  CURRENT='1.35.1'
  LATEST="$(curl -s https://dl.k8s.io/release/stable.txt | sed 's/v//')"
}

openwrt() {
  NAME='OpenWrt'
  CURRENT='24.10.5'
  LATEST="$(wget -qO- https://downloads.openwrt.org/.versions.json | awk -F '"' '/"stable_version"/{print $4}')"
}

postamrketos() {
  NAME='postmarketOS'
  CURRENT='25.12'
  LATEST="$(wget -qO- 'https://gitlab.postmarketos.org/postmarketOS/pmaports/-/raw/master/channels.cfg?ref_type=heads&inline=false' | awk 'match($0, /[[]v([0-9]{2}[.][0-9]{2})[]]/, arr) {printf "%s", arr[1]; exit}')"
}

for i in golang kubernetes openwrt postamrketos; do
    ${i}
    check
done
