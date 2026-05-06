#!/bin/bash

# Nome do ambiente virtual
VENV_NAME=".venv"

echo "Criando o ambiente virtual..."
python3 -m venv $VENV_NAME

echo "Ativando o ambiente virtual..."
source $VENV_NAME/bin/activate

echo "Atualizando o pip..."
pip install --upgrade pip

echo "Instalando as dependências do requirements.txt..."
pip install -r requirements.txt

echo "Ambiente pronto e ativado!"
# Para rodar manualmente depois: source .venv/bin/activate