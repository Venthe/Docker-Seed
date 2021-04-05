#!/usr/bin/env bash

git add "docker-compose/${1}"
git commit --message "Add ${1} as docker-compose"
