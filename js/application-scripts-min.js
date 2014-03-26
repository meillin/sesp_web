$(function(){
//open Modal window
	/*$('#myMeaterModal').modal({
	  keyboard: false
	})//	*/

//show the meter input box
	$(".cmodal-close").click(function() {
	 	$(".subnav-custom").show();
		
	});
	//set focus on

	$('input.setfocus').focus();
	$(".show-details").show();
   // fix sub nav on scroll
    function addKeyboardNavigation(){
	 // get the height of #wrap
	 var $wrapHeight = $('.navbar').outerHeight()
	 // get 1/4 of wrapHeight
	 var $quarterwrapHeight = ($wrapHeight)/4
	 // get 3/4 of wrapHeight
	 var $threequarterswrapHeight = 3*($wrapHeight)
	 // check if we're over a quarter down the page
	 if( $(window).scrollTop() > $quarterwrapHeight ){
	  // if we are show keyboardTips
	  $("#subnav-custom-area").addClass("subnav-custom-fixed").fadeIn("slow");
	  $(".logo-icon").show();
	 }else{
		 $("#subnav-custom-area").removeClass("subnav-custom-fixed").fadeIn("slow");
		 $(".logo-icon").hide();
		 }
	}
	$(window).scroll(function(){
	 addKeyboardNavigation();
	});//
	
	//
	$('#myTab a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	})
	//
	$('.g1 a').click(function () {
		$(this).toggleClass("highlight")
	  $('#sc1').toggle();
	  $('#sc2').hide();
	  $('#sc3').hide();
	  $('#sc4').hide();
	})
		//
	$('.g2 a').click(function () {
	  $('#sc2').toggle();
	  $('#sc1').hide();
	  $('#sc3').hide();
	  $('#sc4').hide();
	})
			//
	$('.g3 a').click(function () {
	  $('#sc3').toggle();
	  $('#sc1').hide();
	  $('#sc2').hide();
	  $('#sc4').hide();
	})
			//
	$('.g4 a').click(function () {
	  $('#sc4').toggle();
	  $('#sc1').hide();
	  $('#sc2').hide();
	  $('#sc3').hide();
	})

	//Calling date picker functions
	$('#dp1').datepicker();;
	$('#dp2').datepicker();
	$('#dp3').datepicker();
	$('#dp4').datepicker();
	$('#dp5').datepicker();
	/*today Date*/
		var d = new Date();
		var month = d.getMonth()+1;
		var day = d.getDate();
		var todaydate = ((''+day).length<2 ? '0' : '') + day + '/' +
			((''+month).length<2 ? '0' : '') + month  + '/' + d.getFullYear()

/*Select box*/
			$("SELECT").selectBox();

/***************************
	  radio Boxes 
	 ***************************/	
	$('form').jqTransform({imgPath:'jqtransformplugin/img/'});
/*login button*/
	$(".btn").click(function() {
	 	$(".main-menu, .pull-right").show();
		$(".signin").parent().hide();
		$(".loginborder").removeClass("loginborder");
	});
	
})