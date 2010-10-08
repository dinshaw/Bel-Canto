Feature: Remove student

	In order to terminate a student's access
	As an admin user
	I want to remove that student
		

	@javascript
	Scenario: An admin successfully removes a student
		Given I am signed in as an admin
		And a user exists
		When I go to the manage students page
		And I confirm the javascript popup on the next step
		And I remove the last student
		Then I should see "The student was successfully removed"
