#!/bin/sh
set -xe
gcloud auth activate-service-account --key-file /key/key.json
gcloud config set project $PROJECT_NAME
gcloud compute disks snapshot $DISK_NAME --zone=$ZONE --snapshot-names="$DISK_NAME-$(date +'%Y-%m-%d-%H-%M-%S')"
