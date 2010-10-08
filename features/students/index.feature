Feature: Student list

  In order to see the class
  As a student
  I want to see a list of students
  
  @javascript
	Scenario: A random user attempts to access the student list
		When I go to the manage students page
		Then I should see "You are not authorized to view the requested page"


  Scenario: When students exist
  	Given I am signed in as an admin
  	And the following users exists 
      | first_name | last_name | email            | state    |
      | Joe        | Student   | joe@belcanto.com | advanced |
  	When I go to the manage students page
  	Then I should see "Student, Joe"
  	And I should see "joe@belcanto.com"
  	And I should see "advanced"  
