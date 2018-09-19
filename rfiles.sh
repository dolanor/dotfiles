#!/bin/bash

RB=${1:-$REVIEW_BASE}
git diff --name-only "$RB" | xargs -I{} realpath --relative-to=. $(git rev-parse --show-toplevel)/'{}'
