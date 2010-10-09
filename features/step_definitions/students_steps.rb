When /^I remove the last student/ do
  within(:xpath, '//tr[last()]') do
    When %{I follow "Remove"}
  end
end


When /^I fill in "([^"]*)" with "([^"]*)" within the (\d+)(?:\w+) phone number$/ do |input, text, position|
  within(:xpath, "//div[@class='phone_number'][#{position}]") do
    When %{I fill in "#{input}" with "#{text}"}
  end
end


When /^I select "([^"]*)" from "([^"]*)" within the (\d+)(?:\w+) phone number$/ do |selection, input, position|
  within(:xpath, "//div[@class='phone_number'][#{position}]") do
    When %{I select "#{selection}" from "#{input}"}
  end
end
