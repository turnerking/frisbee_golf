Feature: Manage courses
  In order to have content on the site
  the client
  wants to be able add, view, and manage courses
  
  Scenario: View a course in main site
    Given the following courses:
      |name           |address     |
      |O'Brien Park   |301 Foo St. |
      |Oak Brook      |303 Bar St. |
      |Woodridge      |504 Baz Ave.|
      |Madison Meadows|789 Buz Ct. |
    And I am on the home page
    When I follow "Woodridge"
    Then I should see the following courses:
      |Woodridge      |504 Baz Ave.|

	Scenario: View all courses in admin
		Given the following courses:
      |name           |address     |
      |O'Brien Park   |301 Foo St. |
      |Oak Brook      |303 Bar St. |
      |Woodridge      |504 Baz Ave.|
      |Madison Meadows|789 Buz Ct. |
		And I am logged in as an admin
		When I am on the admin courses page
		Then I should see the following courses:
			|O'Brien Park   |301 Foo St. |
	    |Oak Brook      |303 Bar St. |
			|Woodridge      |504 Baz Ave.|
	    |Madison Meadows|789 Buz Ct. |
		
  
  Scenario: Register new course in admin
		Given I am logged in as an admin
    And I am on the new course page
		When I fill in "Name" with "Woodridge"
		And I fill in "Address" with "123 Jump St."
		And I select "Gravel" from "Tee Type"
		And I select "3" from "Difficulty"
		And I select "4" from "Tree Interference"
		And I select "Basket" from "Hole Type"
    And I press "Create"
		Then I should see the following courses:
			|Woodridge|

  Scenario: Delete course in admin
    Given the following courses:
      |name           |
      |O'Brien Park   |
      |Oak Brook      |
      |Woodridge      |
      |Madison Meadows|
		And I am logged in as an admin
    When I delete the 3rd course
    Then I should see the following courses:
      |O'Brien Park   |
      |Oak Brook      |
      |Madison Meadows|
