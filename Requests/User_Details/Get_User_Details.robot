*** Settings ***
Resource    ../../Environment/Setup.robot
Library    ../../CustomLibrary/BuiltinKeywords.py
*** Keywords ***
Get User Details
  [Arguments]   ${id}
  create session    mysession     ${base_url}
     ${json_obj}=   load json from file     ${json_file_path}
     ${token}=  get value from json    ${json_obj}  $.token
     ${expected_id}=      get value from json    ${json_obj}    $.${id}
     ${header}=  create dictionary   Content-Type=application/json; charset=utf-8   Authorization=${token[0]}  X-AUTH-SECRET-KEY=${secret_key}
     ${param}=   create dictionary  id=${expected_id[0]}
     ${response}=    get request    mysession   /user/search/?     params=${param}    headers=${header}
#     Extracting value from json response
     ${actual_id}=    get value from json     ${response.json()}      user.id
     log to console    ${response.json()}
     should be equal as strings    ${actual_id[0]}   ${expected_id[0]}
     should be equal as strings    ${response.status_code}  200
     [Return]   ${actual_id}