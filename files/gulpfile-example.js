'use strict';

// Include Gulp & Tools
var gulp = require('gulp');
var gulpbabel = require('gulp-babel');
var sourcemaps = require('gulp-sourcemaps');
var minifycss = require('gulp-minify-css');
var rename = require('gulp-rename');
var concat = require('gulp-concat');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var gutil = require('gulp-util');
var livereload = require('gulp-livereload');

var externalLibsCopys = [
    'bower_components/html5shiv/dist/html5shiv.min.js',
    'bower_components/html5shiv/dist/html5shiv-printshiv.min.js',
    ];
var externalLibs = [
      'bower_components/lodash/lodash.min.js',
      'bower_components/material-design-lite/material.min.js',
      'bower_components/react/react-with-addons.min.js',
      'bower_components/react/JSXTransformer.js',
      'bower_components/validatejs/validate.min.js'
      ];

gulp.task('default', function() {
  lintTask();
});

gulp.task('build', function() {
  lintTask();
  copyFilesTask();
  buildTask();
});

var buildTask = function() {
  gulp.src(externalLibsCopys)
    .pipe(gulp.dest('dist/js'))
    .on('end', function(){ gutil.log('copy EXTERNAL LIBS finish\r\n'); });

  gulp.src(externalLibs)
    .pipe(concat('libs.min.js'))
    .pipe(gulp.dest('dist/js'))
    .on('end', function(){ gutil.log('EXTERNALLIBS finish\r\n'); });

  gulp.src('src/**/*.js')
    .pipe(sourcemaps.init())
    .pipe(jshint('.jshintrc'))
    .pipe(jshint.reporter('default'))
    .pipe(gulpbabel())
    .pipe(uglify())
    .pipe(concat('scripts.min.js'))
    .pipe(sourcemaps.write('../maps',{addComment: true}))
    .pipe(gulp.dest('dist/js'))
    .on('end', function(){ gutil.log('BUILD finish\r\n'); });
};

var copyFilesTask = function () {
  gulp.src('src/**/*.html')
    .pipe(gulp.dest('dist'))
    .on('end', function(){ gutil.log('copy HTML files finish\r\n'); });

  gulp.src('src/**/*.css')
    .pipe(minifycss())
    .pipe(gulp.dest('dist/css'))
    .on('end', function(){ gutil.log('copy CSS files finish\r\n'); });
};

var lintTask = function () {
    gulp.src('/src/**/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter('default', { verbose: true }));
};

/*
gulp.task('watch', function() {
  // Create LiveReload server
  livereload.listen();
  // Watch any files in dist/, reload on change
  gulp.watch(['dist/**']).on('change', livereload.changed);
});*/