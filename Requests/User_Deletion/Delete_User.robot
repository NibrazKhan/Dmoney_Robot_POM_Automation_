*** Settings ***
Resource    ../../Environment/Setup.robot
Library    ../../CustomLibrary/BuiltinKeywords.py
*** Keywords ***
Delete User
    [Arguments]   ${id}
    create session  mysession   ${base_url}
    ${json_obj}=       load json from file    ${json_file_path}
    ${token}=          get value from json    ${json_obj}   $.token
    ${headers}=        create dictionary    Content-Type=application/json   Authorization=${token[0]}   X-AUTH-SECRET-KEY=${secret_key}
    ${response}=       delete request       mysession    /user/delete/${id}        headers=${headers}
    log to console    ${response.json()}
    #Validations.
    should be equal as strings    ${response.status_code}   200
    ${message}=     get value from json    ${response.json()}   message
    should be equal as strings    ${message[0]}     User deleted successfully