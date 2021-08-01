#!/bin/bash
RESULT=$(echo "$(cat <<EOF
Your username $(hostname)
Your password 
Your current host $(hostname) 
EOF
)")
echo $RESULT
