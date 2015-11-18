var regenerate = require('./random').regenerate;

$(function() {
	$('.menu--about__contents').eq(0).addClass('active');
});

// Star
$('.header--rating li').on('click', function() {
	$el = $(this)
	$('.header--rating i').removeClass('random--color').css({color: '#cccccc'});;
	$el.find('i').addClass('random--color');
	$el.prevAll('.header--rating li').find('i').addClass('random--color');
	regenerate();
});

// General

$('body').on('click', '.language-select', function() {
	$('.menu--language').toggleClass('open');
});

$('body').on('click', '.trigger--about', function() {
	$('.menu--about').toggleClass('open');
});

$('body').on('click', '.menu__main .btn--close', function() {
	$('.menu__main').removeClass('open');
});


// About Menu
$('body').on('click', '.show-about-kanjicooker', function() {
	$('.menu--about__contents').removeClass('active');
	$('.menu--about--kanjicooker').addClass('active');
});

$('body').on('click', '.show-about-usage', function() {
	$('.menu--about__contents').removeClass('active');
	$('.menu--about--usage').addClass('active');
});

$('body').on('click', '.show-about-social', function() {
	$('.menu--about__contents').removeClass('active');
	$('.menu--about--social').addClass('active');
});
