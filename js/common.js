$(document).ready(function() {

/*
Main navigation
 */
	$('ul.overlapping-menu').css('left', -350);
	$('#show-nav').click(function() {
		var $lefty = $('ul.overlapping-menu');
		$lefty.css('display', 'block');
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

	$('dd a').click(function(event){
		event.preventDefault();
		var target = $(this).next();
		target.slideToggle('fast');
	});

/*
Nice scroll
 */
	$(".filtered, .filterHeader .big-row > div:nth-child(2)").niceScroll({
		cursorcolor:"#ffffff ",
		cursoropacitymax: '0.7',
		cursorborder: '0',
		railalign: 'right'
	});

	$('.nicescroll-rails').css('right', 0);

});
