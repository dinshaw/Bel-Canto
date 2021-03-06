;(function($) {

  function initialize() {
    var context = $('form .nested_resource');
    if (context.length > 0) {
      context.find('.add_field a').click(function(){ add_item($(this), context); });
    }
  }

  function add_item($link, $context) {
    var new_item, last_item;
    last_item = $context.find('.nested_resource_item').last();
    new_item = last_item.clone().clearForm();
    new_item.find('input, select, textarea, label').each(function(){
      unique_index($(this),['id','for','name']);
    });

    last_item.after(new_item);
    return false;
  };
  
  function unique_index($el, attrs) {
    var time_stamp = new Date().getTime();
    jQuery.each(attrs, function(i) {
      if ($el.attr(attrs[i]) !== undefined) {
        $el.attr(attrs[i], $el.attr(attrs[i]).replace(/\d+/, time_stamp));
      }
    });
  }

  $(document).ready(initialize);

})(jQuery);
