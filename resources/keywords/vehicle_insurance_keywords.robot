*** Settings ***
Resource    ../pages/vehicle_insurance_page.robot
Resource    ../pages/enter_vehicle_data_page.robot
Resource    ../pages/enter_insurant_data_page.robot
Resource    ../pages/enter_product_data_page.robot
Resource    ../pages/select_price_option_page.robot
Resource    ../pages/send_quote_page.robot


*** Variables ***
${HEADLESS}    ${False}


*** Keywords ***
Iniciar Navegador
    New Browser    chromium    headless=${HEADLESS}
    Set Browser Timeout    10s


Encerrar Navegador
    Close Browser


Que acesso a aplicação Tricentis
    Abrir Página Inicial da Tricentis


A página inicial da aplicação deve estar disponível
    Validar Página Inicial da Tricentis


Que acesso a etapa Enter Insurant Data
    Abrir Etapa Enter Insurant Data


Preencho os dados básicos do segurado
    Preencher Dados Básicos Do Segurado


Os dados básicos do segurado devem ser preenchidos
    Validar Dados Básicos Do Segurado


Preencho os dados do veículo
    Preencher Dados Do Veículo


Avanço para a etapa Enter Insurant Data
    Avançar Para Enter Insurant Data


Avanço para a etapa Enter Product Data
    Avançar Para Enter Product Data


Preencho os dados do produto
    Preencher Dados Do Produto


Avanço para a etapa Select Price Option
    Avançar Para Select Price Option


Seleciono a opção de preço Gold
    Selecionar Opção De Preço Gold


Avanço para a etapa Send Quote
    Avançar Para Send Quote


Preencho os dados para envio da cotação
    Preencher Dados Para Envio Da Cotação


Envio a cotação
    Enviar Cotação


A mensagem de sucesso no envio deve ser exibida
    Validar Mensagem De Sucesso No Envio
