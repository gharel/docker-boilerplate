#!/bin/sh

set -e

cmd="$@"

echo "Wait for node modules install..."

until [ -f ./node_modules/.install-done ]
do
  sleep 1
done

echo "Success: node modules install is done"
exec $cmd
