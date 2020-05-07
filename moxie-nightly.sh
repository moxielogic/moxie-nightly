#!/bin/sh

set -x

echo $(pwd)

SECRETS=$(curl -H "X-Vault-Token: $VAULT_MOXIEDEV_TOKEN" -X GET https://vault-labdroid.apps.ocp.labdroid.net/v1/secret/moxiedev)
echo $SECRETS | (umask 077 && jq -r .data.id_moxiedev_rsa > /tmp/id_rsa)

if [ $(cat /tmp/id_rsa) = "null" ]; then
    echo ERROR RETREIVING KEY FROM VAULT
    exit 1
fi

git config --global user.email "bot@moxielogic.com"
git config --global user.name "Moxie Bot"

export GIT_SSH_COMMAND="ssh -i /tmp/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

git clone --progress git@github.com:/atgreen/moxiedev-releng.git --recursive --shallow-submodules

cd moxiedev-releng

echo $(($(cat BUILDNUM)+1)) > BUILDNUM

git add *
git commit -m "Nightly update. $(date +%F-%T)"
git push
