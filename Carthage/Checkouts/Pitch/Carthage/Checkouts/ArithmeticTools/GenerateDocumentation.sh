#!/bin/bash

VERSION=$(git describe --tags $(git rev-list --tags --max-count=1))
NAME=${PWD##*/}

jazzy \
  --clean \
  --author James Bean \
  --author_url http://jamesbean.info \
  --github_url https://github.com/dn-m/$NAME \
  --module-version $VERSION \
  --module $NAME \
  --root-url https://dn-m.github.io \
  --output ../site/$NAME \
  --skip-undocumented \
  --hide-documentation-coverage \
  --theme fullwidth
