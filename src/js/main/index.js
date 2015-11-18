var randomText = require('./random');
var config = require('../config');
var sample = require('lodash/collection/sample');

// ---------------------------------
// Functions
// ---------------------------------

function printout() {
	if (!window.print){
		alert("列印功能暫時停用，請按 Ctrl-P 來列印"); return;
	}
	window.print();
}

function hideDrop() {
	$('.drop--type-selection-footer').removeClass('open');
}

function randomColor() {
	var color = palette.get(sample(config.colors), '500');
	$('.random--color').css({
		'color': color,
		'border-bottom-color': color
	});
	$('.random--background').css({
		backgroundColor: color
	});
}

function randomIdioms() {
	$('.drop--type-selection-footer .content h3').text(sample(config.idioms));
}

function randomSpecial() {
	$('.drop--type-selection-footer .content h3').text(sample(config.ipsums));
}


// ---------------------------------
// Binding
// ---------------------------------

$('body').on('click', '.header--rating li', function(event) {
	$('.type-selection__nav button').removeClass('active');
	$(this).addClass('active');
	$('.header--rating i').removeClass('random--color').css({color: '#cccccc'});;
	$(this).find('i').addClass('random--color');
	$(this).prevAll('.header--rating li').find('i').addClass('random--color');
	var select_level = $(this).text();
	$('.type-selection__nav__current button span').text(select_level);
	$('.type-selection__nav ul').removeClass('open');

	randomText();
	randomColor();
});

$('body').on('click', '.btn--reload-type', function() {
	randomText();
	randomColor();
});

$('body').on('click', function(event) {
	if (!$(event.target).closest('.type-selection__nav__current button').length) {
		$('.type-selection__nav ul').removeClass('open');
	}
});

$('body').on('click', '#type-generator', function() {
	$(this).parent().find('.drop--type-selection-footer').toggleClass('open');
});

$('body').on('click', '#idioms-random', function() {
	$('#special-random').removeClass('active');
	$(this).addClass('active');
	randomIdioms();
});

$('body').on('click', '#special-random', function() {
	$('#idioms-random').removeClass('active');
	$(this).addClass('active');
	randomSpecial();
});

$('body').on('click', '.btn--close', function() {
	hideDrop();
});

$('body').on('click', function(event) {
	if (!$(event.target).closest('.type-selection__footer__list button,.drop--type-selection-footer').length) {
		hideDrop();
	}
});


// ---------------------------------
// Init
// ---------------------------------

$('.header--rating .level-beginner i').addClass('random--color');
randomText();
randomColor();
randomIdioms();
$('.type-selection__body .level-beginner').addClass('show');
