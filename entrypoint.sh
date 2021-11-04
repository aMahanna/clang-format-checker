#!/bin/sh -

SOURCES=()
UNFORMATTED_FILES=()
EXIT_STATUS=0

function log() {
    echo -e "[ gh-action ] :: $1"
}

function split_csv() {
    IFS=','
    csv_data="$1"
    local -n global_list_array="$2"
    for i in $csv_data; do
        if [ -f "$i" ]; then
            global_list_array+=("$i")
        fi
    done
    unset IFS
}

function check_file() {
    local file="$1"
    message="$(clang-format -n -Werror --ferror-limit=1 -style=file "${file}")"
    local status="$?"
    if [ $status -ne 0 ]; then
        echo "$message" >&2
        EXIT_STATUS=1
        return 1
    fi
    return 0
}

cd "$GITHUB_WORKSPACE" || exit 2
log "Action started"
log "Sources to check: $INPUT_SOURCES\n"
split_csv "$INPUT_SOURCES" SOURCES

for file in "${SOURCES[@]}"; do
    check_file "$file"
    if [ $? -ne 0 ]; then
        UNFORMATTED_FILES+=("$file")
    fi
done

if [ $EXIT_STATUS -eq 0 ]; then
    log "Congrats! The sources are clang formatted."
    exit 0
else
    log "Some file is not formatted correctly."
    log "You might want to run: "
    for ((i = 0; i < ${#UNFORMATTED_FILES[@]}; i++)); do
        if [ $i -ne 0 ]; then
            echo -n " && "
        fi
        echo "clang-format -style=file -i "${UNFORMATTED_FILES[$i]}" \\"
    done
    exit 1
fi