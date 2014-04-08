$(document).ready(function() {
	// Overlapping slide menu
	$('ul.overlapping-menu').css('left', -350);
	$('#show-nav').click(function() {
		var $lefty = $('ul.overlapping-menu');
		console.log($lefty);
		$lefty.animate({
			left: parseInt($lefty.css('left'), 10) === -20 ? - $lefty.outerWidth() - 50 : -20
		});
	});

	$('.toggle-filter').click(function(){
		$('.wrapper-blur').fadeToggle('fast', 'linear');
	});

});
