*** Settings ***
Library    Browser
Resource    ../locators/send_quote_locators.robot
Resource    ../data/vehicle_insurance_data.robot


*** Keywords ***
Validar Etapa Send Quote
    Get Element    ${SEND_QUOTE_TAB}


Preencher Dados Para Envio Da Cotação
    Fill Text    ${EMAIL_INPUT}    ${QUOTE_EMAIL}
    Fill Text    ${PHONE_INPUT}    ${QUOTE_PHONE}
    Fill Text    ${USERNAME_INPUT}    ${QUOTE_USERNAME}
    Fill Secret    ${PASSWORD_INPUT}    $QUOTE_PASSWORD
    Fill Secret    ${CONFIRM_PASSWORD_INPUT}    $QUOTE_PASSWORD
    Fill Text    ${COMMENTS_INPUT}    ${QUOTE_COMMENTS}


Enviar Cotação
    Click    ${SEND_QUOTE_BUTTON}


Validar Mensagem De Sucesso No Envio
    Get Text    ${SEND_QUOTE_SUCCESS_MESSAGE}    ==    Sending e-mail success!
