#!/bin/sh

bat \
	--theme="OneHalfDark" \
	--wrap="never" \
	--line-range=":$2" \
	"$1" || true
