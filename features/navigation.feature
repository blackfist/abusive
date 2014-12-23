Feature: Navigating the site
  In order to easily find things
  As a user
  I want easy access to navigation links

  Background:
    Given the following user record:
      | email      | password    |  admin   |
      | tester@test.com     | tester      | true     |
      | enduser@test.com | tester | false |
    And I log in as "tester@test.com" with password "tester"

  Scenario: Looking for navigation links at root
    Given I am at the root of the site
    Then I should see a link to incidents
    And I should see a link to contributions
    And I should see a link to explore

  Scenario: Looking for navigation links at incidents
    Given I am at the incidents index page
    Then I should see a link to incidents
    And I should see a link to contributions
    And I should see a link to explore

  Scenario: Looking for navigation links at contributions
    Given I am at the contributions index page
    Then I should see a link to incidents
    And I should see a link to contributions
    And I should see a link to explore
