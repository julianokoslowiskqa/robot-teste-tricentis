# Robot Tricentis

Projeto de automação end-to-end da aplicação [Tricentis Vehicle Insurance](http://sampleapp.tricentis.com/101/app.php), construído com **Robot Framework**, biblioteca **Browser** e **Playwright**.

O fluxo automatizado simula a criação de uma cotação de seguro de automóvel: preenche os dados do veículo, segurado e produto, escolhe o plano Gold, envia a cotação e confirma a mensagem `Sending e-mail success!`.

## Tecnologias e versões

| Tecnologia | Versão usada/compatível | Finalidade |
| --- | --- | --- |
| Python | `>=3.10` e `<3.13` | Linguagem e ambiente de execução |
| Python validado neste projeto | `3.11.6` | Versão utilizada na validação local |
| Poetry | `2.4.1` | Gerenciamento de dependências e ambiente virtual |
| Robot Framework | `7.4.2` | Framework de automação e escrita dos cenários BDD |
| robotframework-browser | `20.4.0` | Biblioteca Browser baseada em Playwright |
| Playwright | Instalado pelo `rfbrowser init` | Controle do navegador Chromium |
| allure-robotframework | `2.16.0` | Integração para geração de resultados Allure |
| robotframework-tidy | `4.18.0` | Formatação dos arquivos Robot (dependência de desenvolvimento) |

As versões resolvidas ficam registradas em `poetry.lock`, garantindo uma instalação reproduzível.

## Pré-requisitos

Antes de executar, instale:

1. [Python](https://www.python.org/downloads/) em uma versão entre 3.10 e 3.12. Recomenda-se Python 3.11.
2. [Poetry](https://python-poetry.org/docs/#installation) 2.x.
3. Git (opcional, necessário apenas para versionamento).
4. Visual Studio Code (opcional, recomendado para desenvolvimento).
5. Acesso à internet para baixar as dependências e acessar a aplicação de teste.

No Windows, confirme as instalações no PowerShell:

```powershell
python --version
poetry --version
git --version
```

## Configuração do projeto

Clone o repositório e entre na pasta do projeto:

```powershell
git clone https://github.com/julianokoslowiskqa/robot-teste-tricentis.git
cd robot-teste-tricentis
```

Se houver mais de uma versão do Python instalada, selecione explicitamente a versão 3.11:

```powershell
poetry env use 3.11
```

Instale todas as dependências declaradas no `pyproject.toml`:

```powershell
poetry install
```

Inicialize a parte Node.js/Playwright da biblioteca Browser. Esse comando deve ser executado pelo menos uma vez após instalar ou atualizar `robotframework-browser`:

```powershell
poetry run rfbrowser init
```

> Se o ambiente corporativo bloquear downloads, configure o proxy de rede antes de executar o comando acima. O Chromium é necessário para os testes.

## Executando os testes

Execute a feature completa:

```powershell
poetry run robot --outputdir results tests\features\vehicle_insurance.feature.robot
```

Execute somente o cenário end-to-end de envio da cotação:

```powershell
poetry run robot --outputdir results --include quote tests\features\vehicle_insurance.feature.robot
```

Execute apenas o cenário da etapa **Enter Insurant Data**:

```powershell
poetry run robot --outputdir results --include insurant-data tests\features\vehicle_insurance.feature.robot
```

Ao término, os artefatos gerados ficam em `results/`:

| Arquivo | Conteúdo |
| --- | --- |
| `report.html` | Resumo da execução |
| `log.html` | Log detalhado por keyword |
| `output.xml` | Resultado XML do Robot Framework |

## Cenários automatizados

O arquivo `tests/features/vehicle_insurance.feature.robot` contém cenários em estilo BDD (`Given`, `When`, `Then`):

1. Acessar a página de cotação de veículo.
2. Preencher os dados básicos da aba **Enter Insurant Data**.
3. Enviar uma cotação completa com sucesso:
   - Selecionar o contexto **Automobile**;
   - Preencher **Enter Vehicle Data** e avançar;
   - Preencher **Enter Insurant Data** e avançar;
   - Preencher **Enter Product Data** e avançar;
   - Selecionar o plano **Gold** e avançar;
   - Preencher **Send Quote** e acionar **Send**;
   - Validar a mensagem `Sending e-mail success!`.

## Arquitetura

O projeto adota o padrão **Page Object Model (POM)** para evitar que regras de fluxo e locators fiquem misturados:

```text
tests/
├── features/
│   └── vehicle_insurance.feature.robot     # Cenários BDD executáveis
└── vehicle_insurance/
    └── access_page.robot                   # Cenário básico de acesso

resources/
├── data/
│   └── vehicle_insurance_data.robot        # Dados de teste centralizados
├── keywords/
│   └── vehicle_insurance_keywords.robot    # Camada BDD/orquestração
├── locators/                                # Um arquivo de locator por etapa
│   ├── enter_vehicle_data_locators.robot
│   ├── enter_insurant_data_locators.robot
│   ├── enter_product_data_locators.robot
│   ├── select_price_option_locators.robot
│   └── send_quote_locators.robot
└── pages/                                   # Um Page Object por etapa
    ├── enter_vehicle_data_page.robot
    ├── enter_insurant_data_page.robot
    ├── enter_product_data_page.robot
    ├── select_price_option_page.robot
    └── send_quote_page.robot
```

### Responsabilidades das camadas

- **Feature:** descreve o comportamento esperado em linguagem BDD.
- **Keywords:** traduz as frases BDD em chamadas de Page Objects.
- **Pages:** contém as ações e validações de cada tela.
- **Locators:** centraliza seletores (`id`, `xpath`) da página.
- **Data:** mantém os valores de teste separados das ações de interface.

## Desenvolvimento no VS Code

Abra a pasta raiz do projeto no VS Code:

```powershell
code .
```

Extensões recomendadas:

- **Python** (Microsoft)
- **Robot Framework Language Server** (Robocorp)

No seletor de interpretador do VS Code, selecione o ambiente virtual criado pelo Poetry. Para localizar o caminho do ambiente, execute:

```powershell
poetry env info --path
```

## Formatação

Para formatar arquivos `.robot`, utilize o Robotidy instalado como dependência de desenvolvimento:

```powershell
poetry run robotidy tests resources
```

Revise as alterações sugeridas antes de realizar um commit.

## Solução de problemas

### `rfbrowser init` falha

Confirme que o Poetry está usando uma versão compatível do Python e que a rede permite downloads. Depois, execute novamente:

```powershell
poetry env use 3.11
poetry install
poetry run rfbrowser init
```

### Navegador não inicia

Reexecute a inicialização do Browser:

```powershell
poetry run rfbrowser init
```

### O site da Tricentis não responde

Verifique a conectividade com a URL da aplicação e tente executar o cenário novamente. A aplicação é externa ao projeto; indisponibilidades dela impedem a execução do fluxo.

## Evidência de validação

Na última validação local, a feature foi executada com sucesso:

```text
3 tests, 3 passed, 0 failed
```
