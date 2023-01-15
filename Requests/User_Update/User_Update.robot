*** Settings ***
Resource    ../../Environment/Setup.robot
Library    ../../CustomLibrary/BuiltinKeywords.py
*** Keywords ***
Update User
     [Arguments]    ${user_id}
     create session    mysession     ${base_url}
     ${user_info}=  create dictionary    name=Abul Kalam     email=abulkalam@gmail.com    password=kalam123   phone_number=01743534985  nid=6943534534   role=Customer
     #Converted dictionary to json
     ${user_info_json}=     evaluate    json.dumps(${user_info},indent=4)
     log to console   ${user_info_json}
     ${json_obj}=   load json from file     ${json_file_path}
     ${token}=      get value from json    ${json_obj}  $.token
     ${header}=  create dictionary   Content-Type=application/json; charset=utf-8   Authorization=${token[0]}  X-AUTH-SECRET-KEY=${secret_key}
     ${response}=    put request    mysession    /user/update/${user_id}    data=${user_info_json}      headers=${header}
     log to console    response: ${response.json()}
     ${message}=    get value from json     ${response.json()}      message
     log to console    ${message[0]}
     should contain    ${message[0]}     successfully
     should be equal as strings    ${response.status_code}   200
