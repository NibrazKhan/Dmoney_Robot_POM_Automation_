*** Settings ***
Resource    ../../Environment/Setup.robot
Library    ../../CustomLibrary/BuiltinKeywords.py
Variables   ../Login/Successful_Login.robot

*** Keywords ***
Creation of User
     [Arguments]    ${user}    ${user_number}
     create session    mysession     ${base_url}
     @{random_data}=    generate_random_data
     ${user_info}=  create dictionary    name=${random_data[0]}     email=${random_data[1]}    password=${random_data[2]}    phone_number=${random_data[3]}   nid=${random_data[4]}    role=${user}
     #Converted dictionary to json
     ${user_info_json}=     evaluate    json.dumps(${user_info},indent=4)
     log to console   ${user_info_json}
     ${json_obj}=   load json from file     ${json_file_path}
     ${token}=      get value from json    ${json_obj}  $.token
     ${header}=  create dictionary   Content-Type=application/json; charset=utf-8   Authorization=${token[0]}  X-AUTH-SECRET-KEY=${secret_key}
     ${response}=    POST On Session    mysession   /user/create     data=${user_info_json}    headers=${header}
     log to console    response: ${response.json()}
     ${user_role}=      catenate    SEPARATOR=   ${user}     ${user_number}
     store user details in json    ${response.json()}   id  ${user_role}
     store user details in json    ${response.json()}   phone_number    ${user_role}
     ${message}=    get value from json     ${response.json()}      message
     log to console    ${message[0]}
     should be equal as strings    ${message[0]}   User created successfully
     should be equal as strings    ${response.status_code}  201