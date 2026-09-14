#!/bin/bash

eolDate() {
  curl -s "https://endoflife.date/api/${1}.json" | jq -r ".[0].${2}"
}

check() {
  if [ "${CURRENT}" != "${LATEST}" ]; then
    echo -e "\033[31mNew ${NAME} version available: ${LATEST} (current: ${CURRENT})\033[0m"
  else
    echo -e "\033[32m${NAME} version is already the latest ${LATEST}\033[0m"
  fi
}

flatpakKdePlatform() {
  NAME='org.kde.Platform//6.11'
  CURRENT='2026-09-13'
  LATEST="$(flatpak --user remote-info --log flathub org.kde.Platform//6.11 | awk '/Date:/{ print $2; exit}')"
}

freedesktopsdk() {
  NAME="Freedesktop SDK"
  CURRENT='26.08'
  LATEST="$(eolDate freedesktop-sdk cycle)"
}

golang() {
  NAME="Golang"
  CURRENT='1.27.1'
  LATEST="$(eolDate go latest)"
}

kubernetes() {
  NAME="Kubernetes"
  CURRENT='1.37.0'
  LATEST="$(eolDate kubernetes latest)"
}

opnsense() {
  NAME='OPNSense'
  CURRENT='26.7.3'
  LATEST="$(eolDate opnsense latest)"
}

openwrt() {
  NAME='OpenWrt'
  CURRENT='25.12.5'
  LATEST="$(eolDate openwrt latest)"
}

postmarketos() {
  NAME='postmarketOS'
  CURRENT='26.06'
  LATEST="$(eolDate postmarketos cycle)"
}

qt() {
  NAME='Qt'
  CURRENT='6.11.2'
  LATEST="$(eolDate qt latest)"
}

for i in flatpakKdePlatform freedesktopsdk golang kubernetes openwrt opnsense postmarketos qt; do
  ${i}
  check
done
