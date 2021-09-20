#!/bin/bash
# Author:       sickcodes
# Contact:      https://twitter.com/sickcodes
# Copyright:    sickcodes (C) 2021
# License:      GPLv3+

TARGET="${1}"

mkdir -p ./output

cd ./output

touch ./accessible.log

curl "${TARGET}/files.md5" > ./files.md5

while read -r HASH SUFFIX; do
    echo "${SUFFIX}"
    TESTING_URL="${TARGET}/${SUFFIX}"
    echo "========= ${TESTING_URL} ========="

    case "${SUFFIX}" in
        *'.php' ) continue
            ;;
        *'.html' ) continue
            ;;
        *'LICENSE' ) continue
            ;;
        *'README.md' ) continue
            ;;
        *'.js' ) continue
            ;;
        *'.svg' ) continue
            ;;
        *'.gif' ) continue
            ;;
        *'.png' ) continue
            ;;
        *'.css' ) continue
            ;;
        *'.exe' ) continue
            ;;
    esac

    OUTPUT_DATA="$(curl -L -vvvv "${TESTING_URL}")"

    case "${OUTPUT_DATA}" in
        *'No direct script'* ) continue
            ;;
        *'Directory Listing Denied'* ) continue
            ;;
    esac

    tee "${SUFFIX//\//\:}" <<< "${OUTPUT_DATA}"

    tee -a ./accessible.log <<< "${TESTING_URL}"

done < ./files.md5
