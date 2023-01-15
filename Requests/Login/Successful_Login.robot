*** Settings ***
Resource    ../../Environment/Setup.robot
Library    ../../CustomLibrary/BuiltinKeywords.py

*** Keywords ***
successful Login with valid credentials
        [Arguments]    ${email}    ${pass}
        create session    mysession     ${base_url}
        ${body}=    create dictionary  email=${email}   password=${pass}
        ${header}=  create dictionary   Content-Type=application/json; charset=utf-8
        ${response}=    POST On Session    mysession   /user/login     json=${body}    headers=${header}
#     Extracting token from json response in another way.
        ${json_response}=  evaluate  json.loads("""${response.content}""")   json
        Log To Console     Response:${json_response}
        store token in json      ${json_response}    token
#        set token    ${json_response}
#        ${token}=     get token
#        set suite variable        ${token}
     # Validations
        ${message}=    get value from json     ${response.json()}      message
        should be equal as strings    ${message[0]}   Login successfully
        validate response code      ${response.status_code}     200