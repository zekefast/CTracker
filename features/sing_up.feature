Feature: Sing up
  In order to restrain access to his tracked money collection Mr. Smart wants
  to register in application.

  Scenario: Success sign up
    Given I am on a sign up page
    When I fill in "Email" with "mr.smart@example.com"
    And I fill in "Password" with "secret00"
    And I fill in "Password confirmation" with "secret00"
    And I press "Sign up"
    Then I should be on the home page
    And I should see "Welcome! You have signed up successfully."
    And I should see "Profile"
    And I should see "Logout"
    And I should see "Collection"
    And I should see "Visited countries and collected currencies"
