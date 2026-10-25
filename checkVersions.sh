#!/bin/bash

eolDate() {
  eolDateWithCycleIndex "${1}" '0' "${2}"
}

eolDateWithCycleIndex() {
  curl -s "https://endoflife.date/api/${1}.json" | jq -r ".[${2}].${3}"
}

check() {
  if [ "${CURRENT}" != "${LATEST}" ]; then
    echo -e "\033[31mNew ${NAME} version available: ${LATEST} (current: ${CURRENT})\033[0m"
  else
    echo -e "\033[32m${NAME} version is already the latest ${LATEST}\033[0m"
  fi
}

QT_CYCLE='6.11'

flatpakKdePlatform() {
  NAME="org.kde.Platform//${QT_CYCLE}"
  CURRENT='2026-10-24'
  LATEST="$(flatpak --user remote-info --log flathub org.kde.Platform//${QT_CYCLE} | awk '/Date:/{ print $2; exit}')"
}

flatpakKdePlatformQt() {
  NAME="Qt in org.kde.Platform//${QT_CYCLE}"
  CURRENT="$(flatpak run --devel --command=qmake org.kde.Sdk//${QT_CYCLE} --version | awk '/Qt version/{print $4}')"
  LATEST="$(eolDateWithCycleIndex qt 1 latest)"
}

freedesktopsdk() {
  NAME="Freedesktop SDK"
  CURRENT='26.08'
  LATEST="$(eolDate freedesktop-sdk cycle)"
}

golang() {
  NAME="Golang"
  CURRENT='1.27.3'
  LATEST="$(eolDate go latest)"
}

kubernetes() {
  NAME="Kubernetes"
  CURRENT='1.37.1'
  LATEST="$(eolDate kubernetes latest)"
}

opnsense() {
  NAME='OPNSense'
  CURRENT='26.7.7'
  LATEST="$(eolDate opnsense latest)"
}

openwrt() {
  NAME='OpenWrt'
  CURRENT='25.12.6'
  LATEST="$(eolDate openwrt latest)"
}

nura() {
  NAME='Nura'
  CURRENT='26.06'
  LATEST="$(eolDate nura cycle)"
}

for i in flatpakKdePlatform flatpakKdePlatformQt freedesktopsdk golang kubernetes openwrt opnsense nura; do
  ${i}
  check
done
