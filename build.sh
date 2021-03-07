#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

usage () {
    echo "create build dir"
    echo "create makefile"
    echo $(basename ${0})
}

usage

DIR=build
if [ -d ${DIR} ]; then rm -Rf ${DIR}; fi
mkdir ${DIR}
cd build
cmake ..
make

