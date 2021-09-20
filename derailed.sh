#!/bin/bash
# Author:       sickcodes
# Contact:      https://twitter.com/sickcodes
# Copyright:    sickcodes (C) 2021
# License:      GPLv3+

! [ "${1}" ] && { echo "No target was specified. ./script.sh 'https://target/'" && exit 1 ; }

TARGET="${1}"

mkdir -p ./output

cd ./output

touch ./accessible.log

FILE_LIST=./files.md5.txt

# fetch an updated files.md5, if it comes in a future version
# curl "${TARGET}/files.md5" > ./files.md5

while read -r HASH SUFFIX; do
    echo "${SUFFIX}"
    TESTING_URL="${TARGET}/${SUFFIX}"
    echo "========= ${TESTING_URL} ========="

    # Ignore list, some of these files MAY be world readable,
    # if the organisation has modified permissions related 
    # to the below files otherwise, they are ignored.
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

    # feth the page, following redirects
    OUTPUT_DATA="$(curl -L -vvvv "${TESTING_URL}")"

    # continue any pages that are "denied access" or "direct script access"
    case "${OUTPUT_DATA}" in
        *'No direct script'* ) continue
            ;;
        *'Directory Listing Denied'* ) continue
            ;;
    esac

    # save all interesting pages, without forward slashes
    # https://www.target/
    # will be saved as:
    # https:::www.target:
    tee "${SUFFIX//\//\:}" <<< "${OUTPUT_DATA}"

    # print to stdout, and also append to ./accessible.log the successful saves
    tee -a ./accessible.log <<< "${TESTING_URL}"

done < "${FILE_LIST}"
