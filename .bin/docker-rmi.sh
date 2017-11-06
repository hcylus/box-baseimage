#!/bin/bash

CURDIR=`dirname $0`
source $CURDIR/functions

usage()
{
  echo "Usage:docker-rmi [--image centos7 --version 1.0.0] ."
  echo "  --image centos7 rm image name."
  echo "  --tag 1.0.0 rm images version."
}

EXITCODE=0
PROGRAM=`basename $0`
VERSION=1.0.0

isEmpty ()
{
  if [ -z "$1" ]
  then
    echo "No untagged images found"
    exit 0
  fi
}

while test $# -gt 0
do
  case $1 in
    --image)
      shift
      if [ ! x$1 == x'' ]; then
        IMAGE_NAME=$1
      else
        error "Unrecognized option $1"
      fi
      ;;
    --tag)
      shift
      if [ ! x$1 == x'' ]; then
        IMAGE_TAG=$1
      else
        error "Unrecognized option $1"
      fi
      ;;
    --debug)
      DEBUG=true
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

IMAGES_ID=$(docker images -f "dangling=true" -q)

if [ -n "$IMAGE_NAME" ]; then
  IMAGES_ID=$(docker images --format '{{.Repository}}##{{.Tag}}=={{.ID}}' | grep "^.*$IMAGE_NAME.*##" | awk -F '==' '{print $2}')
fi

if [ -n "$IMAGE_TAG" ] && [ -n "$IMAGE_NAME" ]; then
  IMAGES_ID=$(docker images --format '{{.Repository}}##{{.Tag}}=={{.ID}}' | grep "^.*$IMAGE_NAME.*##" | grep "##.*$IMAGE_TAG*==" | awk -F '=='  '{print $2}')
fi

echo "--//INFO IMAGES_ID: ${IMAGES_ID}"

isEmpty $IMAGES_ID

for IMG in $IMAGES_ID
do
  echo "Removing image $IMG"
  CONTAINER_ID=$(docker ps -a | grep "$IMG" | awk '{print $1}')

  if [ -n "$CONTAINER_ID" ]
  then
    echo "--//stop container: $CONTAINER_ID"
    debug
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID
  fi
  debug
  docker rmi $IMG
done
