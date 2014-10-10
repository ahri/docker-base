#!/bin/sh
name="ahri/base"
version="0.0.1"

tag="$name:$version"
docker build -t $tag .
docker tag $tag $name:latest
