#!/usr/bin/env bash

# environment
# set -x

# entry
echo -e ""
echo "==============================================================="
echo "STAGE: Pipeline Status"
echo "==============================================================="

# pipeline result
if [ $# -ne 0 ]; then
   if [ "$1" = "0" ]; then
      echo "pipeline success"
   else
      echo "pipeline failed, check logs"
   fi
fi
