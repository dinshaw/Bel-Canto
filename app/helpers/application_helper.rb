module ApplicationHelper
  def is?(coin)
    coin ? 'Yes' : 'No'
  end
  
  def link_to_remove_fields(name, f, confirm)
    f.hidden_field(:_destroy) + link_to_function(name, "if (confirm('#{confirm}')) remove_fields(this)")
  end
  

  def link_to_add_fields(name, f, association, path, *args)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.semantic_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(path + association.to_s.singularize + "_fields", :builder => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields.html_safe)}\")", *args)
  end
end
