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
	$(".filtered, .nice-scroll").niceScroll({
		cursorcolor:"#ffffff ",
		cursoropacitymax: '0.7',
		cursorwidth: '10',
		cursorborder: '0',
		railalign: 'right'
	});
	$('.nicescroll-rails').css('right', 0);


//Moved code from init.js to common.js
	//Event of menu button
	$('#menu-button').click(function (e) {
		if ($('#menu').css('display') == "none") {
			$('#menu').slideDown("medium");
			$("#menu-button").children('.menu-button-arrow').removeClass('close');
			$("#menu-button").children('.menu-button-arrow').addClass('open');
		}else{
			$('#menu').slideUp("medium");
			$("#menu-button").children('.menu-button-arrow').removeClass('open');
			$("#menu-button").children('.menu-button-arrow').addClass('close');
		}
		//prevent the body click event;
		e.stopPropagation();
	});

    //stop propagation to not close the menu
    $('#menu-inner').click(function(e){
    	//prevent the body click event;
    	e.stopPropagation();
    });

    $('.toggle-filter').click(function(e){
        //prevent the body click event;
        e.preventDefault();
       $('.filterHeader').slideToggle("up");
    });

	if($(".input-datepicker").size()>0){
		$(".input-datepicker").datepicker({
			format: 'yyyy/mm/dd'
		});
	}
	if($(".custom-multi-select").size()>0){
		$(".custom-multi-select").multiselect({
			selectedList: 2 // Number of item listed in the header befor the generic "x selected"
		});
	}

});


/* Added For Table column drag effect */
var onSampleResized = function(e){
	var table = $(e.currentTarget); //reference to the resized table
};

var renderTable = function(tableId){
	$(tableId);
};
