# Thanks to http://themainthread.com/blog/2014/11/jekyll-new-post-script.html
DATE=`date +%Y-%m-%d`
DATETIME=`date +%Y-%m-%dT%H:%M:%S-04:00`
YEAR=`date +%Y`
SLUG=$1
FILE=content/post/$YEAR/$DATE-$SLUG.md
TITLE=$2


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
