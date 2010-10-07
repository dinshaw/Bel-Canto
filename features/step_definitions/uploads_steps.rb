Given /^no uploads exist$/ do
  Upload.delete_all
end


Given /^that user has access to "(.+)"$/ do |label|
  upload = Upload.find_by_label(label)
  upload.users << User.last
end