# !/bin/bash
#sudo apt install jq -y
#sudo apt install curl -y
#curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
jq -r '.prices[][]' quotes.json | awk 'NR %2==0' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'
