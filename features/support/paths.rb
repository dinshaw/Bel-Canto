module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
      
    when /the sign in page/
      new_user_session_path
      
    when /the new file upload page/
      new_admin_upload_path
      
    when /the file uploads page/
      admin_uploads_path
      
    when /the file upload page for "(.+)"/
      upload = Upload.find_by_label($1)
      admin_upload_path(upload)
      
    when /the edit file upload page for "(.+)"/
      upload = Upload.find_by_label($1)
      edit_admin_upload_path(upload)
      
    when /the admin page/
      admin_path
      
    when /the files page/
      files_path
      
    when /the download page for "(.+)"/
      upload = Upload.find_by_label($1)
      upload.nil? ? download_file_path(:id => 1000) : download_file_path(upload)
      
    when /the manage students page/
      admin_students_path
      
    when /the new student page/
      new_admin_student_path
      
    when /the admin show student page for "(.+)"/
      student = User.find_by_email($1)
      admin_student_path(student)

    when /the admin edit student page for "(.+)"/
      student = User.find_by_email($1)
      edit_admin_student_path(student)
      
    when /that student's edit page/
      student = User.last
      edit_student_path(student)

    # added by pickle
    when /^#{capture_model}(?:'s)? page$/                           # eg. the forum's page
      path_to_pickle $1

    when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/   # eg. the forum's post's page
      path_to_pickle $1, $2

    when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/  # eg. the forum's post's comments page
      path_to_pickle $1, $2, :extra => $3                           #  or the forum's post's edit page

    when /^#{capture_model}(?:'s)? (.+?) page$/                     # eg. the forum's posts page
      path_to_pickle $1, :extra => $2                               #  or the forum's edit page

    when /^the "(.+?)" page$/                                       # translate to named route
      send "#{$1.downcase.gsub(' ','_')}_path"
    # end added by pickle
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
