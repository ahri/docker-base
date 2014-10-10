#!/bin/sh

set -ue

addgroup --system --gid=415311 docker-group
adduser --system --uid=415311 --gid=415311 --no-create-home docker-user
