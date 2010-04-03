Feature: Profile
  In order to have a user manage their information
  the client
  wants users to be able to see and update their info
  
  Scenario: Show profile information to user
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |M     |23 |IL   |
    And I am logged in with "turnerking" and "abc123"
    When I go to the profile page of turnerking
    Then I should see the following user:
      |Turner King|IL|23|Male|tk@example.com|
  
  Scenario: Show profile information to friends
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |M     |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     |abc123  |abc123               |F     |24 |IL   |
    And "Turner King" is friends with "Becky King"
    And I am logged in with "turnerking" and "abc123"
    When I go to the profile page of beckyking
    Then I should see the following user:
      |Becky King|IL|24|Female|bk@example.com|
  
  Scenario: Don't show profile information to non-friends
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     |abc123  |abc123               |Female|24 |IL   |
    And I am logged in with "turnerking" and "abc123"
    When I go to the profile page of beckyking
    Then I should be on the home page
    And I should see "You don't have access to this page"
  
  Scenario: Able to go to edit if user
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
    And I am logged in with "turnerking" and "abc123"
    When I go to the profile page of turnerking
    Then I should see "Edit"
  
  Scenario: Unable to see edit if not user
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     |abc123  |abc123               |Female|24 |IL   |
    And "Turner King" is friends with "Becky King"
    And I am logged in with "turnerking" and "abc123"
    When I go to the profile page of beckyking
    Then I should not see "Edit"
  
  Scenario: Editing information entering bad data
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
    And I am logged in with "turnerking" and "abc123"
    When I go to the edit profile page of turnerking
    And I fill in "user_email" with ""
    And I press "Update Profile"
    Then I should see "Email can't be blank"
  
  Scenario: Editing information entering good data
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
    And I am logged in with "turnerking" and "abc123"
    When I go to the edit profile page of turnerking
    And I fill in "user_state" with "WI"
    And I press "Update Profile"
    Then I should see "WI"
      