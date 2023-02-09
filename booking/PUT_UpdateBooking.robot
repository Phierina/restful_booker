*** Settings ***
Documentation    Pruebas automatizadas Booking_UpdateBooking
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
    # Ejecuta PUT::
    ${headers}=    Create Dictionary     Content-Type=application/json      Accept=application/json     Cookie=token=${token}
    ${bookingdates}=    Create Dictionary     checkin=2021-02-05    checkout=2022-03-20
    ${request}=    Create Dictionary     firstname=Ana    lastname=Ruiz    totalprice=111  depositpaid=true  bookingdates=${bookingdates}  additionalneeds=Breakfast
    ${response}=    PUT    ${http_server}/booking/3     json=${request}     headers=${headers}
    Status Should Be    OK    ${response}

Happy Test 2
    [Tags]   CP002 - Validar que se hayan realizado los cambios en el campo "firstname"
    ${response}=    GET    ${http_server}/booking/3
    ${json_object}=    Set Variable    ${response.json()}
    ${firstname}=      Set Variable    ${json_object['firstname']}
    Should Be Equal     ${firstname}    Ana

Happy Test 3
    [Tags]   CP003 - Validar que se hayan realizado los cambios en el campo "additionalneeds"
    ${response}=    GET    ${http_server}/booking/3
    ${json_object}=    Set Variable    ${response.json()}
    ${additionalneeds}=      Set Variable    ${json_object['additionalneeds']}
    Should Be Equal     ${additionalneeds}    Breakfast