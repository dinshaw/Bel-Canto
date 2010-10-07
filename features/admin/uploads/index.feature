Feature: File uploads list

	In order to view files available to students
	As an admin user
	I want to see a list of uploads
	
	
	Background:
		# Note: 12 = [:advanced, :finished], 3 = [:trial, :student]
		Given the following uploads exist
			| label  | access_mask |
			| File 1 | 12					 |
			| File 2 | 3 					 |
	

	Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the file uploads page
		Then I should see "You are not authorized to view the requested page."
		
		
	Scenario: When there are available file uplaods
		Given I am signed in as an admin
		When I go to the file uploads page
		Then I should see "File 1"
		And I should see "File 2"
		And I should see "trial, student"
		And I should see "advanced, finished"
		
		
	Scenario: When there are no available file uploads
		Given I am signed in as an admin
		And no uploads exist
		When I go to the file uploads page
		Then I should see "There are currently no uploads"
		
		
	Scenario: An admin views the details of an upload
		Given I am signed in as an admin
		When I go to the file uploads page
	 	And I follow "File 1"
		Then I should be on the file upload page for "File 1"
