Feature: Remove file upload

	In order to make a file inaccessible
	As an admin user
	I want to remove an existing upload
	
	
	Background:
		Given an upload exists with label: "File 1", access_mask: "12"
	

	@javascript
	Scenario: An admin successfully removes an existing upload
		Given I am signed in as an admin
		When I go to the file uploads page
		And I confirm the javascript popup on the next step
		And I follow "Remove"
		Then I should see "Your file upload was successfully removed"
		And 0 uploads should exist