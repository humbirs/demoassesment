#!/bin/bash
#
# Usage: ./build.sh </dir/to/dockerfile> <remote-registry-prefix> <app-name>

dir=$1
prefix=$2
name=$3


if [ "$dir" == "" ] || [ ! -d "$dir" ] || [ "$prefix" == "" ] || [ "$name" == ""]  ; then
        echo "Usage:
  $0 <path to docker file> <registry-prefix> <app-name>
where
    <registry-prefix> is the prefix  registry, e.g '10.101.210.100:5000/'
    <app-name> is the name of container image
"
        exit 1
fi

if [[ $EUID -ne 0 ]]; then
    echo "This script might need root permissions to run..."
fi


# determine the names we should use for the docker-registry...
dir=$(echo "$dir" | sed -r 's#/$##g')
remote_name=$(echo "$prefix/$name" | sed -r 's#/+#/#g')

git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then

  tag=`git reflog | head -1 | awk '{print $1}'`

else

  echo "git is not avilable at server from build.sh is ran, setting tag via $RANDOM "
  tag=$RANDOM

fi

echo "About to run build command ::: ->> " 'docker build' $dir -t $name:$tag -t $remote_name:$tag
        docker build $dir -t $name:$tag -t $remote_name:$tag
echo "Pushing image to registry :: ->>  "  'docker push' "$remote_name:$tag"
        docker push $remote_name:$tag



## End of file

