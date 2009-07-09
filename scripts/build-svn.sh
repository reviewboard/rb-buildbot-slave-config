#!/bin/sh

for dirname in lib/python*; do
	PYTHON=`basename $dirname`
	SITE_PACKAGES="lib/$PYTHON/site-packages"

	if test "$PYTHON" = "python2.6"; then
		PACKAGE_NAME="pysvn-1.6.3"
	else
		PACKAGE_NAME="pysvn-1.6.2"
	fi

	FILENAME="$PACKAGE_NAME.tar.gz"
	DOWNLOAD_URL="http://pysvn.barrys-emacs.org/source_kits/$FILENAME"

	if test ! -e "$FILENAME" -o ! -e $SITE_PACKAGES/pysvn; then
		wget $DOWNLOAD_URL -O $FILENAME
		tar -xzvf $FILENAME
		cd $PACKAGE_NAME/Source
		$PYTHON setup.py configure || exit 1
		make || exit 1
		mv pysvn ../../$SITE_PACKAGES || exit 1
	fi
done
