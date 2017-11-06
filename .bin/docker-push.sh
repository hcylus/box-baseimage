#!/bin/bash

CURDIR=`dirname $0`
source $CURDIR/functions

usage()
{
  echo "Usage:docker-push.sh [--registry-host hub.opstack.xyz --image-version 1.0.0] ."
  echo "  --registry-host hub.opstack.xyz docker push registry host. "
  echo "  --image-version 1.0.0 don't workdir VERSION file. "
}

EXITCODE=0
PROGRAM=`basename $0`
VERSION=1.0.0

while test $# -gt 0
do
  case $1 in
    --registry-host)
      shift
      if [ ! x$1 == x'' ]; then
        REGISTRY_HOST=$1
      else
        error "Unrecognized option $1"
      fi
      ;;
    --image-version)
      shift
      if [ ! x$1 == x'' ]; then
        IMAGE_VERSION=$1
      else
        error "Unrecognized option $1"
      fi
      ;;
    --help | --hel | --he | --h | '--?' | -help | -h | '-?')
      usage_and_exit 0
      ;;
    --version | -v )
      version
      exit 0
      ;;
    -*)
      error "Unrecognized option $1"
      ;;
    *)
      break
      ;;
  esac
  shift
done

if [ -z $1 ]; then
  error "--//ERR: please set workdir"
fi

WORKDIR=$(pwd)/$1
shift

if [ -z $IMAGE_VERSION ]; then
  if [ ! -f ${WORKDIR}/VERSION ]; then
    error "${WORKDIR}/VERSION is not exits."
  else
    IMAGE_VERSION=$(cat ${WORKDIR}/VERSION)
  fi
fi

if [ ! -f ${WORKDIR}/TAG ]; then
  error "${WORKDIR}/TAG is not exits."
else
  IMAGE_TAG=$(cat ${WORKDIR}/TAG)
fi

echo "---------------------------------"
echo "--//     tag: $IMAGE_TAG"
echo "--// version: $IMAGE_VERSION"
echo "--// WORKDIR: $WORKDIR"
if [ -n "${REGISTRY_HOST}" ]; then
  echo "--//REGISTRY: $REGISTRY_HOST"
fi
echo "---------------------------------"


if [ -n "$REGISTRY_HOST" ]; then
  echo "docker tag: $IMAGE_TAG:$IMAGE_VERSION $REGISTRY_HOST/$IMAGE_TAG:$IMAGE_VERSION"
  docker tag $IMAGE_TAG:$IMAGE_VERSION $REGISTRY_HOST/$IMAGE_TAG:$IMAGE_VERSION
  echo "docker push: $REGISTRY_HOST/$IMAGE_TAG:$IMAGE_VERSION"
  docker push $REGISTRY_HOST/$IMAGE_TAG:$IMAGE_VERSION
else
  docker push $IMAGE_TAG:$IMAGE_VERSION
fi
