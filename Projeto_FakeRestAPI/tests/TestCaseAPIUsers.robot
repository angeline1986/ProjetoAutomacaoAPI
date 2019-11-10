*** Settings ***
Resource         ../resources/ResourceAPI.robot
Suite Setup      Connect to API


*** Test Case ***
Scenario 01: GET Method - Return to the Users List
     Given I want to get the user listing
     Then check Status Code      200
     And also valid the reason   OK
     Then I check if the total users is equal to "10"

Scenario 02: GET Method - Returning a Specific User
     Given I want to get the user "10"
     Then check Status Code      200
     And also valid the reason   OK
     And check if the user data is correctly returning 10

Scenario 03: POST Method - Registering a New User
     Given I want to register a user
     Then check Status Code      200
     And also valid the reason   OK

Scenario 04: DELETE Method - Delete a User
     Given I want to delete user "7"
     Then check Status Code      200
     And also valid the reason   OK

Scenario 05: PUT Method - Updating a User
     Given I want to update user "6"
     Then check Status Code      200
     And also valid the reason   OK
