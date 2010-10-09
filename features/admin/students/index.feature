Feature: Student list

  In order to manage students
  As an admin
  I want to see a list of students
  
  
	Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the manage students page
		Then I should see "You are not authorized to view the requested page."


  Scenario: When students exist
  	Given I am signed in as an admin
  	And the following users exists 
      | first_name | last_name | email            | state    | admin | editor |
      | Joe        | Student   | joe@belcanto.com | advanced | true  | false  |
  	When I go to the manage students page
  	Then I should see "Student, Joe"
  	And I should see "joe@belcanto.com"
  	And I should see "advanced"
  	And I should see "true"
  	And I should see "false"
  
