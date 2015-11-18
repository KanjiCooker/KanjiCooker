var regenerate = require('./random').regenerate;

function hideDrop() {
	$('.drop--type-selection-footer').removeClass('open');
}

$('.btn--reload-type').on('click', regenerate);
$('.btn--close').on('click', hideDrop);

$('body').on('click', function(event) {
	if (!$(event.target).closest('.type-selection__footer__list button, .drop--type-selection-footer').length) {
		hideDrop();
	}
});



$('.header--rating .level-beginner i').addClass('random--color');
regenerate();
$('.type-selection__body .level-beginner').addClass('show');
