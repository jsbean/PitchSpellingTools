#!/bin/bash

jazzy \
  --clean \
  --author James Bean \
  --author_url http://jamesbean.info \
  --github_url https://github.com/dn-m/ArrayTools \
  --module-version 1.0.1 \
  --module ArrayTools \
  --root-url https://dn-m.github.io \
  --output ../site/ArrayTools \
  --skip-undocumented \
  --hide-documentation-coverage \
  --theme fullwidth

