#!/bin/sh

bat \
	--theme="ansi" \
	--wrap="never" \
	--line-range=":$2" \
	"$1" || true
