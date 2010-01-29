Feature: Manage reviews
  In order to provide feedback
  a user
  wants to be able to submit a course
  
  Scenario: Register new review
    Given I am logged in
    And I am at the 'Woodridge' course page
    And I fill in "review_body" with "This is a great course"
    When I press "Submit Review"
    Then I should see "This is a great course"
