*** Settings ***
Library    Browser
Resource    ../locators/select_price_option_locators.robot


*** Keywords ***
Validar Etapa Select Price Option
    Get Element    ${PRICE_OPTION_TAB}


Selecionar Opção De Preço Gold
    Get Element    ${GOLD_PRICE_OPTION}
    Check Checkbox    ${GOLD_PRICE_OPTION}    force=True


Avançar Para Send Quote
    Click    ${PRICE_OPTION_NEXT_BUTTON}
    Wait For Elements State    ${SEND_QUOTE_TAB}    visible
