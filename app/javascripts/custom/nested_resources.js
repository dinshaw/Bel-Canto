(function($) {
  var add_link, collection, context, count, new_item

  function initialize() {
    $context = $('form .nested_resource');
    if ($context.length > 0) {
      $context.find('.add_field a').click(function(){ add_item($(this)); });
    }
  }

  $(document).ready(initialize);

  function add_item($link) {
    collection = $link.closest('.nested_resource').find('.nested_resource_item');
    new_item = collection.last().clone().clearForm();
    new_item.find('input, select, textarea, label').each(function(){
      increment_index($(this),['id','for','name'], collection.size());
    });

    collection.last().after(new_item);
    return false;
  };
  
  function increment_index($el, attrs, count) {
    jQuery.each(attrs, function(i) {
      if ($el.attr(attrs[i]) !== undefined) {
        $el.attr(attrs[i], $el.attr(attrs[i]).replace(/\d+/, count+1));
      }
    });
  }

})(jQuery);
