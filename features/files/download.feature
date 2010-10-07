Feature: File download

	In order to practice voice
	As a user
	I want to get the tapes
	
	
	Background:
		Given an upload exists with label: "File 1"
		And an upload exists with label: "File 2"
		And I am signed in as a non-admin
		And that user has access to "File 1"
		
		
	Scenario: A user does not have access to the requested file
		When I go to the download page for "File 2"
		Then I should see "You do not have permission to download this file"

		
	Scenario: A user requests a file that does not exist
		When I go to the download page for "File 3"
		Then I should see "The requested download could not be found"	
	