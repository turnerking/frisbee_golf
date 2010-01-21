Feature: Manage courses
  In order to have content on the site
  the client
  wants to be able add and manage courses

	Scenario: View all courses
		Given the following courses:
      |name           |address     |
      |O'Brien Park   |301 Foo St. |
      |Oak Brook      |303 Bar St. |
      |Woodridge      |504 Baz Ave.|
      |Madison Meadows|789 Buz Ct. |
		And I am logged as an admin
		When I am on the admin courses page
		Then I should see the following courses:
			|O'Brien Park   |301 Foo St. |
	    |Oak Brook      |303 Bar St. |
			|Woodridge      |504 Baz Ave.|
	    |Madison Meadows|789 Buz Ct. |
		
  
  Scenario: Register new course
		Given I am logged as an admin
    And I am on the new course page
		And I fill in the following:
			|Name   |Woodridge   |
			|Address|123 Jump St.|
    When I press "Create"
		Then I should see the following courses:
			|Woodridge|

  Scenario: Delete course
    Given the following courses:
      |name           |
      |O'Brien Park   |
      |Oak Brook      |
      |Woodridge      |
      |Madison Meadows|
		And I am logged as an admin
    When I delete the 3rd course
    Then I should see the following courses:
      |O'Brien Park   |
      |Oak Brook      |
      |Madison Meadows|
