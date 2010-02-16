Given /^the following courses:$/ do |courses|
  Course.create!(courses.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) course$/ do |pos|
  visit admin_courses_url
  within("div#courses > div:nth-child(#{pos.to_i})") do
    click_link "Delete"
  end
end

Then /^I should see the following courses:$/ do |expected_courses_table|
  expected_courses_table.diff!(tableish('div.course', 'div.row div').to_a)
end
