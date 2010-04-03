Given /^I search for "(.*)"$/ do |search|
  get users_path(:search => search)
end

Given /^"(.*)" has a friend request from "(.*)"$/ do |approver, requester|
  approving_user = User.find_by_first_name_and_last_name(approver.split(" ")[0], approver.split(" ")[1])
  requesting_user = User.find_by_first_name_and_last_name(requester.split(" ")[0], requester.split(" ")[1])
  Friendship.create(:approver => approving_user, :requester => requesting_user)
end

Given /^I debug$/ do
  puts response.body
end

Then /^"(.*)" should have a pending approval$/ do |name|
  user = User.find_by_first_name_and_last_name(name.split(" ")[0], name.split(" ")[1])
  user.friendships_to_approve.size.should == 1
end

Then /^"(.*)" should not have a pending approval$/ do |name|
  user = User.find_by_first_name_and_last_name(name.split(" ")[0], name.split(" ")[1])
  user.friendships_to_approve.should be_empty
end

Then /^"(.*)" should not have a request awaiting approval$/ do |name|
  user = User.find_by_first_name_and_last_name(name.split(" ")[0], name.split(" ")[1])
  user.unapproved_friendships.should be_empty
end

Then /^"(.*)" should have no friends$/ do |name|
  user = User.find_by_first_name_and_last_name(name.split(" ")[0], name.split(" ")[1])
  user.friends.should be_empty
end

Then /^"(.*)" should have a friend$/ do |name|
  user = User.find_by_first_name_and_last_name(name.split(" ")[0], name.split(" ")[1])
  user.friends.size.should == 1
end
