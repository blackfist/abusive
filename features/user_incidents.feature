Feature: Adding Incidents
  In order to keep track of police misconduct
  As an end user user
  I want to enter data

  Background:
    Given the following user record:
      | email      | password    |  admin   |
      | tester@test.com     | tester      | true     |
      | enduser@test.com | tester | false |
    And I log in as "enduser@test.com" with password "tester"


  Scenario: End user entering a new incident
    Given that I am at the new incident page
    When I enter the following answers:
      | incident_incident_year    | 2014 |
      | incident_incident_summary  | Test |
      | incident_incident_month   | 12   |
      | incident_location_state   | FL   |
      | incident_context          | 911  |
      | incident_department_name  | Test |
      | incident_department_level | City |
      | incident_reported_year    | 2014 |
    And I click "Create Incident"
    Then I should be on the incident index page
    And I should see "Incident was successfully created."
    And I should have 1 incident

  Scenario: End user trying to edit an incident
    Given that I am at the incidents page
    Then I should not see "edit" button

  Scenario: End user trying to delete an incident
    Given that I am at the incidents page
    Then I should not see "delete" button
