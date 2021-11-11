#!/bin/bash

set -e

function log() {
    echo -e "[ gh-action ] :: $1"
}

cd "$GITHUB_WORKSPACE" || exit 2

if [ -z "$INPUT_SOURCES" ]
then
    log "\$INPUT_SOURCES is empty. Skipping Action..."
else
    log "Action started"
    log "Sources to check: $INPUT_SOURCES\n"
    clang-format -n -Werror -style=file $INPUT_SOURCES
fi