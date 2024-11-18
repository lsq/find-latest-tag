#!/usr/bin/env bash

set -x

if ! test $@; then
    echo "test: mismatch: $@"
    exit 1
else
    echo "test: matched: $@"
fi
