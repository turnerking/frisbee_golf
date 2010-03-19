Given /^"([^\"]*)" is friends with "([^\"]*)"$/ do |name, friends_names|
  user = User.find_by_name(name)
  friends = friends_names.split(",").map {|fr| User.find_by_name(fr)}
  friends.each do |friend|
    f = Friendship.create(:requester => user, :approver => friend)
    f.approve
  end
end

Given /^I am at the '(.*)' course page$/ do |course_name|
  @course = create_course_with_holes(course_name)
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
  user = User.create!(:name => "Golfer", :login => "golfer", :password => "abc123", :password_confirmation => "abc123", :email => "foobar@example.com", :age => 26, :gender => "Female")
  visit new_session_url
  fill_in("login", :with => "golfer")
  fill_in("password", :with => "abc123")
  click_button("Log In")
end

Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

Given /^I am logged in with "(.*)" and "(.*)"$/ do |username, password|
  visit new_session_url
  fill_in("login", :with => username)
  fill_in("password", :with => password)
  click_button("Log In")
end

Then /^I see the response$/ do
  print response.body
end

def create_course_with_holes(course_name)
  holes = (1..9).map { |i| Hole.create(:number => i, :par => 3, :distance_in_ft => 300)}
  course = Course.create!(:name => course_name)
  course.holes = holes
  course
end

