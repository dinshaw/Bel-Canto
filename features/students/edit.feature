Feature: Edit student record

  In order to keep my record up-to-date
  As a student
  I want to edit my record


	Scenario: A user successfully updates their information
	  Given I am signed in as a non-admin
	  When I go to that student's edit page
	  And I fill in "First Name" with "Edited"
	  And I fill in "Last Name" with "Student"
	  And I fill in "Email" with "edited@belcanto.com"
	  And I press "Submit"
	  Then I should see "Your student record was successfully updated"
	  And a user should exist with first_name: "Edited", last_name: "Student"
	  

	Scenario: A user submits invalid informatioin
    Given I am signed in as a non-admin
    When I go to that student's edit page
    And I fill in "First Name" with ""
    And I fill in "Last Name" with ""
    And I fill in "Email" with ""
    And I press "Submit"
    Then I should see "first name can't be blank"
    And I should see "last name can't be blank"
    And I should see "email can't be blank"
    
    
  Scenario: A user attempts to edit someone else's student information
    Given I am signed in as a non-admin
    And a user exist
    When I go to that student's edit page
    Then I should see "You are not authorized to edit this student record"
  
    
  
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
  
	  
