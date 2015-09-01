var gulp = require('gulp');
var gulpbabel = require('gulp-babel');
var sourcemaps = require('gulp-sourcemaps');
var minifycss = require('gulp-minify-css');
var rename = require('gulp-rename');
var concat = require('gulp-concat');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var notify = require('gulp-notify');
var livereload = require('gulp-livereload');

gulp.task('default', function() {
  lintPipe();
  gulp.src('src/**/*.js')
    .pipe(notify({ message: 'build check started' }))
    .pipe(sourcemaps.init())
    .pipe(gulpbabel())
    .pipe(jshint('.jshintrc'))
    .pipe(jshint.reporter('default'))
    .pipe(notify({ message: 'build check finish' }));
});

gulp.task('build', function() {
  lintPipe();
  gulp.src('src/**/*.js')
    .pipe(notify({ message: 'Build started' }))
    .pipe(sourcemaps.init())
    .pipe(gulpbabel())
    .pipe(jshint('.jshintrc'))
    .pipe(jshint.reporter('default'))
    .pipe(gulp.dest('dist/assets/js'))
    .pipe(rename({suffix: '.min'}))
    .pipe(uglify())
    .pipe(gulp.dest('dist/assets/js'))
    .pipe(minifycss())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('dist'))
    .pipe(notify({ message: 'Scripts task complete' }));
});

gulp.task('lint', function() {
  lintPipe();
});

var lintPipe = function () {
    gulp.src('/src/**/*.js')
    .pipe(notify({ message: 'Lint started' }))
    .pipe(jshint())
    .pipe(notify(function (file) {
      if (file.jshint.success) {
        return false;
      }

      var errors = file.jshint.results.map(function (data) {
        if (data.error) {
          return "(" + data.error.line + ':' + data.error.character + ') ' + data.error.reason;
        }
      }).join("\n");
      return file.relative + " (" + file.jshint.results.length + " errors)\n" + errors;
    }));
}
/*
gulp.task('watch', function() {
  // Create LiveReload server
  livereload.listen();
  // Watch any files in dist/, reload on change
  gulp.watch(['dist/**']).on('change', livereload.changed);
});*/