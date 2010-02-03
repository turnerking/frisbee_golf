Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

Given /^I am logged in with "(.*)" and "(.*)"$/ do |username, password|
  visit new_session_url
  fill_in("login", :with => username)
  fill_in("password", :with => password)
  click_button("Log In")
end

Given /^I search for "(.*)"$/ do |search|
  get users_path(:search => search)
end

Given /^"(.*)" has a friend request from "(.*)"$/ do |approver, requester|
  Friendship.create(:approver => User.find_by_name(approver), :requester => User.find_by_name(requester))
end

Given /^I debug$/ do
  puts response.body
end

Then /^"(.*)" should have a pending approval$/ do |name|
  user = User.find_by_name(name)
  user.friendships_to_approve.size.should == 1
end

Then /^"(.*)" should not have a pending approval$/ do |name|
  user = User.find_by_name(name)
  user.friendships_to_approve.should be_empty
end

Then /^"(.*)" should not have a request awaiting approval$/ do |name|
  user = User.find_by_name(name)
  user.unapproved_friendships.should be_empty
end

Then /^"(.*)" should have no friends$/ do |name|
  user = User.find_by_name(name)
  user.friends.should be_empty
end

Then /^"(.*)" should have a friend$/ do |name|
  user = User.find_by_name(name)
  user.friends.size.should == 1
end
