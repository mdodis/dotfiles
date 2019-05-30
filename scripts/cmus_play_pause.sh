#!/bin/sh
if pgrep -x cmus ; then
    cmus-remote -u
fi
