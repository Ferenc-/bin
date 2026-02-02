#!/usr/bin/env bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <image-name>"
    exit 1
fi
IMAGE_NAME=$1

TMP_PODMAN_SOCKET="/tmp/tmp_podman.sock"
podman system service --time=0 "unix://${TMP_PODMAN_SOCKET}" &
PODMAN_SYSTEM_SERVICE_PID="$!"
podman run --privileged -v "${TMP_PODMAN_SOCKET}:/var/run/docker.sock:Z" -v "${PWD}:${PWD}:Z" -v "${HOME}/.netrc:/root/.netrc:Z" -w "${PWD}" -it --entrypoint=/bin/sh "$IMAGE_NAME"
kill "${PODMAN_SYSTEM_SERVICE_PID}"
