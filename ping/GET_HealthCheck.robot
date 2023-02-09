*** Settings ***
Documentation    Pruebas automatizadas Ping_HealthCheck
Library    RequestsLibrary
Library    OperatingSystem

*** Variables ***
${http_server}     https://restful-booker.herokuapp.com

*** Test Cases ***
Happy Test
    [Tags]    CP001 - Validar que el método responda OK
    ${response}=    GET    ${http_server}/ping
    Status Should Be    CREATED    ${response}