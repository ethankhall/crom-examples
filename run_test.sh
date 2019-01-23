#!/bin/bash -eux

CROM_EXEC=`realpath $1`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

declare -a arr=("example-1" "example-2" "example-3")

CURRENT_VERSION="0.1.4"
NEXT_VERSION="0.1.5"

# Set the version to always be v0.1.0, this way the working dir should always have a change
for i in "${arr[@]}"; do
    pushd $DIR/$i
    $CROM_EXEC update-version --override-version v0.1.`date +%s` 
done

# validate that current version is 
for i in "${arr[@]}"; do
    pushd $DIR/$i
    $CROM_EXEC update-version --pre-release none
    ./validate.sh $CURRENT_VERSION
done

# validate that updated version is 
for i in "${arr[@]}"; do
    pushd $DIR/$i
    $CROM_EXEC update-version --pre-release snapshot
    ./validate.sh "$NEXT_VERSION-SNAPSHOT"
done

# validate that updated version is 
for i in "${arr[@]}"; do
    pushd $DIR/$i
    $CROM_EXEC update-version --pre-release release
    ./validate.sh "$NEXT_VERSION"
done
