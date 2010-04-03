Feature: Manage friends
  In order to allow for social interaction
  a user
  wants to have friends
  
  Scenario: a user requests friends
    Given the following users:
      |login     |email         |first_name|last_name||password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     ||abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     ||abc123  |abc123               |Female|24 |IL   |
      |philrothiv|pr@example.com|Phil      |Roth     ||abc123  |abc123               |Male  |22 |IL   |
      |carolynmh |ch@example.com|Carolyn   |Hartnett ||abc123  |abc123               |Female|24 |IL   |
      |jmdickey  |jd@example.com|Justin    |Dickey   ||abc123  |abc123               |Male  |25 |IL   |
    And I am logged in with "turnerking" and "abc123"
    And I search for "Becky"
    When I press "Add as Friend"
    Then "Becky King" should have a pending approval
    And "Turner King" should have no friends
    
  Scenario: a user accepts a friend request
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     |abc123  |abc123               |Female|24 |IL   |
      |philrothiv|pr@example.com|Phil      |Roth     |abc123  |abc123               |Male  |22 |IL   |
      |carolynmh |ch@example.com|Carolyn   |Hartnett |abc123  |abc123               |Female|24 |IL   |
      |jmdickey  |jd@example.com|Justin    |Dickey   |abc123  |abc123               |Male  |25 |IL   |
    And "Carolyn Hartnett" has a friend request from "Becky King"
    And I am logged in with "carolynmh" and "abc123"
    And I go to the home page
    And I follow "1"
    When I press "Approve Friendship"
    Then "Carolyn Hartnett" should not have a pending approval
    And "Becky King" should not have a request awaiting approval
    And "Carolyn Hartnett" should have a friend
    And "Becky King" should have a friend
  
  Scenario: a user denies a friend request
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     |abc123  |abc123               |Female|24 |IL   |
      |philrothiv|pr@example.com|Phil      |Roth     |abc123  |abc123               |Male  |22 |IL   |
      |carolynmh |ch@example.com|Carolyn   |Hartnett |abc123  |abc123               |Female|24 |IL   |
      |jmdickey  |jd@example.com|Justin    |Dickey   |abc123  |abc123               |Male  |25 |IL   |
    And "Carolyn Hartnett" has a friend request from "Phil Roth"
    And I am logged in with "carolynmh" and "abc123"
    And I go to the home page
    And I follow "1"
    When I press "Deny Friendship"
    Then "Carolyn Hartnett" should not have a pending approval
    And "Phil Roth" should not have a request awaiting approval
    And "Carolyn Hartnett" should have no friends
    And "Phil Roth" should have no friends