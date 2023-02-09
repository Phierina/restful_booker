*** Settings ***
Documentation    Pruebas automatizadas Booking_CreateBooking
Library    RequestsLibrary
Library    OperatingSystem

*** Variables ***
${http_server}     https://restful-booker.herokuapp.com

*** Test Cases ***
Happy Test 1
    [Tags]    CP001 - Validar que el método responda OK
    ${bookingdates}=    Create Dictionary     checkin=2018-01-01    checkout=2019-01-01
    ${headers}=    Create Dictionary     Content-Type=application/json
    ${request}=    Create Dictionary     firstname=Jim    lastname=Brown    totalprice=111  depositpaid=true  bookingdates=${bookingdates}  additionalneeds=Breakfast
    ${response}=    POST    ${http_server}/booking     json=${request}      headers=${headers}
    Status Should Be    OK    ${response}

Happy Test 2
    [Tags]    CP002 - Validar que las llaves contengan 'bookingid'
    ${bookingdates}=    Create Dictionary     checkin=2020-01-01    checkout=2022-01-01
    ${headers}=    Create Dictionary     Content-Type=application/json
    ${request}=    Create Dictionary     firstname=Luis    lastname=Da Silva    totalprice=115  depositpaid=true  bookingdates=${bookingdates}  additionalneeds=Breakfast
    ${response}=    POST    ${http_server}/booking     json=${request}      headers=${headers}
    ${keys}=  Call Method   ${response.json()}  keys
    Should Contain  ${keys}  bookingid