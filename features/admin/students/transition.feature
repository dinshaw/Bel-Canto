Feature: Update student transition

  In order to do the funky chicken?
  As an admin
  I want to update the student's state
  
  
  Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the manage students page
		Then I should see "You are not authorized to view the requested page."
  
  
  @javascript
  Scenario: A student's transition is successfully updated
    Given a user exists with first_name: "Jake", last_name: "Student", state: "trial", id: 1
    And I am signed in as an admin
    When I go to the manage students page
    And I select "suspended" from "state_select_dropdown_1"
    Then I should see "Jake Student's state has been successfully updated to suspended"