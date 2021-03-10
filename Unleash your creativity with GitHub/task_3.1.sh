#!/bin/bash
echo Write user
read user
echo Write repo
read repo
echo Most popular issues about this repository:
url="https://api.github.com/repos/$user/$repo/issues?state=closed&sort=comments&direction=desc&per_page=5"
curl -s -H "Accept: application/vnd.github.v3+json" $url | jq 'map({"author": .user.login, issue: .url, "count_comments": .comments})[]'

