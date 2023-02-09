*** Settings ***
Documentation    Pruebas automatizadas Booking_DeleteBooking
Library    RequestsLibrary
Library    OperatingSystem

*** Variables ***
${http_server}     https://restful-booker.herokuapp.com

*** Test Cases ***
Happy Test 1
    [Tags]    CP001 - Validar que el método responda OK
    # RECUPERAR TOKEN::
    ${headers_token}=    Create Dictionary     Content-Type=application/json
    ${request_token}=    Create Dictionary     username=admin    password=password123
    ${response_token}=    POST    ${http_server}/auth     json=${request_token}     headers=${headers_token}
    ${json_object}=    Set Variable    ${response_token.json()}
    ${token}=      Set Variable    ${json_object['token']}
    # Ejecuta DELETE::
    ${headers}=    Create Dictionary     Content-Type=application/json      Cookie=token=${token}
    ${response}=    DELETE    ${http_server}/booking/4   headers=${headers}
    Status Should Be    CREATED    ${response}