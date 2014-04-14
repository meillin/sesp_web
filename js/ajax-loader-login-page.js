// Creating spinner see <a href="http://fgnass.github.com/spin.js/">http://fgnass.github.com/spin.js/</a> for configuration wizzard
var opts = {
  lines: 15, // The number of lines to draw
  length: 8, // The length of each line
  width: 3, // The line thickness
  radius: 8, // The radius of the inner circle
  corners: 1, // Corner roundness (0..1)
  rotate: 0, // The rotation offset
  direction: 1, // 1: clockwise, -1: counterclockwise
  color: '#fff', // #rgb or #rrggbb or array of colors
  speed: 1.6, // Rounds per second
  trail: 100, // Afterglow percentage
  shadow: false, // Whether to render a shadow
  hwaccel: false, // Whether to use hardware acceleration
  className: 'spinner', // The CSS class to assign to the spinner
  zIndex: 2e9, // The z-index (defaults to 2000000000)
  top: '280%', // Top position relative to parent in px
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