*** Settings ***
Documentation    Pruebas automatizadas Auth_CreateToken
Library    RequestsLibrary
Library    OperatingSystem

*** Variables ***
${http_server}     https://restful-booker.herokuapp.com

*** Test Cases ***
Happy Test 1
    [Tags]    CP001 - Validar que el método responda OK
    ${headers}=    Create Dictionary     Content-Type=application/json
    ${request}=    Create Dictionary     username=admin    password=password123
    ${response}=    POST    ${http_server}/auth     json=${request}     headers=${headers}
    Log To Console  ${response.content}
    Status Should Be    OK    ${response}

Happy Test 2
    [Tags]    CP002 - Validar que las llaves contengan 'token'
    ${headers}=    Create Dictionary     Content-Type=application/json
    ${request}=    Create Dictionary     username=admin    password=password123
    ${response}=    POST    ${http_server}/auth     json=${request}     headers=${headers}
    ${keys}=  Call Method   ${response.json()}  keys
    Should Contain  ${keys}  token
