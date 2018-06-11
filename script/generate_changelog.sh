#!/bin/env bash
TAG_VER=$1

os="$(uname -s)"

git branch -D changelog
git push origin --delete changelog
git checkout -B changelog

# Generate the CHANGELOG based on the tags
gren changelog --generate --override --tags=$TAG_VER -f CHANGELOG-$TAG_VER.md

case "${os}" in
    Darwin*)    sed '1s/^.*$/\'$'\n---/' CHANGELOG.md >> CHANGELOG-$TAG_VER.md;;
    *)          sed '1s/^.*$/\n---/' CHANGELOG.md >> CHANGELOG-$TAG_VER.md
esac

mv CHANGELOG-$TAG_VER.md CHANGELOG.md

# Since master is a protected branch, it commit to changelog branch and create a pull request
git add CHANGELOG.md
git commit -m "Update CHANGELOG for $TAG_VER"
git push -u origin changelog

# Craete pull request to merge the changelog into master
hub pull-request -m "Update CHANGELOG for $TAG_VER" -b master

git checkout master

# Generate GitHub release notes
gren release --tags=$TAG_VER
