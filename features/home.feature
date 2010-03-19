Feature: Home Page
  In order to have something visible
  the user
  wants a home page

	Scenario: Shows all existing courses
		Given the following courses:
      |name           |
      |O'Brien Park   |
      |Oak Brook      |
      |Woodridge      |
		When  I go to the home page
		Then I should see the following courses:
      |O'Brien Park|
      |Oak Brook   |
      |Woodridge   |