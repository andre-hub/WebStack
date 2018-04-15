#!/bin/sh
# WebStack is a minimal stack for modern web development.
#
# -------------------------------------------------------
gitNewRepository() {
    git init
    git config core.filemode false
    echo "node_modules\r\nbower_components\r\ndist" > .gitignore
}

installNpmPkg() {
	npm install --save-dev $1
}

bowerBin() {
	bowerbin="./node_modules/.bin/bower"
	${bowerbin} $1
}

installBowerPkg() {
	bowerinstall="install --save "
	bowerBin "${bowerinstall} $1"
}

installWebStack() {
	echo "download bower and install"
	installNpmPkg "bower"
	installNpmPkg "process-nextick-args"
	installNpmPkg "inherits"
	installNpmPkg "core-util-is"
	installNpmPkg "isarray"
	echo "download gulp and install"
	installNpmPkg "gulp"
	installNpmPkg "gulp-sourcemaps"
	installNpmPkg "gulp-babel"
	installNpmPkg "gulp-jsx"
	installNpmPkg "gulp-minify-css"
	installNpmPkg "gulp-jshint"
	installNpmPkg "gulp-concat"
	installNpmPkg "gulp-rename"
	installNpmPkg "gulp-uglify"
	installNpmPkg "gulp-util"
	installNpmPkg "gulp-livereload"
 
	echo "bower init"
	bowerBin init
	installBowerPkg material-design-lite # other example: pure
	installBowerPkg html5shiv	
	installBowerPkg lodash	
	installBowerPkg validatejs	
	installBowerPkg react

	downloadFile "files/gulpfile-example.js" "gulpfile.js"
	downloadFile "files/jshintrc" ".jshintrc"
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

downloadTemplateFiles() {
	targetPath="src"
	mkdir $targetPath
	downloadFile "files/index.html" "src/index.html"
	targetJsPath="$targetPath/js"
	
	mkdir $targetJsPath
	downloadFile "files/js/index.js" "src/js/index.js"
}

downloadFile() {
	filesUrl="https://raw.githubusercontent.com/andre-hub/WebStack/master"
	curl -SsL $filesUrl/$1 >> $2
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
downloadTemplateFiles
git add .
git commit -am "initial commit for $1"