#!/usr/bin/env bash

BRANCH=${1}

daedalus upgrade

git checkout $BRANCH
git pull update-ssh $BRANCH
