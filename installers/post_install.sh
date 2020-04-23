#!/bin/bash
set -e

cp /home/installers/bash_git_prompt.sh /root/.bash_git_prompt.sh
echo "source /root/.bash_git_prompt.sh" >> /root/.bashrc


rm -rf /var/lib/apt/lists/* 
