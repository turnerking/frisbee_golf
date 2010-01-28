Given /^the following scorecards:$/ do |scorecards|
  Scorecard.create!(scorecards.hashes)
end

Then /^a new scorecard has been created$/ do
  @course.scorecards.size.should == 1
end

Then /^I should see the following scorecards:$/ do |expected_scorecards_table|
  expected_scorecards_table.diff!(tableish('table tr', 'td,th'))
end
