#!/bin/bash
echo Checking if there are open pull requests for the repository
echo "####################################"
echo Write user
read user
echo Write repo
read repo
url="https://api.github.com/repos/$user/$repo/pulls?state=open"
c=`curl -s -H "Accept: application/vnd.github.v3+json" $url | jq .[]`
if [ -n "$c" ]; then
	echo "####################################"
	echo The list of the most productive contributors 
	curl -s -H "Accept: application/vnd.github.v3+json" $url > git.json
	jq -r 'group_by(.user.login)[] | {login: (.[0].user.login), urls: [.[] | .url]} | select(.urls | length > 1) | .login' git.json
	echo "####################################"
	echo The number of PRs each contributor  has created wuth the labes 
	jq -r 'group_by(.user.login)[] | {login: (.[0].user.login), urls: [.[] | .url ] | length, "labels": [.[] | .labels] | flatten }' git.json
else 
        echo empty
fi

