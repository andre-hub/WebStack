#!/bin/sh
# WebStack is a minimal stack for modern web development.
#
# -------------------------------------------------------
gitNewRepository() {
    git init
    git config core.filemode false
    echo "node_modules" > .gitignore
}

installWebStack() {
	echo "download bower and install"
	npm install --save-dev bower
	echo "download gulp and install"
	npm install --save-dev gulp
	npm install --save-dev babel

	bowerbin="./node_modules/.bin/bower"
	bowerinstall="${bowerbin} install --save "

	echo "bower init"
	${bowerbin} init
	${bowerinstall} pure
	${bowerinstall} html5shiv
	${bowerinstall} validatejs
	${bowerinstall} react
}

getLicense() {
	licenseName=$1
	licenseUrl="https://raw.githubusercontent.com/andre-hub/markdown-licenses/master/"
	if [ ${licenseName} = "mit" ]; then
		licenseUrl="${licenseUrl}mit.md"
	fi
	if [ ${licenseName} = "bsd" ]; then
		licenseUrl="${licenseUrl}bsd-3.md"
	fi
	if [ ${licenseName} = "apache" ]; then
		licenseUrl="${licenseUrl}apache-v2.0.md"
	fi
	if [ ${licenseName} = "gpl3" ]; then
		licenseUrl="${licenseUrl}gnu-gpl-v3.0.md"
	fi
	if [ ${licenseName} = "public" ]; then
		licenseUrl="${licenseUrl}unlicense.md"
	fi
	curl -SsL ${licenseUrl} > LICENSE.md
}

showParameterError() {
	echo "error:"
	echo " -> accept only: $0 <project name> <license>"
	echo "    - licenses: mit, bsd, apache, gpl3, public"
}

if [ $# -eq 0 -o $# -eq 1 ]; then
	showParameterError
	exit 2
fi

mkdir $1
cd $1
gitNewRepository
getLicense $2
installWebStack
git add .
git commit -am "initial commit for $1"