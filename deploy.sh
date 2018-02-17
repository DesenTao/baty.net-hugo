#!/bin/bash

# Called by easy-hugo from emacs


echo -e "\033[0;32mDeploying updates to DigitalOcean...\033[0m"
hugo
git add -A

msg="rebuilding site `LANG=C date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master

rsync -v -rz -e "ssh -l serverpilot" --checksum --delete --no-perms public/ do.baty.net:/srv/users/serverpilot/apps/batydotnet/public/
