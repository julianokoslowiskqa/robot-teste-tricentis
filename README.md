# Framework de Teste Automatizado com Robot Framework
Este é um projeto de estudo de automação de testes web criado com Robot Framework.

Nele, automatizei o fluxo de cotação de seguro da aplicação [Tricentis Vehicle Insurance](http://sampleapp.tricentis.com/101/app.php). O teste acessa o site, preenche os dados do veículo, do segurado e do produto, escolhe uma opção de preço, envia a cotação e valida a mensagem final de sucesso.

O objetivo é demonstrar uma estrutura simples, organizada e fácil de evoluir, usando BDD e o padrão Page Object Model. Os locators, as ações de cada tela e os dados de teste ficam separados para tornar a manutenção mais tranquila.

Fique à vontade para baixar o projeto, executar os testes e utilizá-lo como referência para aprender Robot Framework e automação web com Playwright.

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

## Requisitos

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

## Como preparar o projeto

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
poetry install --no-root
```

Inicialize a parte Node.js/Playwright da biblioteca Browser. Esse comando deve ser executado pelo menos uma vez após instalar ou atualizar `robotframework-browser`:

```powershell
poetry run rfbrowser init
```

> Se o ambiente corporativo bloquear downloads, configure o proxy de rede antes de executar o comando acima. O Chromium é necessário para os testes.

## Como rodar o projeto

Depois de concluir a preparação, execute a feature completa com:

```powershell
poetry run robot --outputdir results tests\features\vehicle_insurance.feature.robot
```

Se quiser executar somente o fluxo completo de envio da cotação:

```powershell
poetry run robot --outputdir results --include quote tests\features\vehicle_insurance.feature.robot
```

Para executar apenas o cenário da etapa **Enter Insurant Data**:

```powershell
poetry run robot --outputdir results --include insurant-data tests\features\vehicle_insurance.feature.robot
```

Ao término, os artefatos gerados ficam em `results/`:

| Arquivo | Conteúdo |
| --- | --- |
| `report.html` | Resumo da execução |
| `log.html` | Log detalhado por keyword |
| `output.xml` | Resultado XML do Robot Framework |

## Relatório Allure

Além dos relatórios nativos do Robot Framework, o projeto possui a dependência `allure-robotframework` para gerar um relatório visual com os detalhes da execução.

Com o [Allure Commandline](https://allurereport.org/docs/install/) instalado, execute todos os testes com o listener do Allure:

```powershell
poetry run robot --listener allure_robotframework --outputdir results tests
```

Os dados do Allure serão criados em `output/allure`. Em seguida, gere o relatório HTML:

```powershell
allure generate output\allure --clean --output allure-report
```

Não abra `allure-report/index.html` com duplo clique, pois o navegador bloqueia o carregamento dos dados do Allure pelo protocolo `file:///`. Para visualizar o relatório, inicie o servidor local do Allure:

```powershell
allure open allure-report
```

O comando abrirá automaticamente o relatório no navegador. Caso o Allure CLI não esteja disponível, inicie um servidor HTTP na pasta do relatório:

```powershell
cd allure-report
python -m http.server 8000
```

Depois, acesse `http://localhost:8000` no navegador.

## GitHub Actions

O workflow [robot-tests.yml](.github/workflows/robot-tests.yml) executa automaticamente em `push` e `pull request` para a branch `master`. Ele também pode ser iniciado manualmente pela aba **Actions** do GitHub.

Para reduzir o tempo de execução, os cenários são divididos em três jobs paralelos:

1. **Smoke - acesso à aplicação**;
2. **Enter Insurant Data**;
3. **Cotação completa**.

Todos os jobs executam o Chromium em modo headless, instalam as dependências com Poetry e publicam os logs do Robot e os dados do Allure como artefatos. Ao final, o job **Relatório Allure** reúne os resultados dos três jobs e disponibiliza o relatório HTML para download.

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

## Como o projeto foi organizado

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
poetry install --no-root
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
