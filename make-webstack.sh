#!/bin/sh
nodeVersion="0.12.5"
nodePath=node-v${nodeVersion}

# functions
CompileNode() {
	cd $1
	./configure
	make
	sudo make install
	cd ..
	rm -rf $1
}

DownloadNode() {
	nodeVersion=$1
	curl -SsL https://nodejs.org/dist/v${nodeVersion}/node-v${nodeVersion}.tar.gz  | tar -xzf -
}

MakeNpmAndInstall() {
	tmpPath=tmp-npm
	mkdir ${tmpPath}
	cd ${tmpPath}
	url=`(curl -SsL https://registry.npmjs.org/npm/$t; echo "") \
     | sed -e 's/^.*tarball":"//' \
     | sed -e 's/".*$//'`
     ret=$?
	if [ "x$url" = "x" ]; then
	  ret=125
	  # try without the -e arg to sed.
	  url=`(curl -SsL https://registry.npmjs.org/npm/$t; echo "") \
	       | sed 's/^.*tarball":"//' \
	       | sed 's/".*$//'`
	  ret=$?
	  if [ "x$url" = "x" ]; then
	    ret=125
	  fi
	fi
	if [ $ret -ne 0 ]; then
	  echo "Failed to get tarball url for npm/$t" >&2
	  exit $ret
	fi
	curl -SsL -f "$url" | tar -xzf -

	npm_config_prefix=./
	cd package
	./scripts/clean-old.sh
	configures="`env | grep 'npm_config_' | sed -e 's|^npm_config_||g'`"
	echo "$configures" > npmrc
	./configures
	sudo make uninstall install	
	sudo make install

	cd ..
	rm -rf ${tmpPath}
}

# --------------
# install script
# --------------
sudo ls

DownloadNode ${nodeVersion}
CompileNode node-v${nodeVersion}

MakeNpmAndInstall

if [ "$1" = "true" ]; then
	sudo npm install --global bower
	sudo npm install --global gulp
fi