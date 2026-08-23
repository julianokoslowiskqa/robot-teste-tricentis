*** Settings ***
Library    Browser
Resource   ../locators/vehicle_insurance_locators.robot


*** Keywords ***
Abrir Página Inicial da Tricentis
    New Page    ${URL_TRICENTIS}
    Click    ${AUTOMOBILE_NAVIGATION}
    Wait For Elements State    id=nextenterinsurantdata    visible


Validar Página Inicial da Tricentis
    ${url}=    Get Url
    Should Contain    ${url}    sampleapp.tricentis.com/101/app.php
