*** Settings ***
Documentation    https://fakerestapi.azurewebsites.net/api/Users
Library          RequestsLibrary
Library          Collections


*** Variable ***
${URL_API}       https://fakerestapi.azurewebsites.net/api/
&{USER_10}       ID=10
...              UserName=User 10
...              Password=Password10


*** Keywords ***
Connect to API
     Create Session    fakeAPIUsers    ${URL_API}

Given I want to get the user listing
     ${RESPONSE}          Get Request       fakeAPIUsers    Users
     log                  ${RESPONSE.text}
     Set Suite Variable   ${RESPONSE}

Then check Status Code
     [Arguments]                 ${STATUS_CODE_EXPECTED}
     Should Be Equal As Strings  ${RESPONSE.status_code}    ${STATUS_CODE_EXPECTED}


And also valid the reason
     [Arguments]                 ${REASON_EXPECTED}
     Should Be Equal As Strings  ${RESPONSE.reason}    ${REASON_EXPECTED}


Then I check if the total users is equal to "${QTY_USERS}"
     Length Should Be   ${RESPONSE.json()}    ${QTY_USERS}


Given I want to get the user "${ID_USER}"
     ${RESPONSE}          Get Request       fakeAPIUsers    Users/${ID_USER}
     log                  ${RESPONSE.text}
     Set Suite Variable   ${RESPONSE}

And check if the user data is correctly returning 10
     Dictionary Should Contain Item    ${RESPONSE.json()}    ID          ${USER_10.ID}
     Dictionary Should Contain Item    ${RESPONSE.json()}    UserName    ${USER_10.UserName}
     Dictionary Should Contain Item    ${RESPONSE.json()}    Password    ${USER_10.Password}


Given I want to register a user
    &{body}=     Create Dictionary      ID=12   UserName=User Aline   Password=ABC123
    &{header}=   Create Dictionary      content-type=application/json
    ${RESPONSE}            Post Request     fakeAPIUsers    Users    data=${body}   headers=${header}
    Log                    ${RESPONSE.text}
    Log                    ${RESPONSE.status_code}

Given I want to delete user "${ID_USER}"
     ${RESPONSE}           Delete Request    fakeAPIUsers    Users/${ID_USER}
     log                   ${RESPONSE.text}

Given I want to update user "${ID_USER}"
     &{body}=     Create Dictionary     ID=${ID_USER}    UserName=User Joane   Password=DBC123
     &{header}=   Create Dictionary     content-type=application/json
     ${RESPONSE}            Put Request   fakeAPIUsers    Users/${ID_USER}   data=${body}    headers=${header}
     Log                    ${RESPONSE.text}
     Log                    ${RESPONSE.status_code}
