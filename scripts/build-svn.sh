#!/bin/sh

PACKAGE_NAME="pysvn-1.6.3"
FILENAME="$PACKAGE_NAME.tar.gz"
DOWNLOAD_URL="http://pysvn.barrys-emacs.org/source_kits/$FILENAME"

for dirname in lib/python*; do
	PYTHON=`basename $dirname`
	SITE_PACKAGES="lib/$PYTHON/site-packages"

	if test ! -e "$FILENAME" -o ! -e $SITE_PACKAGES/pysvn; then
		wget $DOWNLOAD_URL -O $FILENAME
		tar -xzvf $FILENAME
		cd $PACKAGE_NAME/Source
		$PYTHON setup.py backport
		$PYTHON setup.py configure || exit 1
		make || exit 1
		mv pysvn ../../$SITE_PACKAGES || exit 1
	fi
done
