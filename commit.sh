#!/usr/bin/env bash

rm -rf .git;git init;git add .;rm -rf logs commits

export GIT_TRACE=1

if git commit -v -am 'foo' --gpg-sign; then
    echo -e "\033[1;32mSUCESS!\033[0m"
else
    echo -e "\033[1;31mFAILED\033[0m"
    cat logs/sequoia-git*.log | jq .command | tr -d '"'
fi


#cat logs/sequoia-git.log | jq
#git status
