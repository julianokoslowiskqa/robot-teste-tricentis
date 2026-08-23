*** Settings ***
Library    Browser
Resource    ../locators/enter_vehicle_data_locators.robot
Resource    ../data/vehicle_insurance_data.robot


*** Keywords ***
Validar Etapa Enter Vehicle Data
    Get Element    ${VEHICLE_DATA_TAB}


Preencher Dados Do Veículo
    Select Options By    ${MAKE_SELECT}    label    ${VEHICLE_MAKE}
    Fill Text    ${ENGINE_PERFORMANCE_INPUT}    ${VEHICLE_ENGINE_PERFORMANCE}
    Fill Text    ${DATE_OF_MANUFACTURE_INPUT}    ${VEHICLE_MANUFACTURE_DATE}
    Select Options By    ${NUMBER_OF_SEATS_SELECT}    label    ${VEHICLE_NUMBER_OF_SEATS}
    Select Options By    ${FUEL_TYPE_SELECT}    label    ${VEHICLE_FUEL_TYPE}
    Fill Text    ${LIST_PRICE_INPUT}    ${VEHICLE_LIST_PRICE}
    Fill Text    ${LICENSE_PLATE_NUMBER_INPUT}    ${VEHICLE_LICENSE_PLATE}
    Fill Text    ${ANNUAL_MILEAGE_INPUT}    ${VEHICLE_ANNUAL_MILEAGE}


Avançar Para Enter Insurant Data
    Click    ${VEHICLE_DATA_NEXT_BUTTON}
    Wait For Elements State    ${INSURANT_DATA_TAB}    visible
