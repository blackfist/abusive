Feature: Managing Contributions
  In order to keep track of police misconduct that contributes to a hostile environment but which is not well reported
  As an administrative user
  I want to enter data, edit data, and delete data

  Background:
    Given the following user record:
      | email      | password    |  admin   |
      | tester@test.com     | tester      | true     |
      | enduser@test.com | tester | false |
    And I log in as "tester@test.com" with password "tester"

  Scenario: Admin entering a new contribution
    Given that I am at the new contribution page
    When I enter the following answers in new contribution form:

      | contribution_summary    | This is a test |
      | contribution_start_year   | 2014 |
      | contribution_start_month   | 11   |
      | contribution_end_year   | 2014   |
      | contribution_end_month | 12 |
      | contribution_location_city         | Dallas  |
      | contribution_location_state  | TX |
      | contribution_references_attributes_0_url | http://www.test.com |
      | contribution_references_attributes_0_headline | Test |
      | contribution_references_attributes_0_org_name | Test |

    And I select the following answers in new contribution form:

      | contribution_category | Rehire abuser |

    And I click "Create Contribution"
    Then I should be on the contribution index page
    And I should see "Contribution was successfully created."
    And I should have 1 contribution
