*** Settings ***
Resource    ../../resources/keywords/vehicle_insurance_keywords.robot


Suite Setup       Iniciar Navegador
Suite Teardown    Encerrar Navegador


*** Test Cases ***
Acessar página inicial da aplicação Tricentis
    [Documentation]    Acessa a página inicial da aplicação Tricentis.
    [Tags]    smoke    regression    vehicle-insurance

    Given que acesso a aplicação Tricentis
    Then a página inicial da aplicação deve estar disponível
