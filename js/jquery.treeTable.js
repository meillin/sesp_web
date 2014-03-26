/*
* jQuery treeTable Plugin
*
*/
(function($) {
 
  var options;

  $.fn.treeTable = function(opts) {
    options = $.extend({}, $.fn.treeTable.defaults, opts);

    return this.each(function() {
      $(this).find("tbody tr").each(function() {
        initialize($(this));
      });
    });
  };

  $.fn.treeTable.defaults = {
    dataAttribute: "level",
    collapsedByDefault: false,
    ignoreClickOn: "input, a"
  };

  
  $.fn.collapse = function() {
    if ($(this).hasChildren()) {
      $(this).removeClass("expanded").addClass("collapsed");
      childrenOf($(this)).each(function() {
        $(this).hide().collapse();
      });
    }
    return this;
  };

 
  $.fn.expand = function() {
    if ($(this).hasChildren()) {
      $(this).removeClass("collapsed").addClass("expanded");
      childrenOf($(this)).each(function() {
        $(this).show();
      });
    }
    return this;
  };

  $.fn.hasChildren = function() {
    return (childrenOf($(this)).length > 0);
  };

  $.fn.toggle = function() {
    if ($(this).hasClass("collapsed"))
      $(this).expand();
    else
      $(this).collapse();
    return this;
  };


  function initialize(node) {
    if (node.hasChildren()) {
      node.click(function(event) {
        var $target = $(event.target);
        if (!$target.is(options.ignoreClickOn)) {
          node.toggle();
          return false;
        }
      });
      if (options.collapsedByDefault)
        node.collapse();
      else
        node.expand();
    }
  };

  function getLevel(node) {
    return parseInt($(node).data(options.dataAttribute));
  };

  function childrenOf(node) {
    nodeLevel = getLevel(node);
    childrenLevel = nodeLevel + 1;
    return $(node).nextUntil("tr[data-" + options.dataAttribute + "=" + nodeLevel + "]", "tr[data-" + options.dataAttribute + "=" + childrenLevel + "]");
  };
})(jQuery);