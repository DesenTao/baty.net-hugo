# Thanks to http://themainthread.com/blog/2014/11/jekyll-new-post-script.html
DATE=`date +%Y-%m-%d`
DATETIME=`date +%Y-%m-%dT%H:%M:%S-04:00`
YEAR=`date +%Y`
FILE=content/post/$YEAR/$DATE-$SLUG.md
TITLE=$1


shift 2

cat > $FILE <<- EOM
---
title: "$TITLE"
slug: "${SLUG}"
date: "${DATETIME}"
tags: ["$@"]
draft: false
description:
---
EOM

vim $FILE
