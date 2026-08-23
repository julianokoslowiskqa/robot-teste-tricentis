# Robot Tricentis

Automação end-to-end da cotação de seguro de veículo da aplicação Tricentis, construída com Robot Framework e Browser (Playwright).

## Estrutura

- `tests/features/vehicle_insurance.feature.robot`: cenários BDD executáveis.
- `resources/pages/`: Page Objects, um para cada etapa do formulário.
- `resources/locators/`: locators separados por etapa.
- `resources/data/vehicle_insurance_data.robot`: dados de teste reutilizáveis.
- `resources/keywords/`: keywords BDD que conectam a feature aos Page Objects.

## Execução

```powershell
poetry install
poetry run rfbrowser init
poetry run robot tests\features\vehicle_insurance.feature.robot
```

Para executar somente o fluxo completo de cotação:

```powershell
poetry run robot --include quote tests\features\vehicle_insurance.feature.robot
```
