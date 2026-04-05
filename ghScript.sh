#!/usr/bin/env bash
PAT="$(<~/.private/GH_RO_PAT)"
JQ_FILTER='.items[] | .repository_url, .number, .title'
USER="Ferenc-"

#echo -e '\033[32m' # Switch to green output color
curl --silent \
     -H "Authorization: Bearer ${PAT}" \
     -H "Accept: application/vnd.github+json" \
     -H "X-GitHub-Api-Version: 2022-11-28" \
     "https://api.github.com/search/issues?q=archived:false+is:pr+is:open+author:${USER}" |
     jq --raw-output "${JQ_FILTER}" |
     while read V1 && read V2 && read V3; do
          V1="${V1##*/repos/}"
          echo "${V1}${V2}${V3}"
     done |
     #    sort --reverse |
     column --separator '' --table --table-columns 'REPO,PR #,TITLE'

#echo -e '\033[0m' # Switch back to default
