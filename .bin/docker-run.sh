#!/bin/bash

CURDIR=`dirname $0`
source $CURDIR/functions

usage()
{
  echo "Usage:docker-run.sh [--image-version 1.0.0] ."
  echo "  --image-version 1.0.0 don't workdir VERSION file."
}


EXITCODE=0
PROGRAM=`basename $0`
VERSION=1.0.0

while test $# -gt 0
do
  case $1 in
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
if [ ! -z $IMAGE_FROM ]; then
  echo "--//    FROM: $IMAGE_FROM"
fi
echo "---------------------------------"

docker run --rm -it $IMAGE_TAG:$IMAGE_VERSION "$@"
