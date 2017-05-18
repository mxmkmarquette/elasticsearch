#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

started=0
host=$1
max_try=$2
wait_seconds=$3

for i in $(seq 1 "${max_try}"); do
    if curl -s "${host}:9200" &> /dev/null; then
        started=1
        break
    fi
    echo 'Elasticsearch is starting...'
    sleep "${wait_seconds}"
done

if [[ "${started}" -eq '0' ]]; then
    echo >&2 'Error. Elasticsearch is unreachable.'
    exit 1
fi

echo 'Elasticsearch has started!'
