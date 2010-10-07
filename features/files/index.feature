Feature: List of accessible files

	In order to download tapes
	As a user
	I want to see a list of files I have access to
	
	
	Background:
		Given an upload exists with label: "File 1"
		And an upload exists with label: "File 2"
		And I am signed in as a non-admin
		And that user has access to "File 1"
	
	
	Scenario: A user should see their accessible files
		When I go to the files page
		Then I should see "File 1"
		And I should not see "File 2"


	Scenario: A user has access to no files
		Given no uploads exist
		When I go to the files page
		Then I should see "You do not have access to any downloads"