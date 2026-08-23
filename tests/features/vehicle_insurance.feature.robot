*** Settings ***
Documentation    Feature: cotação de seguro de veículo na aplicação Tricentis.
Resource    ../../resources/keywords/vehicle_insurance_keywords.robot

Suite Setup       Iniciar Navegador
Suite Teardown    Encerrar Navegador


*** Test Cases ***
Cenário: acessar a página de cotação de veículo
    [Documentation]    Primeiro cenário da feature; as próximas etapas serão implementadas progressivamente.
    [Tags]    smoke    regression    vehicle-insurance

    Given que acesso a aplicação Tricentis
    Then a página inicial da aplicação deve estar disponível


Cenário: preencher os dados básicos do segurado
    [Documentation]    Preenche nome, sobrenome, data de nascimento e seleciona o rádio masculino na aba Enter Insurant Data.
    [Tags]    regression    vehicle-insurance    insurant-data

    Given que acesso a aplicação Tricentis
    When que acesso a etapa Enter Insurant Data
    And preencho os dados básicos do segurado
    Then os dados básicos do segurado devem ser preenchidos


Cenário: enviar cotação de seguro de veículo com sucesso
    [Documentation]    Executa o fluxo completo da cotação e valida o e-mail enviado com sucesso.
    [Tags]    regression    vehicle-insurance    quote

    Given que acesso a aplicação Tricentis
    When preencho os dados do veículo
    And avanço para a etapa Enter Insurant Data
    And preencho os dados básicos do segurado
    And avanço para a etapa Enter Product Data
    And preencho os dados do produto
    And avanço para a etapa Select Price Option
    And seleciono a opção de preço Gold
    And avanço para a etapa Send Quote
    And preencho os dados para envio da cotação
    And envio a cotação
    Then a mensagem de sucesso no envio deve ser exibida
