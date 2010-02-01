Given /^the following courses:$/ do |courses|
  Course.create!(courses.hashes)
end

Given /^I am at the '(.*)' course page$/ do |course_name|
  holes = (1..9).map { |i| Hole.create(:number => i, :par => 3, :distance_in_ft => 300)}
  @course = Course.create!(:name => course_name)
  @course.holes = holes
  visit course_path(@course)
end

Given /^I am logged in as an admin$/ do
  user = User.create!(:name => "Admin", :login => "siteadmin", :password => "abc123", :password_confirmation => "abc123", :email => "foo@example.com")
  user.update_attribute(:admin, true)
  visit new_session_url
  fill_in("login", :with => "siteadmin")
  fill_in("password", :with => "abc123")
  click_button("Log In")
end

Given /^I am logged in$/ do
  user = User.create!(:name => "Golfer", :login => "golfer", :password => "abc123", :password_confirmation => "abc123", :email => "foobar@example.com")
  visit new_session_url
  fill_in("login", :with => "golfer")
  fill_in("password", :with => "abc123")
  click_button("Log In")
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
