##################
# Requirements
##################

gulp         = require('gulp')

runSequence  = require('run-sequence')
del          = require('del')
env          = require('gulp-env')
sass         = require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
coffeeify    = require('gulp-coffeeify')
concat       = require('gulp-concat')
sourcemaps   = require('gulp-sourcemaps')
notify       = require('gulp-notify')
plumber      = require('gulp-plumber')
browserSync  = require('browser-sync')
changed      = require('gulp-changed')
minifyCSS    = require('gulp-minify-css')
minifyHTML   = require('gulp-minify-html')
uglify       = require('gulp-uglify')

##################
# Config
##################

env {file: '.env.json'}

basePath =
	src: 'src/'
	dest: 'build/'

src =
	fonts : "#{basePath.src}fonts/"
	ie    : "#{basePath.src}ie8/"
	img   : "#{basePath.src}img/"
	js    : "#{basePath.src}js/"
	pages : "#{basePath.src}pages/"
	sass  : "#{basePath.src}sass/"

dest =
	fonts : "#{basePath.dest}fonts/"
	ie    : "#{basePath.dest}ie8/"
	img   : "#{basePath.dest}img/"
	js    : "#{basePath.dest}js/"
	pages : basePath.dest
	css   : "#{basePath.dest}css/"

reload = browserSync.reload
onError = (err) ->
	console.log(err)
	@emit('end')

##################
# Sub tasks
##################

gulp.task 'clean', -> del(basePath.dest)

gulp.task 'move', ->
	['fonts', 'ie', 'img'].forEach (type) ->
		gulp.src(src[type] + '**/*').pipe(gulp.dest(dest[type]))

	return gulp.src("#{src.js}vendors/modernizr-2.6.2-respond-1.1.0.min.js").pipe(gulp.dest(dest.js))

gulp.task 'html', ->
	return gulp.src("#{src.pages}*").pipe(gulp.dest(dest.pages))

gulp.task 'sass', ->
	return gulp.src("#{src.sass}*.scss")
		.pipe plumber({ errorHandler: onError })
		.pipe changed(dest.css)
		.pipe sourcemaps.init()
		.pipe sass({
			errLogToConsole: true
			includePaths: ['bower_components']
		})
		.pipe autoprefixer({
			browsers: JSON.parse(process.env.AUTOPREFIXER_BROWSERS)
		})
		.pipe sourcemaps.write()
		.pipe gulp.dest(dest.css)
		.pipe notify('development scss reloaded')
		.pipe browserSync.stream()

gulp.task 'scripts', ->
	return gulp.src("#{src.js}main.coffee")
    .pipe coffeeify({
      options:
        debug: true
        paths: ["#{__dirname}/node_modules", "#{__dirname}/src/js"]
    })
    .pipe gulp.dest(dest.js)

gulp.task 'browser-sync', ->
	browserSync.init
		host: process.env.HOST
		port: process.env.PORT
		server:
			baseDir: basePath.dest

	gulp.watch "#{src.sass}**/*.scss", ['sass']
	gulp.watch "#{src.js}**/*.{coffee,js}", -> runSequence('scripts', reload)
	gulp.watch "#{src.pages}**/*.html", -> runSequence('html', reload)

gulp.task 'minify', ->
  gulp.src("#{dest.css}*.css").pipe(minifyCSS()).pipe(gulp.dest(dest.css))
  gulp.src("#{dest.js}*.js").pipe(uglify()).pipe(gulp.dest(dest.js))
  gulp.src("#{dest.pages}*.html").pipe(minifyHTML()).pipe(gulp.dest(dest.pages))

##################
# Main task
##################

gulp.task 'compile', ['move', 'html', 'sass', 'scripts']

gulp.task 'default', ->
	runSequence('clean', 'compile', 'browser-sync')

gulp.task 'build', ->
	runSequence('clean', 'compile', 'minify')
