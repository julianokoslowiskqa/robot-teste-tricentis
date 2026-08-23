*** Settings ***
Library    Browser
Resource    ../locators/enter_insurant_data_locators.robot
Resource    ../data/vehicle_insurance_data.robot


*** Keywords ***
Validar Etapa Enter Insurant Data
    Get Element    ${INSURANT_DATA_TAB}


Abrir Etapa Enter Insurant Data
    Click    ${INSURANT_DATA_TAB}
    Validar Etapa Enter Insurant Data


Preencher Dados Básicos Do Segurado
    Fill Text    ${FIRST_NAME_INPUT}    ${INSURANT_FIRST_NAME}
    Fill Text    ${LAST_NAME_INPUT}    ${INSURANT_LAST_NAME}
    Fill Text    ${BIRTH_DATE_INPUT}    ${INSURANT_BIRTH_DATE}
    Click    ${MALE_GENDER_RADIO}
    Fill Text    ${STREET_ADDRESS_INPUT}    ${INSURANT_STREET_ADDRESS}
    Select Options By    ${COUNTRY_SELECT}    value    ${INSURANT_COUNTRY}
    Fill Text    ${ZIP_CODE_INPUT}    ${INSURANT_ZIP_CODE}
    Fill Text    ${CITY_INPUT}    ${INSURANT_CITY}
    Select Options By    ${OCCUPATION_SELECT}    label    ${INSURANT_OCCUPATION}
    Click    ${SPEEDING_CHECKBOX}


Validar Dados Básicos Do Segurado
    Get Property    ${FIRST_NAME_INPUT}    value    ==    ${INSURANT_FIRST_NAME}
    Get Property    ${LAST_NAME_INPUT}    value    ==    ${INSURANT_LAST_NAME}
    Get Property    ${BIRTH_DATE_INPUT}    value    ==    ${INSURANT_BIRTH_DATE}
    Get Property    ${MALE_GENDER_INPUT}    checked    ==    ${True}


Avançar Para Enter Product Data
    Click    ${INSURANT_DATA_NEXT_BUTTON}
    Wait For Elements State    ${PRODUCT_DATA_TAB}    visible
