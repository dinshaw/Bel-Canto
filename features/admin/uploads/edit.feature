Feature: Edit file upload

	In order to edit files for students to access
	As an admin user
	I want to edit an existing upload
	
	
	Background:
		Given an upload exists with label: "File 1", access_mask: "12"
	

	Scenario: A non-admin user attempts to access the edit file upload
		Given I am signed in as a non-admin
		When I go to the edit file upload page for "File 1"
		Then I should see "You are not authorized to view the requested page."
		
		
	Scenario: An admin successfully edits an existing upload
		Given I am signed in as an admin
		When I go to the edit file upload page for "File 1"
		And I fill in "Label" with "Some Other File Name"
		And I attach the file "features/data/rails.png" to "File"
		And I press "Submit"
		Then I should see "Your file upload was successfully updated"
		And I should be on the file upload page for "Some Other File Name"
		And I should see "Some Other File Name"
		
		
	Scenario: An admin submits the upload form with missing data
		Given I am signed in as an admin
		When I go to the new file upload page
		And I fill in "Label" with ""
		And I attach the file "" to "File"
		And I press "Submit"
		Then I should see "can't be blank" within "li#upload_label_input"