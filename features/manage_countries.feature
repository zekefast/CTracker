Feature: Manage countries
  In order to manage his travel itinerary
  Mr. Smart
  wants to manage the countries he has visited.
  
  Scenario: List Countries
    Given I am a new, authenticated user
    Given the following countries exist:
      |name|code|visited|
      |CountryOne|c1|false|
      |CountryTwo|c2|false|
      |CountryThree|c3|true|
      |CountryFour|c4|true|
      |CountryFive|c5|true|
    When I am on the countries page
    Then I should see the following table:
      |Name|Code|Status|
      |CountryOne|c1|Not Visited|
      |CountryTwo|c2|Not Visited|
      |CountryThree|c3|Visited|
      |CountryFour|c4|Visited|
      |CountryFive|c5|Visited|

  Scenario: Visit Country
    Given I am a new, authenticated user
    Given I am on a country page
    When I follow "Edit"
    And I check "Visited"
    And I press "Update Country"
    Then I should see "Status: Visited"

  Scenario Outline: Ensures visited countries tracked in separate list for
    different users.
    Given I am a collector registered with "<email1>" and "<password>"
    And I am signed in with "<email1>" and "<password>"
    And I am on a country page
    When I follow "Edit"
    And I check "Visited"
    And I press "Update Country"
    And I follow "Sign out"
    And I am a collector registered with "<email2>" and "<password>"
    And I am signed in with "<email2>" and "<password>"
    And I am on a country page
    Then I should see "Status: Not Visited"

    Examples:
      | email1               | email2                          | password |
      | mr.smart@example.com | brother_of_mr.smart@example.com | secret00 |
