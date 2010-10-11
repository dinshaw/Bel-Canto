(function($) {
  var add_fields_link, count, form_with_associations, field_groups, new_group, new_val, last_group, old_val, pattern, remove_link;

  function initialize() {
    form_with_associations = $('form.associations');
    if (form_with_associations.length > 0) {
      form_with_associations.find('.add_field a').click(function(){
        add_fields_link_handler($(this));
      });
      
      form_with_associations.find('.remove_field a').click(function(){
        remove_fields_link_handler($(this));
      });
    }
  }

  $(document).ready(initialize);

  function add_fields_link_handler($context) {
    field_groups = form_with_associations.find($context.attr('data-field-group'));
    last_group = field_groups.last();
    new_group = last_group.clone();
    new_group.clearForm();
    count = field_groups.size();

    new_group.find('input, select, textarea, label').each(function(){
      replace_ids($(this), $context, count);
      replace_names($(this), $context, count);
    });

    last_group.after(new_group);
    return false;
  };

  function remove_fields_link_handler($context) {
    form_with_associations.find($context.attr('data-field-group')).remove();
    return false;
  }
  
  function replace_ids($el, $context, count) {
    pattern = [$context.attr('data-class'), $context.attr('data-association'), 'attributes'].join('_');
    old_val = pattern+'_'+(count-1);
    new_val = [pattern, count].join('_');
    replace_attr($el,'id', old_val, new_val);
    replace_attr($el,'for', old_val, new_val);
  }

  function replace_names($el, $context, count) {
    pattern = $context.attr('data-class')+'['+[$context.attr('data-association'),'attributes'].join('_')+']';
    old_val = pattern+'['+(count-1)+']';
    new_val = pattern+'['+count+']';
    replace_attr($el,'name', old_val, new_val);
  }

  function replace_attr($el, attr, old_val, new_val) {
    if ($el.attr(attr) !== undefined) {
      $el.attr(attr, $el.attr(attr).replace(old_val, new_val));
    }
  }

})(jQuery);
