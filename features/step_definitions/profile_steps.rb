Then /^I should see the following user:$/ do |expected_user_table|
  expected_user_table.diff!(tableish('div#user_info', 'div.row .info').to_a)
end
