#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

usage () {
    echo "running test"
    echo $(basename ${0})
}

usage

cd build
make test