#!/bin/bash

versionDiff=$( git diff HEAD^ HEAD -U0 package.json )
if ! [[ $versionDiff ]] || ! [[ $versionDiff =~ (\+ *\"version\":) ]]
then
  echo "Version didn't change"
  exit 0
fi

echo "::set-output name=changed::true"
echo "::set-output name=version::$( echo $versionDiff | grep -oP "\+ *\"version\":.+," | grep -oP "\d+\.\d+.\d+" )"
