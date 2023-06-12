#!/usr/bin/env bash

buildah --creds=${2} push $1 "docker://${1}"