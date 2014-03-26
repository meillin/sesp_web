// Creating spinner see <a href="http://fgnass.github.com/spin.js/">http://fgnass.github.com/spin.js/</a> for configuration wizzard
var opts = {
   lines: 11, // The number of lines to draw
   length: 20, // The length of each line
   width: 5, // The line thickness
   radius: 12, // The radius of the inner circle
   rotate: 0, // The rotation offset
   color: '#000000', // #rgb or #rrggbb
   speed: 1.4, // Rounds per second
   trail: 33, // Afterglow percentage
   shadow: true, // Whether to render a shadow
   hwaccel: false, // Whether to use hardware acceleration
   className: 'spinner', // The CSS class to assign to the spinner
   zIndex: 2e9, // The z-index (defaults to 2000000000)
   top: '400px', // Top position relative to parent in px
   left: 'auto' // Left position relative to parent in px
};


var spinner = new Spinner(opts);
var ajax_cnt = 0; // Support for parallel AJAX requests

// Global functions to show/hide on ajax requests
$(document).ajaxStart(function() {
   $('<div id ="spinner_center" style="position:fixed;top:70px;left:49%;"></div>').appendTo('body');
   spinner.spin($('#spinner_center')[0]);
   ajax_cnt++;	
});
 
$(document).ajaxStop(function() {
   ajax_cnt--;
   if (ajax_cnt <= 0) {
      spinner.stop();
      $('#spinner_center').remove();
      ajax_cnt = 0;
   }
	//alert('stop');
});