// -------------------------------------------------------------------------------------------------
// Requirements
// -------------------------------------------------------------------------------------------------

var gulp         = require('gulp');

var runSequence  = require('run-sequence');
var del          = require('del');
var env          = require('gulp-env');
var sass         = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var coffeeify    = require('gulp-coffeeify');
var concat       = require('gulp-concat');
var sourcemaps   = require('gulp-sourcemaps');
var notify       = require('gulp-notify');
var plumber      = require('gulp-plumber');
var browserSync  = require('browser-sync');
var changed      = require('gulp-changed');
var minifyCSS    = require('gulp-minify-css');
var minifyHTML   = require('gulp-minify-html');
var uglify       = require('gulp-uglify');


// -------------------------------------------------------------------------------------------------
// Config
// -------------------------------------------------------------------------------------------------

env({
	file: ".env.json"
});

var basePath = {
	src: 'src/',
	dest: 'build/'
};

var src = {
	fonts  : basePath.src + 'fonts/',
	ie     : basePath.src + 'ie8/',
	img    : basePath.src + 'img/',
	js     : basePath.src + 'js/',
	pages  : basePath.src + 'pages/',
	sass   : basePath.src + 'sass/'
}

var dest = {
	fonts  : basePath.dest + 'fonts/',
	ie     : basePath.dest + 'ie8/',
	img    : basePath.dest + 'img/',
	js     : basePath.dest + 'js/',
	pages  : basePath.dest,
	css   : basePath.dest + 'css/'
}

var reload = browserSync.reload;
var onError = function(err) {
	console.log(err);
	this.emit('end');
};


// -------------------------------------------------------------------------------------------------
// Sub tasks
// -------------------------------------------------------------------------------------------------

gulp.task('clean', function() {
  del(basePath.dest);
});

gulp.task('move', function() {
	['fonts', 'ie', 'img'].forEach(function(type){
		gulp.src(src[type] + '**/*').pipe(gulp.dest(dest[type]));
	})
	return gulp.src(src.js + 'vendors/modernizr-2.6.2-respond-1.1.0.min.js').pipe(gulp.dest(dest.js));
})

gulp.task('html', function() {
	return gulp.src(src.pages + '*').pipe(gulp.dest(dest.pages));
})

gulp.task('sass', function() {

	var makeDevCss = function() {
		return gulp.src(src.sass + '*.scss')
		.pipe(plumber({ errorHandler: onError }))
		.pipe(changed(dest.css))
		.pipe(sourcemaps.init())
		.pipe(sass({
			errLogToConsole: true,
			includePaths: ['bower_components']
		}))
		.pipe(autoprefixer({
			browsers: JSON.parse(process.env.AUTOPREFIXER_BROWSERS)
		}))
		.pipe(sourcemaps.write())
		.pipe(gulp.dest(dest.css))
		.pipe(notify("development scss reloaded"))
		.pipe(browserSync.stream());
	}

	var makeMinifyCss = function() {
		return gulp.src(src.sass + '*.scss')
		.pipe(changed(dest.css))
		.pipe(sass({
			errLogToConsole: true,
			includePaths: ['bower_components']
		}))
		.pipe(autoprefixer({
			browsers: JSON.parse(process.env.AUTOPREFIXER_BROWSERS)
		}))
		.pipe(minifyCSS())
		.pipe(gulp.dest(dest.css))
		.pipe(notify("minified css created"))
	}

	var current_env = process.env.ENVIRONMENT;
	return (current_env == 'dev') ? makeDevCss() : makeMinifyCss();

});

gulp.task('scripts', function() {
	return gulp.src(src.js + 'main.coffee')
    .pipe(coffeeify({
      options: {
        debug: true,
        paths: [__dirname + '/node_modules', __dirname + '/src/js']
      }
    }))
    .pipe(gulp.dest(dest.js));
})

gulp.task('browser-sync', function() {
	browserSync.init({
		host: process.env.HOST,
		port: process.env.PORT,
		server: {
			baseDir: basePath.dest
		}
	});

	gulp.watch(src.sass +'**/*.scss', ['sass']);
	gulp.watch(src.js + '**/*.{coffee,js}', function() { runSequence('scripts', reload) });
	gulp.watch(src.pages + '**/*.html', function() { runSequence('html', reload) });
})

gulp.task('minify', function() {
  gulp.src(dest.css + '*.css').pipe(minifyCSS()).pipe(gulp.dest(dest.css))
  gulp.src(dest.js + '*.js').pipe(uglify()).pipe(gulp.dest(dest.js))
  gulp.src(dest.pages + '*.html').pipe(minifyHTML()).pipe(gulp.dest(dest.pages))
});


// -------------------------------------------------------------------------------------------------
// Main task
// -------------------------------------------------------------------------------------------------

gulp.task('compile', ['move', 'html', 'sass', 'scripts']);

gulp.task('default', function(){
	runSequence('clean', 'compile', 'browser-sync');
});

gulp.task('build', function() {
	runSequence('clean', 'compile', 'minify');
});
