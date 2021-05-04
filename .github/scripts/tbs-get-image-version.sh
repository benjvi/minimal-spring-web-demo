#!/bin/bash
set -euo pipefail

# write kubeconfig file content to disk, and use it
kc_tmp="$(mktemp)"
echo "$KUBECONFIG_CONTENT" > "$kc_tmp"
export KUBECONFIG="$kc_tmp"

export TBS_IMAGE_NAME="minimal-spring-web-demo"
# avoid consistency issues with a small sleep
kp build logs angular-demo; sleep 1

# check if we attached to the correct build and it completed successfully, if not then fail
if [ "$( kp build status "$TBS_IMAGE_NAME" | grep Status | awk '{print $2}')" != "SUCCESS" ]; then
  echo "TBS image build failed"
  exit 1
elif [ "$( kp build status "$TBS_IMAGE_NAME" | grep Revision | awk '{print $2}')" != "$(git rev-parse HEAD)" ]; then
  echo "TBS image build is at a different version: $( kp build status "$TBS_IMAGE_NAME" | grep Revision | awk '{print $2}'), current version is $(git rev-parse HEAD)"
  exit 1
fi

export IMG_VERSION="$(kp image status "$TBS_IMAGE_NAME" | grep "LatestImage" | awk '{print $2}')"
echo "Latest image version: $IMG_VERSION"

rm "$kc_tmp"
