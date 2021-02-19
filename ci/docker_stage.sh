#!/bin/sh

set -e

dir_script=$(dirname $(readlink -f "$0"))
dir_root=$dir_script/../
dir_package=$(basename $(dirname $dir_script))
image_name=jozefhajnala/nhlapi
container_name=${dir_package}_check

docker run -id --name $container_name $image_name bash
docker cp $dir_root $container_name:/root

docker exec \
  --workdir /root/$dir_package \
  --env NHLAPI_REMOTE_TESTS=$NHLAPI_REMOTE_TESTS \
  --env NHLAPI_NHLAPI_SELECTED_TESTS=$NHLAPI_NHLAPI_SELECTED_TESTS \
  --env NHLAPI_TOKEN_CODECOV=$NHLAPI_TOKEN_CODECOV \
  --env RHUB_EMAIL=$RHUB_EMAIL \
  $container_name \
  Rscript "$@"

docker stop $container_name
docker rm -f $container_name
