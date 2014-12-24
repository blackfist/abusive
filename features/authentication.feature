Feature: Require authentication for resources
  In order to make sure data isn't exposed
  As an unauthenticated user
  I should be challenged to log in before accessing resources

  Scenario: Unauthenticated user visits contribution index
    Given that I am not authenticated
    When I visit contribution index page
    Then I should be redirected to login page

  Scenario: Unauthenticated user visits new contribution page
    Given that I am not authenticated
    When I visit new contribution page
    Then I should be redirected to login page

  Scenario: Unauthenticated user visits show contribution page
    Given that I am not authenticated
    Given the following contribution exists
      | summary | test |
      | category | rehire |
    When I visit show contribution page
    Then I should be redirected to login page
