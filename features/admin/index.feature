Feature: Admin index

	In order to do admin stuff
	As an admin
	I want to see a list of administrative features
	
	
	Scenario: A non-admin user attempts to access the admin index
		Given I am signed in as a non-admin
		When I go to the admin page
		Then I should see "You are not authorized to view the requested page."
		
		
	Scenario: Access to file uploads section
		Given I am signed in as an admin
		When I go to the admin page
		And I follow "Manage File Uploads"
		Then I should be on the file uploads page
		
		
	Scenario: Access to manage students section
  	Given I am signed in as an admin
  	When I go to the admin page
  	And I follow "Manage Students"
  	Then I should be on the manage students page
	