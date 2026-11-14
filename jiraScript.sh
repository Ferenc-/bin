#!/usr/bin/env bash
OAUTH_TOKEN=$(<~/.private/JIRA_TOKEN)

JQL_QUERY='assignee=currentUser()+AND+status+IN+("QA",+"In+Development",+"In+Progress")'
JQ_FILTER='.issues[] | .fields.status.name, .key, .fields.summary'

curl X GET \
  --silent \
  -H "Authorization: OAuth ${OAUTH_TOKEN}" \
  -H "Content-Type: application/json" \
  "https://ibm-software.atlassian.net/rest/api/3/search/jql?jql=${JQL_QUERY}" |
  jq --color-output "${JQ_FILTER}" |
  tr '\n' ' ' |
  xargs printf '%-26s | %-23s | %s\n' |
  sort --reverse
