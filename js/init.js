jQuery(document).ready(function($){

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
    
    //Allow to close the menu with a click out the menu
    $('body').click(function(e){
    	if($('#menu').css('display') != "none"){
    		$('#menu').slideUp("medium");
        	$("#menu-button").children('.menu-button-arrow').removeClass('open');
        	$("#menu-button").children('.menu-button-arrow').addClass('close'); 
        	e.stopPropagation(); 
    	}
    });
    
    // Event click on block retractable title
    $('.block.retractable .block-title').click(function () {        
    	
		if ($(this).parent().children(".content-wrapper").children('.content').css('display') == "none") {
            $(this).parent().children(".content-wrapper").children('.content').slideDown("medium",function(){
    	    	if ($.browser.msie  && parseInt($.browser.version, 10) === 8) {  
    	    		//fake adding class on the parent to fire update of rendering
    	    		//without that, block is superposed
	    			$("#main-content").addClass('fake').removeClass('fake');
	    		}
            });
            $(this).children(".block-arrow").removeClass('close');
        	$(this).children(".block-arrow").addClass('open'); 
        }else{
        	$(this).parent().children(".content-wrapper").children('.content').slideUp("medium",function(){
    	    	if ($.browser.msie  && parseInt($.browser.version, 10) === 8) {  
    	    		//fake adding class on the parent to fire update of rendering
    	    		//without that, block is superposed
	    			$("#main-content").addClass('fake').removeClass('fake');
	    		}
            }); 
        	$(this).children(".block-arrow").removeClass('open');
    		$(this).children(".block-arrow").addClass('close'); 
        }       
    });
        
    //replacing span for a for a better support of old browser
    $(".accordion li.toggleSubMenu span").each( function () {
        // we stock the value of the span
        var TexteSpan = $(this).html();
        $(this).replaceWith('<a href="" class="accordion-title" title="">' + TexteSpan + '<\/a>') ;
    }); 
        
    //Hide all submenu at the start
	$(".accordion ul.subMenu").hide();
	
    // Event on each subMenu
    $(".accordion li.toggleSubMenu > a").click( function () {
        // If  the submenu is already open, we close it
        if ($(this).next("ul.subMenu:visible").length != 0) {
            $(this).next("ul.subMenu").slideUp("normal");
            $(this).children('.accordion-arrow').removeClass("open");
        	$(this).children('.accordion-arrow').addClass("close");
        }
        // If the submenu is closed, we close others and open this
        else {
            //$(".accordion ul.subMenu").slideUp("normal");
            //$(".accordion ul.subMenu").parent().children('.accordion-title').children('.accordion-arrow').removeClass("open");
        	//$(".accordion ul.subMenu").parent().children('.accordion-title').children('.accordion-arrow').addClass("close");

            $(this).next("ul.subMenu").slideDown("normal");
            $(this).children('.accordion-arrow').removeClass("close");
        	$(this).children('.accordion-arrow').addClass("open");
        }
        // stop the default event on the a tag
        return false;
    });
    
    $(".block-accordion .block-title-button-open-all").click(function(e) {
    	$(this).parent().parent().children(".content-wrapper").children(".content").children(".accordion").children('li').each(function() {
			if ($(this).children("ul.subMenu:visible").length != 0) {
				
	        }else{
	        	$(this).children("ul.subMenu").slideDown("normal");
	            $(this).children('a.accordion-title').children('.accordion-arrow').removeClass("close");
	        	$(this).children('a.accordion-title').children('.accordion-arrow').addClass("open");
	        }
		});
    	return false;
    });
    
    $(".block-accordion .block-title-button-close-all").click(function(e) {
    	$(this).parent().parent().children(".content-wrapper").children(".content").children(".accordion").children('li').each(function() {
			if ($(this).children("ul.subMenu:visible").length != 0) {
				$(this).children("ul.subMenu").slideUp("normal");
	            $(this).children('a.accordion-title').children('.accordion-arrow').removeClass("open");
	        	$(this).children('a.accordion-title').children('.accordion-arrow').addClass("close");
	        }
		});
    	return false;
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

	$(""+tableId+"").colResizable({
		liveDrag:true, 
		gripInnerHtml:"<div class='grip'></div>", 
		draggingClass:"dragging", 
		onResize:onSampleResized,
		postbackSafe: true,
		marginLeft: "10px",
		marginRight: "10px"
	});
};