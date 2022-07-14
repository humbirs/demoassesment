#!/bin/bash

# Usage: ./displayImageTag.sh <remote-registry-prefix> <app-name>

prefix=$1
name=$2

if [ "$prefix" == "" ] || [ "$name" == ""]  ; then
        echo "Usage:
  $0 <path to docker file> <registry-prefix> <app-name>
where
    <registry-prefix> is the prefix  registry, e.g '10.101.210.100:5000/'
    <app-name> is the name of container image
"
        exit 1
fi


latestTag=`curl --insecure --silent http://$registry-prefix/v2/$app-name/tags/list  | sed -e 's/"//g' | sed -e 's/{name://g' | sed -e 's/]}//g' | sed -e 's/,tags://g' | tr -s '[' ' ' | awk '{ split($2,a,","); for (i in a) print $1, a[i]; }' | sed -e 's/ /:/g' | tail -1`

echo "Latest tag details is :: -> " $latestTag




#End of file

