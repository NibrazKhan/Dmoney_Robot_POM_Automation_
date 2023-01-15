*** Settings ***
Resource    ../Environment/Setup.robot
Resource    ../Requests/Login/Unsuccessful_Login.robot
Resource    ../Requests/Login/Successful_Login.robot
Resource    ../Requests/User_Creations/Create_Customer.robot
Resource    ../Requests/User_Details/Get_User_Details.robot
Resource    ../Requests/User_Update/User_Update.robot
Resource    ../Requests/User_Deletion/Delete_User.robot


*** Test Cases ***
TC01: Unsuccessful Login with invalid credentials
    Unsuccessful_Login.Unsuccessful Login with Wrong Email and Wrong Password    wrong@roadtocareer.net    wrong password
TC02: Successful Login
    [Tags]    Smoke
    Successful_Login.successful Login with valid credentials         salman@roadtocareer.net    1234
TC03: Creation of Customer
    Create_Customer.Creation of User    Customer    001
    Create_Customer.Creation of User    Customer    002
    Create_Customer.Creation of User    Agent       001
TC04: Extract Customer1 Details
    [Tags]    Smoke
    ${customer_1_id}=   Get_User_Details.Get User Details    Customer001_id
    log to console    id:${customer_1_id}
    set suite variable  $customer_1_id
TC05: Extract Customer2 Details
    ${customer_2_id}=   Get_User_Details.Get User Details    Customer002_id
TC06: Extract Agent Details
    Get_User_Details.Get User Details    Agent001_id
TC07: Update User
   [Tags]   Not important
   ${json_obj}=    load json from file    ${json_file_path}
   ${customer1_id}=   get value from json    ${json_obj}     $.Customer001_id
   User_Update.Update User   ${customer1_id[0]}
TC08: Delete User
   [Tags]   Not_important
   ${json_obj}=    load json from file    ${json_file_path}
   ${customer2_id}=   get value from json    ${json_obj}     $.Customer002_id
   Delete_User.Delete user    ${customer2_id[0]}


