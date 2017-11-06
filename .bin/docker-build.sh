#!/bin/bash

CURDIR=`dirname $0`
source $CURDIR/functions

usage()
{
  echo "Usage:docker-build.sh [--base-image centos7 --image-version 1.0.0] ."
  echo "  --base-image centos7 update Dockerfile.template FROM instrument."
  echo "  --image-version 1.0.0 docker images version."
}


EXITCODE=0
PROGRAM=`basename $0`
VERSION=1.0.0

while test $# -gt 0
do
  case $1 in
    --base-image)
      shift
      if [ ! x$1 == x'' ]; then
        BASE_IMAGE=$1
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

DOCKERFILE=Dockerfile

if [ -n "${BASE_IMAGE}" ]; then
  if [ -z ${IMAGE_VERSION} ]; then
    error "please set --image-version."
  fi
fi

if [ -z $IMAGE_VERSION ]; then
  if [ ! -f ${WORKDIR}/VERSION ]; then
    error "${WORKDIR}/VERSION is not exits."
  else
    IMAGE_VERSION=$(cat ${WORKDIR}/VERSION)
  fi
else
  if [ -z ${BASE_IMAGE} ]; then
    DOCKERFILE=$DOCKERFILE.${IMAGE_VERSION}
  fi
fi

if [ ! -f ${WORKDIR}/TAG ]; then
  error "${WORKDIR}/TAG is not exits."
else
  IMAGE_TAG=$(cat ${WORKDIR}/TAG)
fi

if [ -n "$BASE_IMAGE" ]; then
  echo "--// update Dockerfile.template FROM instrument..."
  sed -r -e "s;FROM.*;FROM $BASE_IMAGE;g" \
    ${WORKDIR}/Dockerfile.template > ${WORKDIR}/Dockerfile
fi

if [ ! -f ${WORKDIR}/$DOCKERFILE ]; then
  error "${WORKDIR}/$DOCKERFILE is not exits."
fi

echo "---------------------------------"
echo "--//       tag: $IMAGE_TAG"
echo "--//   version: $IMAGE_VERSION"
echo "--//   WORKDIR: $WORKDIR"
echo "--//Dockerfile: $DOCKERFILE"
if [ ! -z $BASE_IMAGE ]; then
  echo "--//      FROM: $BASE_IMAGE"
fi
echo "---------------------------------"
docker build -t $IMAGE_TAG:$IMAGE_VERSION -f $WORKDIR/$DOCKERFILE $WORKDIR
