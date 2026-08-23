*** Settings ***
Library    Browser
Resource    ../locators/enter_product_data_locators.robot
Resource    ../data/vehicle_insurance_data.robot


*** Keywords ***
Validar Etapa Enter Product Data
    Get Element    ${PRODUCT_DATA_TAB}


Preencher Dados Do Produto
    Fill Text    ${START_DATE_INPUT}    ${PRODUCT_START_DATE}
    Select Options By    ${INSURANCE_SUM_SELECT}    value    ${PRODUCT_INSURANCE_SUM}
    Select Options By    ${MERIT_RATING_SELECT}    label    ${PRODUCT_MERIT_RATING}
    Select Options By    ${DAMAGE_INSURANCE_SELECT}    label    ${PRODUCT_DAMAGE_INSURANCE}
    Click    ${EURO_PROTECTION_CHECKBOX}
    Select Options By    ${COURTESY_CAR_SELECT}    label    ${PRODUCT_COURTESY_CAR}


Avançar Para Select Price Option
    Click    ${PRODUCT_DATA_NEXT_BUTTON}
    Wait For Elements State    ${PRICE_OPTION_TAB}    visible
