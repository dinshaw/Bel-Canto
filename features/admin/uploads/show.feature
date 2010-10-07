Feature: File upload details

	In order to view details of an upload
	As an admin user
	I want to view an upload
	
	
	Background:
		Given an upload exists with label: "File 1", access_mask: "12"
	
	
	Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the file upload page for "File 1"
		Then I should see "You are not authorized to view the requested page."
		
		
	Scenario: An admin views the details of an upload
		Given I am signed in as an admin
		When I go to the file upload page for "File 1"
		Then I should see "File 1"
		And I should see "advanced, finished"
