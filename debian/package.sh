#!/usr/bin/env bash

git clone https://github.com/tkluck/pac4cli.git

version() {
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

cd pac4cli

git submodule init
git submodule update

VERSION=$(version)

rm -rf .git
rm -rf pacparser/.git

cd ..

mv pac4cli pac4cli-${VERSION}

tar czf pac4cli_${VERSION}.orig.tar.gz pac4cli-1.0

cd pac4cli-${VERSION}

mkdir debian

echo "pac4cli (${VERSION}-1) UNRELEASED; urgency=low" > debian/changelog
echo -e "\n  * Initial release." >> debian/changelog
echo -e "\n  -- Khalid Eldehairy <khalid@kdehairy.com> Mon 05 Jun 2017 19:34:00 +0100" >> debian/changelog

echo "10" > debian/compat

echo "Source: pac4cli" > debian/control
echo "Maintainer: Khalid Eldehairy <khalid@kdehairy.com>" >> debian/control
echo "Section: misc" >> debian/control
echo "Priority: optional" >> debian/control
echo "Standards-Version: 3.9.2" >> debian/control
echo "Build-Depends: debhelper (>=9)" >> debian/control
echo -e "\nPackage: pac4cli" >> debian/control
echo "Architecture: all" >> debian/control
echo "Depends: python3-dev, python3-virtualenv, libsystemd-dev, libssl-dev" >> debian/control
echo "Description: Proxy-auto-discovery for command line applications" >> debian/control
