#!/bin/sh
SEL=$(xrandr -q | grep "^[a-Z]" | grep -i " connected" | while read -r line; do
    #echo "check: $line"
    PROP=$(echo $line | awk '{print $3}')
    NAME=$(echo $line | awk '{print $1}')

    if [[ $PROP == "primary" ]]; then
        PROP=$(echo $line | awk '{print $4}')
    fi
    echo "$NAME - $PROP"

done | dmenu -p Monitor | sed 's/^.*- //')

DIM=$(echo $SEL | sed 's/+.*$//')
OFF=$(echo $SEL | sed 's/[0-9]*x[0-9]*//')

echo "$DIM $OFF"
