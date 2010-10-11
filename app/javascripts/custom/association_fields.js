(function($) {
  var add_link, collection, count, form, new_item, remove_link

  function initialize() {
    form = $('form.associations');
    if (form.length > 0) {
      form.find('.add_field a').click(function(){
        add_handler($(this));
      });
      
      form.find('.remove_field a').click(function(){
        remove_handler($(this));
      });
    }
  }

  $(document).ready(initialize);

  function add_handler($context) {
    collection = form.find($context.attr('data-field-group'));
    new_item = collection.last().clone().clearForm();
    new_item.find('input, select, textarea, label').each(function(){
      increment_index($(this),['id','for','name'], collection.size());
    });

    collection.last().after(new_item);
    return false;
  };

  function remove_handler($context) {
    form.find($context.attr('data-field-group')).remove();
    return false;
  }
  
  function increment_index($el, attrs, count) {
    jQuery.each(attrs, function(i) {
      if ($el.attr(attrs[i]) !== undefined) {
        $el.attr(attrs[i], $el.attr(attrs[i]).replace(/\d/, count+1));
      }
    });
  }

})(jQuery);
