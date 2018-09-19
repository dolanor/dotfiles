#!/bin/bash

RB=${1:-$REVIEW_BASE}
vim -p $(git rfiles $RB) +"tabdo Gdiff $RB" +"let g:gitgutter_diff_base = '$RB'" 
