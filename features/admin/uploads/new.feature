Feature: New file upload

	In order to add files for students to access
	As an admin user
	I want to upload a new file
	
	
	Background:
		Given a user exists with first_name: "Joe", last_name: "Student" 
	

	Scenario: A non-admin user attempts to access the file upload
		Given I am signed in as a non-admin
		When I go to the new file upload page
		Then I should see "You are not authorized to view the requested page."
		
		
	Scenario: An admin successfully uploads a file
		Given I am signed in as an admin
		When I go to the new file upload page
		And I fill in "Label" with "Some File Name"
		And I attach the file "features/data/rails.png" to "File"
		And I check "trial"
		And I check "Joe Student"
		And I press "Submit"
		Then I should see "Your file upload was successful"
		Then I should be on the file uploads page
		And I should see "Some File Name"
		And I should see "trial"
		And I should see "Joe Student"
		
		
	Scenario: An admin submits the upload form with missing data
		Given I am signed in as an admin
		When I go to the new file upload page
		And I fill in "Label" with ""
		And I attach the file "" to "File"
		And I press "Submit"
		Then I should see "can't be blank" within "li#upload_label_input"
		And I should see "You must select a file to upload"		