
var gulpbabel = require('gulp-babel');
var sourcemaps = require('gulp-sourcemaps');
var minifycss = require('gulp-minify-css');
var rename = require('gulp-rename');
var concat = require('gulp-concat');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var notify = require('gulp-notify');
var livereload = require('gulp-livereload');

gulp.task('javascript', function() {
  gulp.src('src/**/*.js')
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

/*
gulp.task('watch', function() {
  // Create LiveReload server
  livereload.listen();
  // Watch any files in dist/, reload on change
  gulp.watch(['dist/**']).on('change', livereload.changed);
});*/