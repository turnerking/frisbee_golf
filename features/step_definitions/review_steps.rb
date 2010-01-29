Given /^the following reviews:$/ do |reviews|
  Review.create!(reviews.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) review$/ do |pos|
  visit reviews_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following reviews:$/ do |expected_reviews_table|
  expected_reviews_table.diff!(tableish('table tr', 'td,th'))
end
