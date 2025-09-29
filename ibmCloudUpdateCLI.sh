#!/usr/bin/env bash

set -euo pipefail

init_vars () {
  TARGET_DIR=$(dirname $(readlink "$(which ibmcloud)"))
  BACKUP_DIR=$(mktemp --dry-run --directory "${TARGET_DIR}_backup_XXXX")
  LATEST_VERSION="$(curl -s https://api.github.com/repos/IBM-Cloud/ibm-cloud-cli-release/releases | jq --raw-output '.[0].tag_name')"
  # Remove "v" prefix
  LATEST_VERSION="${LATEST_VERSION:1}"
}

fetch () {
  # Use the binary release instead of the installer release
  curl "https://download.clis.cloud.ibm.com/ibm-cloud-cli/${LATEST_VERSION}/binaries/IBM_Cloud_CLI_${LATEST_VERSION}_linux_amd64.tgz" \
    --output "/tmp/IBM_Cloud_CLI_${LATEST_VERSION}_amd64.tar.gz"
}

backup_previous () {
  mv "${TARGET_DIR}" "${BACKUP_DIR}"
  echo "Backup is in '${BACKUP_DIR}'"
}

install_latest () {
  # The target dir is already contained in the tar so go one level up
  tar -xf "/tmp/IBM_Cloud_CLI_${LATEST_VERSION}_amd64.tar.gz" -C "$(dirname ${TARGET_DIR})"
  rm "/tmp/IBM_Cloud_CLI_${LATEST_VERSION}_amd64.tar.gz"
}

init_vars
fetch
backup_previous
install_latest
