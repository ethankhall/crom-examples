#!/bin/bash -eu

EXPECTED_VERSION=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

VERSION=`grep "<version>" pom.xml | sed 's/[<>a-z/]*>//g' | sed 's/ *//g'`

if [ "$EXPECTED_VERSION" != "$VERSION" ]; then
    echo "There was a mismatch between $EXPECTED_VERSION and $VERSION"
    exit 1
fi
exit 0

