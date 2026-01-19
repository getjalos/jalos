#!/bin/bash
set -e

IMAGE_NAME="jalos-builder"
LIVE_DIR="$(cd "$(dirname "$0")" && pwd)/live"

# Build the container image if needed
if ! podman image exists "$IMAGE_NAME" 2>/dev/null; then
    echo "Building container image..."
    podman build -t "$IMAGE_NAME" "$(dirname "$0")"
fi

CMD="${@:-/bin/bash}"

exec podman run --rm -it --privileged \
    -v "$LIVE_DIR":/build:Z \
    "$IMAGE_NAME" \
    $CMD