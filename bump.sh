#!/bin/sh

PKG="$1"
./outdated.sh | grep "^$PKG" | while read _ OVERLAY_VERSION REPO_VERSION; do 
	OVERLAY_PATH="$(echo overlay/*/$PKG)"
	NEW_CHECKSUM="$(grep '^checksum=' void-packages/srcpkgs/$PKG/template)"
	OLD_CHECKSUM="$(grep '^checksum=' "$OVERLAY_PATH/template")"
	sed -i "s/$OLD_CHECKSUM/$NEW_CHECKSUM/g" "$OVERLAY_PATH/template"

	NEW_VERSION="$(grep '^version=' void-packages/srcpkgs/$PKG/template)"
	OLD_VERSION="$(grep '^version=' "$OVERLAY_PATH/template")"
	sed -i "s/$OLD_VERSION/$NEW_VERSION/g" "$OVERLAY_PATH/template"

	NEW_REVISION="$(grep '^revision=' void-packages/srcpkgs/$PKG/template)"
	OLD_REVISION="$(grep '^revision=' "$OVERLAY_PATH/template")"
	sed -i "s/$OLD_REVISION/$NEW_REVISION/g" "$OVERLAY_PATH/template"
done
