# Exercício Prático: Modern Data Stack (dlt, dbt e DuckDB)

Este projeto simula um fluxo ponta a ponta de extração, carga e transformação de dados educacionais, ingerindo arquivos transacionais com o `dlt` para o `DuckDB` e orquestrando as regras de negócio e versionamento (SCD Tipo 2) na camada de staging utilizando `dbt`.

---

## 1. Guia de Configuração do Ambiente Virtual

Isole as dependências do projeto utilizando um ambiente virtual.

### 1.1 Criar o Ambiente
No terminal, na raiz do projeto, execute:
```bash
python -m venv .venv
```

### 1.2 Ativar o Ambiente
A forma de ativação depende do sistema operacional e terminal:

Windows (PowerShell): .\.venv\Scripts\activate (Se der erro de permissão: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process e tente novamente)

Windows (CMD): .venv\Scripts\activate.bat

Linux/macOS: source .venv/bin/activate

### Aqui está o guia completo unificado em um único arquivo Markdown. Ele consolida o passo a passo da configuração, os arquivos do Python, as configurações do dbt e a modelagem SQL, aplicando as transformações de limpeza e a lógica de Slowly Changing Dimension (SCD Tipo 2) diretamente na camada de staging.

Você pode copiar o conteúdo abaixo e salvar como README.md ou exercicio_mds.md na raiz do seu projeto.

Markdown
# Exercício Prático: Modern Data Stack (dlt, dbt e DuckDB)

Este projeto simula um fluxo ponta a ponta de extração, carga e transformação de dados educacionais, ingerindo arquivos transacionais com o `dlt` para o `DuckDB` e orquestrando as regras de negócio e versionamento (SCD Tipo 2) na camada de staging utilizando `dbt`.

---

## 1. Guia de Configuração do Ambiente Virtual

Isole as dependências do projeto utilizando um ambiente virtual.

### 1.1 Criar o Ambiente
No terminal, na raiz do projeto, execute:
```bash
python -m venv .venv
```
### 1.2 Ativar o Ambiente
A forma de ativação depende do sistema operacional e terminal:

Windows (PowerShell): .\.venv\Scripts\activate (Se der erro de permissão: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process e tente novamente)

Windows (CMD): .venv\Scripts\activate.bat

Linux/macOS: source .venv/bin/activate

### 1.3 Atualizar pip e Instalar Dependências
```
python -m pip install --upgrade pip
pip install -r requirements.txt
```

