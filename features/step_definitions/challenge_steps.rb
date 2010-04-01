Given /^I challenge "([^\"]*)"$/ do |friends_names|
  friends = friends_names.split(",").map {|fr| User.find_by_name(fr)}
  friends.each do |friend|
    check("challenge_user_id_#{friend.id}")
  end
end

Given /^I am at a challenge at "([^\"]*)" involving everyone$/ do |course_name|
  users = User.all
  @course = create_course_with_holes(course_name)
  @challenge = Challenge.create(:play_from => 1.days.from_now, :play_to => 5.days.from_now, :submit_by => 7.days.from_now,
                                :course_id => @course.id, :organizer_id => users[0].id, :user_ids => users.map(&:id))
  visit challenge_path(@challenge)
end

Then /^"(.*)" has a new challenge$/ do |course_name|
  course = Course.find_by_name(course_name)
  course.challenges.size.should == 1
end

Then /^"([^\"]*)" ha(?:s|ve) a challenge$/ do |user_names|
  users = user_names.split(",").map {|fr| User.find_by_name(fr)}
  users.each do |user|
    user.challenges.size.should == 1
  end
end

Then /^"([^\"]*)" do(?:es|) not have a challenge$/ do |user_names|
  users = user_names.split(",").map {|fr| User.find_by_name(fr)}
  users.each do |user|
    user.challenges.should be_empty
  end
end

Then /^I should see the users have not submitted a score$/ do
  response.body.should have_tag("#non-scoring-users") do
    User.all.each do |user|
      with_tag(".score-labels p", :text => user.name)
      with_tag(".score-totals p", :text => "Score has not been submitted")
    end
  end
end
