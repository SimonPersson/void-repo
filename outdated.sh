#!/bin/sh
cd void-packages && git reset --hard HEAD --quiet && git pull --quiet && cd ..
find overlay -name template | while read template; do
  VERSION=$(grep '^version=' "$template" | cut -d= -f2-)
  PKG=$(grep '^pkgname=' "$template" | cut -d= -f2-)
  REVISION=$(grep '^revision=' "$template" | cut -d= -f2-)
  REPO_VERSION=$(grep '^version=' void-packages/srcpkgs/$PKG/template 2>/dev/null | cut -d= -f2-)
  REPO_REVISION=$(grep '^revision=' void-packages/srcpkgs/$PKG/template 2>/dev/null | cut -d= -f2-)
  [ "$VERSION-$REVISION" != "$REPO_VERSION-$REPO_REVISION" ] && [ -n "$REPO_VERSION" ] && echo $PKG $VERSION-$REVISION $REPO_VERSION-$REPO_REVISION
done
