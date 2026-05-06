# Arquivos adicionais 

## Arquivo de configuração (dbt_project.yml):

```
name: 'projeto_teste_dbt'
version: '1.0.0'
config-version: 2

# Nome do perfil definido no profiles.yml
profile: 'projeto_teste_dbt'

model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"
clean-targets:
  - "target"
  - "dbt_packages"

# Configurações de Materialização
models:
  projeto_teste_dbt:
    staging:
      +materialized: view
      +schema: staging
     intermediate:
      +schema: intermediate
      +materialization: view
    marts:
      +materialized: table
      +schema: marts
```

## Aquivo de definição de perfil e acesso ao banco (profiles.yml):
```
projeto_educacao:
  target: dev
  outputs:
    dev:
      type: duckdb
      # O caminho aponta para o banco criado pelo dlt no diretório raiz do exercício
      path: '../project_data.duckdb'
      schema: dev_marts
      threads: 4
```

## Dados a serem utilizados 

[Esforço Docente](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/indicadores-educacionais/esforco-docente)<br>
[Complexidade Gestão Escolar](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/indicadores-educacionais/complexidade-de-gestao-da-escola)
[Microdados da Educação Básica](https://download.inep.gov.br/dados_abertos/microdados_censo_escolar_2025_.zip)