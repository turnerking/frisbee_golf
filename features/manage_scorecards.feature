Feature: Manage scorecards
  In order to attain a usable feature
  the user
  wants to be able to submit a scorecard for a course
  
  Scenario: Register new scorecard
    Given I am logged in
    And I am at the 'Woodridge' course page
    And I fill in "scorecard_scores_attributes_0_shots" with "3"
    And I fill in "scorecard_scores_attributes_1_shots" with "3"
    And I fill in "scorecard_scores_attributes_2_shots" with "3"
    And I fill in "scorecard_scores_attributes_3_shots" with "3"
    And I fill in "scorecard_scores_attributes_4_shots" with "3"
    And I fill in "scorecard_scores_attributes_5_shots" with "3"
    And I fill in "scorecard_scores_attributes_6_shots" with "3"
    And I fill in "scorecard_scores_attributes_7_shots" with "3"
    And I fill in "scorecard_scores_attributes_8_shots" with "3"
    When I press "Submit Round"
    Then a new scorecard has been created
