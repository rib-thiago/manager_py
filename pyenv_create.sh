#!/usr/bin/env bash
################################################################################

#
# Script: 
# pyenv_create.sh

#
# Description:
# This is a bash script that allows you to automatically create directories named after
# the python version during the installation process with pyenv

#
# Author: Thiago Ribeiro
# Date: 2023-09-15
# Version: 0.0.1

#
# Usage:
# To run this script. type ./pyenv_create.sh <python-version>

#
# Dependencies:
# - pyenv

#
# --------------- #
# Change Log       #
# --------------- #

#
# Version   Date          Author          Description
# -------   ----          ------          -----------
# 0.0.1     [2023-01-07]  Thiago Ribeiro  Initial release.


# 
# TODO: None.

#
# FIXME: Implementar uma barra de progresso quando da instalação do python em segundo plano
# FIXME: Função para escrever mensagem por parâmentros
# FIXME: Só funciona até python 3.5

################################################################################

## Paleta de Cores
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLINK="\033[5m"
RESET="\033[0m"


## Validações:

# Verificar se a versão da linha de comando foi fornecida
# Verificação da quantidade de argumentos passados na linha de comando ($#). 
# Se nenhum argumento for fornecido, exibe uma mensagem de uso e sai com um código de erro.
if [ $# -eq 0 ]; then
    echo -e "${RED}Uso: $0 <versão_python>${RESET}"
    exit 1
fi

# Veriricar se a versão fornecida é igual a no mínimo 3.5
# Extrair a parte decimal da versão Python (exemplo: 3.7.1 -> 7)
version_decimal=$(echo "$1" | cut -d. -f2)
if ! [[ "$version_decimal" -ge 5 ]]; then
    echo -e "${RED}Versão mínima para instalação: 3.5${RESET}"
    exit 2
fi


# Verificar se a versão informada já está instalada
# Usando o comando pyenv versions --bare e grep. 
# Se já instalada, exibe uma mensagem informando que a versão já está instalada e 
# mostra as versões Python instaladas usando pyenv versions.
if pyenv versions --bare | grep -q "$1"; then
    echo -e "${YELLOW}A versão Python $1 já está instalada. Versões instaladas:"
    pyenv versions
    echo -e "${RESET}"
    exit 1
fi

## Instalação

# Pedir permissão para instalar em segundo plano
read -p "Deseja instalar a versão Python $1 em segundo plano? (y/n): " answer
echo -e "${YELLOW}"
if [ "$answer" == "y" ]; then
    # Instalar a versão Python desejada
    if pyenv install $1 &>/dev/null; then
        echo -e "${GREEN}A versão Python $1 foi instalada com sucesso em $HOME/.pyenv/$1.  ${RESET}"
    else
        echo -e "${RED}Erro ao instalar a versão Python $1:  ${RESET}"
    fi
else
    if pyenv install $1; then
        echo -e "${GREEN}A versão Python $1 foi instalada com sucesso em $HOME/.pyenv/$1.  ${RESET}"
    else
        echo -e "${RED}Erro ao instalar a versão Python $1:  ${RESET}"
    fi
fi

# Converter a versão para um nome de diretório
version_name="$(echo $1 | tr '.' '_')_py"
if [ -d "$HOME/$version_name" ]; then
    echo -e "${RED}O diretório $version_name existe em $HOME. ${RESET}"
    echo -e "${YELLOW}Crie manualmente o diretório para a seus projetos nesta versão. ${RESET}"
    exit 1
else
    read -p "Criando o diretório: ${version_name} em $HOME"
    if mkdir -p $HOME/${version_name} &>/dev/null; then
        echo -e "${GREEN}o diretório: ${version_name} foi criado em $HOME com sucesso!  ${RESET}"
    else
        echo -e "${RED}Erro ao criar o diretório  ${version_name} em $HOME. ${RESET}"
        echo -e "${YELLOW}Crie manualmente o diretório para a seus projetos nesta versão${RESET}"
        exit 1
    fi
fi

exit 0