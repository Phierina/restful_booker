*** Settings ***
Documentation    Pruebas automatizadas Booking_GetBookingIds
Library    RequestsLibrary

*** Variables ***
${http_server}     https://restful-booker.herokuapp.com

*** Test Cases ***
Happy Test
    [Tags]    CP001 - Validar que el método responda OK
    ${response}=    GET    ${http_server}/booking
    Status Should Be    OK    ${response}