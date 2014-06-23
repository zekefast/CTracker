Feature: Collector authentication
  In order to let several money collectors to use currency collecting application
  Mr. Smart 
  wants identifies users before providing access for them to their
  lists of currencies and countries.

  Scenario Outline: Success sign up
    Given I am on the sign up page
    When I fill in "Email" with "<email>"
    And I fill in "Password" with "<password>"
    And I fill in "Password confirmation" with "<password>"
    And I press "Sign up"
    Then I should be on the home page
    And I should see "Welcome! You have signed up successfully."
    And I should see "Currencies"
    And I should see "Countries"
    And I should see "Profile (<email>)"
    And I should see "Sing out"

    Examples:
      | email                | password |
      | mr.smart@example.com | secret00 |

  Scenario Outline: Success sing in
    Given I am a collector registered with "<email>" and "<password>"
    And I am on the sign in page
    When I fill in "Email" with "<email>"
    And I fill in "Password" with "<password>"
    And I press "Sign in"
    Then I should be on the home page
    And I should see "Signed in successfully."
    And I should see "Currencies"
    And I should see "Countries"
    And I should see "Profile (<email>)"
    And I should see "Sing out"

    Examples:
      | email                | password |
      | mr.smart@example.com | secret00 |

  Scenario: Success sign out
    Given I am a new, authenticated user
    And I am on the home page
    And I should see "Sing out"
    When I follow "Sing out"
    Then I should be on the sign in page
    And I should see "Sign in"
    And I should see "Sign up"
    And I should not see "Countries"
    And I should not see "Currencies"
    And I should not see "Profile"
    And I should not see "Sign out"
