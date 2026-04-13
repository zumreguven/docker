#!/bin/sh
set -eu

IMAGE_NAME="${IMAGE_NAME:-cicd-demo}"
CONTAINER_NAME="${CONTAINER_NAME:-cicd-demo-app}"
APP_PORT="${APP_PORT:-8080}"

if docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"; then
  docker rm -f "${CONTAINER_NAME}"
fi

docker run -d \
  --name "${CONTAINER_NAME}" \
  -p "${APP_PORT}:8080" \
  --restart unless-stopped \
  "${IMAGE_NAME}:latest"
