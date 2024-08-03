#!/usr/bin/env bash

die () {
    echo "find-latest-tag.sh: $@"
    exit 1
}

repo=${1}
query=${2}
if [ -z "${query}" ]; then
    query=''
fi

if [ -z "${repo}" ]; then
  all_tags="$(git ls-remote --tags --heads --refs --exit-code --sort=-v:refname \
      | grep -oE 'refs/tags/(.+)$|refs/heads/(.+)$' \
      | sed 's/refs\/tags\///' \
      | sed 's/refs\/heads\///')"
    else
  all_tags="$(git ls-remote --tags --heads --refs --exit-code --sort=-v:refname "${repo}" \
      | grep -oE 'refs/tags/(.+)$|refs/heads/(.+)$' \
      | sed 's/refs\/tags\///' \
      | sed 's/refs\/heads\///')"
fi


tag="$(printf "%s\n" $all_tags \
    | grep -E "${query}" \
    | sort -V \
    | tail -1)"

if [ -z "${tag}" ]; then
    die "cannot find tag matching regex: ${2}"
fi

echo "tag=${tag}" >> $GITHUB_OUTPUT
