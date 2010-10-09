Feature: Show student

  In order to view details of a student
  As an admin
  I want to view a student record
  
  
  Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the manage students page
		Then I should see "You are not authorized to view the requested page."


  Scenario: Viewing a student record
    Given I am signed in as an admin
    And a user exists with first_name: "Some", last_name: "Student", email: "student@belcanto.com"
    When I go to the manage students page
    And I follow "Student, Some"
    Then I should be on the admin show student page for "student@belcanto.com"
	