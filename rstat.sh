#!/bin/bash

RB=${1:-$REVIEW_BASE}
git diff --stat "$RB"
