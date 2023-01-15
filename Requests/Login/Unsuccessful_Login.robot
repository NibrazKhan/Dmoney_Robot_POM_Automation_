*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../Environment/Setup.robot
#Suite Setup  Creating Session

*** Keywords ***
Unsuccessful Login with Wrong Email and Wrong Password
        [Arguments]    ${wrongEmail}    ${wrongPass}
        create session    mysession     ${base_url}
        ${body}=    create dictionary  email=${wrongEmail}    password=${wrongPass}
        ${header}=  create dictionary   Content-Type=application/json; charset=utf-8
        ${response}=    Run Keyword And Expect Error  *    POST On Session    mysession   /user/login     json=${body}    headers=${header}
#     checking the type of the variable response.
        log to console    Response: ${response}
        ${type}=    Evaluate     type($response)
        Log To Console     ${type}
        should contain     ${response}     404


