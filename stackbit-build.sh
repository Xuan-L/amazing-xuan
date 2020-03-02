#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e5d7b24c6d2cf001982305d/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e5d7b24c6d2cf001982305d 
fi
curl -s -X POST https://api.stackbit.com/project/5e5d7b24c6d2cf001982305d/webhook/build/ssgbuild > /dev/null
bundle install && bundle exec jekyll build
curl -s -X POST https://api.stackbit.com/project/5e5d7b24c6d2cf001982305d/webhook/build/publish > /dev/null
