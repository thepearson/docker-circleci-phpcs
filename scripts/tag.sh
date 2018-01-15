#!/bin/env bash

GIT=`which git`
REPO='.'
DATE_BASE=`date +%Y.%m.%d.`
SEARCH_STRING="${DATE_BASE}*"
START_REVISION=1

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
      -r|--repo)
      REPO="$2"
      shift
      shift
      ;;
      *)
      POSITIONAL+=("$1") # save it in an array for later
      shift
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

LAST_TAG=`${GIT} -C ${REPO} tag -l ${SEARCH_STRING} | sort | uniq | tail -n 1`

if [[ -z $LAST_TAG ]]
then
  REVISION=${START_REVISION}
else
  CURRENT_REVISION=`echo ${LAST_TAG} | awk -F\. '{ print $NF }'`
  REVISION="$((${CURRENT_REVISION}+1))"
fi

${GIT} -C ${REPO} tag "${DATE_BASE}${REVISION}"
echo "Tagged with: ${DATE_BASE}${REVISION}"
