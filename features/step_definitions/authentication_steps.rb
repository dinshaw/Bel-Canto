When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end


Given /^I registered as "(.*)\/(.*)"$/ do |email, password|
  user = Factory(:user, :email => email, :password => password, :password_confirmation => password)
end


Given /^that user is an admin$/ do
  user = User.last
  user.update_attribute(:admin, true)
end


Given /^that user is confirmed$/ do
  user = User.last
  user.confirm!
end


Given /^I am signed in as an admin$/ do
  Given %{I registered as "admin@belcanto.com/supersecret"}
  And %{that user is confirmed}
  And %{that user is an admin}
  When %{I sign in as "admin@belcanto.com/supersecret"}
end


Given /^I am signed in as a non-admin$/ do
  Given %{I registered as "admin@belcanto.com/supersecret"}
  And %{that user is confirmed}
  When %{I sign in as "admin@belcanto.com/supersecret"}
end