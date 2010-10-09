Factory.sequence :email do |n|
  "student#{n}@belcanto.com"
end


Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.password              { "password" }
  user.password_confirmation { "password" }
  user.first_name 'Joe'
  user.last_name  'Student'
  user.state 'student'
  user.admin false
  user.editor false
end


Factory.define :phone_number do |phone_number|
  phone_number.user {|a| a.association(:user) }
  phone_number.kind 'Work'
  phone_number.number '2222222222'
end


Factory.define :upload do |upload|
  upload.label 'Some File Name'
  upload.access_mask 0
  upload.file_file_name 'some_file_name.png'
  upload.file_content_type 'image/png'
  upload.file_file_size 1234
  upload.file_updated_at Time.now
end