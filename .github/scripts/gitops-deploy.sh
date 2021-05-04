#!/bin/bash
set -euo pipefail
echo 'Deploying....'

export KEYFILE="$(mktemp)"
echo "$APPS_GITOPS_GIT_DEPLOY_KEY" > "$KEYFILE"
cd /
GIT_SSH_COMMAND='ssh -i "$KEYFILE" -o IdentitiesOnly=yes -o StrictHostKeyChecking=no' git clone git@github.com:benjvi/apps-gitops.git
cd -

APP_NAME="spring-app"
IMAGE_NAME="minimal-spring-web-demo"
CURRENT_IMG_TAG="$(cat current-image-tag)"
echo "current image tag: $CURRENT_IMG_TAG"

cd k8s
# need to set the reference to the published image in the manifest, note this is specific to:
# (1) our use of kustomize manifests in this repo (2) use of TBS
kustomize edit set image "index.docker.io/benjvi/$IMAGE_NAME=${CURRENT_IMG_TAG}"
# rendering of the manifests to deal with *app specific customizations*, note this is specific to our choice of packaging
# TODO: add kshard in here
kustomize build . > "/apps-gitops/nonprod-cluster/${APP_NAME}/ci-package.yml"
cd -

# add empty kustomize config to nonprod gitops fodler
# reasons to use kustomize in the gitops repo is not yet clear in this simple example, but will be useful when envs have different convifgs
cd "/apps-gitops/nonprod-cluster/${APP_NAME}"
kustomize create || true; kustomize edit add resource ci-package.yml
cd -

# need some details set in env for prify to work correctly
# not all context is kept between sh commands, so use a one liner
cd /apps-gitops/nonprod-cluster/
git config user.email "benjvi.github.io@ghactions"
git config user.name "GH Actions CI Bot - Blog"
GIT_SSH_COMMAND='ssh -i "$KEYFILE" -o IdentitiesOnly=yes -o StrictHostKeyChecking=no' prify run
rm $KEYFILE 
