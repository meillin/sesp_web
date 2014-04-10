$(document).ready(function() {

/*
Main navigation
 */
	$('ul.overlapping-menu').css('left', -350);
	$('#show-nav').click(function() {
		var $lefty = $('ul.overlapping-menu');
		console.log($lefty);
		$lefty.animate({
			left: parseInt($lefty.css('left'), 10) === -20 ? - $lefty.outerWidth() - 50 : -20
		});
	});

/*
Filter open background
 */
	$('.toggle-filter').click(function(){
		$('.wrapper-blur').fadeToggle('fast', 'linear');
	});

/*
Sub menu actions
 */
	$('.sub-menu li').click(function(){
		var active = $(this);
		if(!active.hasClass('active')){
			$('.sub-menu li').removeClass('active');
			active.addClass('active');
		}
	});

});
