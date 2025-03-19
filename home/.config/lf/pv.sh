#!/bin/sh

bat \
  --theme="OneHalfDark" \
  --line-range=":$2" \
  "$1" || true
