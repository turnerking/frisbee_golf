Feature: Manage challenges
  In order to have users interact
  the client
  wants users to challenge each other on courses
  
  Scenario: Register new challenge
    Given the following users:
      |login     |email         |first_name|last_name|password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     |abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     |abc123  |abc123               |Female|24 |IL   |
      |philrothiv|pr@example.com|Phil      |Roth     |abc123  |abc123               |Male  |22 |IL   |
      |carolynmh |ch@example.com|Carolyn   |Hartnett |abc123  |abc123               |Female|24 |IL   |
      |jmdickey  |jd@example.com|Justin    |Dickey   |abc123  |abc123               |Male  |25 |IL   |
    And "Turner King" is friends with "Becky King,Phil Roth,Carolyn Hartnett,Justin Dickey"
    And I am logged in with "turnerking" and "abc123"
    And I am at the 'Woodridge' course page
    And I follow "Create New Challenge"
    And I challenge "Becky King,Carolyn Hartnett,Justin Dickey"
    When I press "Start Challenge"
    Then "Woodridge" has a new challenge
    And "Turner King,Becky King,Carolyn Hartnett,Justin Dickey" have a challenge
    And "Phil Roth" does not have a challenge
    
  Scenario: Show challenge
    Given the following users:
      |login     |email         |first_name|last_name||password|password_confirmation|gender|age|state|
      |turnerking|tk@example.com|Turner    |King     ||abc123  |abc123               |Male  |23 |IL   |
      |beckyking |bk@example.com|Becky     |King     ||abc123  |abc123               |Female|24 |IL   |
      |philrothiv|pr@example.com|Phil      |Roth     ||abc123  |abc123               |Male  |22 |IL   |
      |carolynmh |ch@example.com|Carolyn   |Hartnett ||abc123  |abc123               |Female|24 |IL   |
      |jmdickey  |jd@example.com|Justin    |Dickey   ||abc123  |abc123               |Male  |25 |IL   |
    And I am logged in with "turnerking" and "abc123"
    And I am at a challenge at "Woodridge" involving everyone
    Then I should see the users have not submitted a score
