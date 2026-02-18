#!/usr/bin/env bash
USER="$(<~/.private/GHE_RO_USER_NAME)"
# TODO: Fine grained over classic
PAT="$(<~/.private/GHE_RO_PAT)"
HOST="$(<~/.private/GHE_HOST)"
JQ_FILTER='.items[] | .repository_url, .number, .title'

#echo -e '\033[32m' # Switch to green output color
curl --silent \
     -H "Authorization: Bearer ${PAT}" \
     -H "Accept: application/vnd.github+json" \
     -H "X-GitHub-Api-Version: 2022-11-28" \
     "https://api.${HOST}/search/issues?q=is:pr+is:open+author:${USER}" \
| jq --raw-output "${JQ_FILTER}" \
| while read V1 && read V2 && read V3; do V1="${V1##*/repos/}"; echo "${V1}${V2}${V3}"; done \
| sort --reverse \
| column --separator '' --table --table-columns 'REPO,PR #,TITLE'

#echo -e '\033[0m' # Switch back to default
