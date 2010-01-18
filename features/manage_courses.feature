Feature: Manage courses
  In order to have content on the site
  the client
  wants to be able add and manage courses
  
  Scenario: Register new course
    Given I am on the new course page
    And I press "Create"

  Scenario: Delete course
    Given the following courses:
      |name           |
      |O'Brien Park   |
      |Oak Brook      |
      |Woodridge      |
      |Madison Meadows|
    When I delete the 3rd course
    Then I should see the following courses:
      |O'Brien Park   |
      |Oak Brook      |
      |Madison Meadows|
