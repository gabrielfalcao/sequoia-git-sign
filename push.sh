#!/usr/bin/env bash

./commit.sh
git remote add origin git@github.com:gabrielfalcao/sequoia-git-sign.git
git push -f origin main
