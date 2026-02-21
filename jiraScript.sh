#!/usr/bin/env bash
BEARER_TOKEN=$(<~/.private/JIRA_TOKEN)

JQL_QUERY='assignee=currentUser()+AND+status+IN+("QA",+"In+Development",+"In+Progress")'
JQ_FILTER='.issues[] | .fields.status.name, .key, .fields.summary'

curl X GET \
  --silent \
  -H "Authorization: Bearer ${BEARER_TOKEN}" \
  -H "Content-Type: application/json" \
  "https://jsw.ibm.com/rest/api/latest/search?jql=${JQL_QUERY}" \
| jq --color-output "${JQ_FILTER}" \
| tr '\n' ' ' \
| xargs printf '%-26s | %s | %s\n' \
| sort --reverse
