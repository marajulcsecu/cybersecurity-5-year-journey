#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="lab1a-suid-caps:latest"
CONTAINER_NAME="lab1a-suid-caps"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "${1:-}" in
  --clean)
    echo "[*] Removing container '${CONTAINER_NAME}'..."
    docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
    echo "[+] Clean."
    exit 0
    ;;
  --rebuild)
    echo "[*] Rebuilding '${IMAGE_NAME}' and resetting container..."
    docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
    docker build -t "${IMAGE_NAME}" "${SCRIPT_DIR}"
    ;;
  --root)
    if ! docker ps --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
      echo "[!] Container '${CONTAINER_NAME}' is not running. Run ./run_lab.sh first."
      exit 1
    fi
    echo "[*] Entering Defender shell (UID 0 root) inside '${CONTAINER_NAME}'..."
    exec docker exec -u root -it "${CONTAINER_NAME}" /bin/bash
    ;;
  "")
    ;;
  *)
    echo "Usage: $0 [--root | --rebuild | --clean]"
    exit 1
    ;;
esac

if ! docker image inspect "${IMAGE_NAME}" >/dev/null 2>&1; then
  echo "[*] Building ultra-lightweight Docker image '${IMAGE_NAME}'..."
  docker build -t "${IMAGE_NAME}" "${SCRIPT_DIR}"
fi

if ! docker ps -a --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
  echo "[*] Starting container '${CONTAINER_NAME}' (memory limit 128m)..."
  docker run -d --name "${CONTAINER_NAME}" --memory=128m -it "${IMAGE_NAME}" /bin/bash >/dev/null
elif ! docker ps --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
  echo "[*] Starting existing container '${CONTAINER_NAME}'..."
  docker start "${CONTAINER_NAME}" >/dev/null
fi

echo "[*] Entering Lab 1A as low-privilege user 'student'..."
echo "    Tip: Run './run_lab.sh --root' in another terminal for Defender hardening."
echo "    Tip: Run './run_lab.sh --clean' when finished to reset or free resources."
exec docker exec -u student -it "${CONTAINER_NAME}" /bin/bash
