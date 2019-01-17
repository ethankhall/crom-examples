#!/bin/bash -eux

CROM_EXEC=`realpath $1`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

declare -a arr=("example-1" "example-2")

CURRENT_VERSION="0.1.4"
NEXT_VERSION="0.1.5"

# Clean up working dir
# git --work-tree=$DIR reset --hard origin/master
# git --work-tree=$DIR checkout -- .

for i in "${arr[@]}"; do
    pushd $DIR/$i
    $CROM_EXEC update-version --override-version v0.1.0
done

# validate that current version is 
for i in "${arr[@]}"; do
    pushd $DIR/$i
    $CROM_EXEC update-version
    ./validate.sh $CURRENT_VERSION
done