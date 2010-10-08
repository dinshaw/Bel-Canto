Feature: Add a student

  In order to keep track of students
  As an admin
  I want to add a student


  Background:
    Given a user exists with email: "editme@belcanto.com"
    
  
  Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the manage students page
		Then I should see "You are not authorized to view the requested page."
	
	
	Scenario: An admin successfully edits a student
	  Given I am signed in as an admin
	  When I go to the admin edit student page for "editme@belcanto.com"
	  And I fill in "First Name" with "Edited"
	  And I fill in "Last Name" with "Student"
	  And I fill in "Email" with "edited@belcanto.com"
	  And I press "Submit"
	  Then I should see "The student was successfully updated"
	  And a user should exist with first_name: "Edited", last_name: "Student"
    And I should be on the admin show student page for "edited@belcanto.com"
	  

	Scenario: An admin submits a student with invalid data
    Given I am signed in as an admin
    When I go to the admin edit student page for "editme@belcanto.com"
    And I fill in "First Name" with ""
    And I fill in "Last Name" with ""
    And I fill in "Email" with ""
    And I press "Submit"
    Then I should see "first name can't be blank"
    And I should see "last name can't be blank"
    And I should see "email can't be blank"
    
  
  # Note: Selenium/Capybara currently does not find the dynamically
  # added input set.  Should work otherwise.
  #
  # @javascript  
  # Scenario: An admin adds another phone number and submits
  #   Given I am signed in as an admin
  #   When I go to the new student page
  #   And I fill in "First Name" with "New"
  #   And I fill in "Last Name" with "Student"
  #   And I fill in "Email" with "newstudent@belcanto.com"
  #   And I follow "Add another phone number"
  #   And I select "Mobile" from "Kind" within the 3rd phone number
  #   And I fill in "Number" with "8009998888" within the 3rd phone number
  #   And I press "Submit"
  #   Then I should see "The student was successfully created"
  
	  
