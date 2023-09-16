#!/usr/bin/env bash
################################################################################

#
# Script: 
# install_py_env.sh

#
# Description:
# This script aims to install the `pyenv`, `pipx` and `poetry` tools for 
# managing the Python Development Environment.

#
# Author: Thiago Ribeiro
# Date: 2023-09-15
# Version: 0.0.1

#
# Usage:
# To run this script. type ./install_pyenv.sh

#
# Dependencies:
# None.

#
# --------------- #
# Change Log       #
# --------------- #

#
# Version   Date          Author          Description
# -------   ----          ------          -----------
# 0.0.1     [2023-09-15]  Thiago Ribeiro  Initial release.


# 
# TODO: Verificar as Dependências para instalar o pynv, pipx e poetry

#
# FIXME: 


################################################################################

## Paleta de Cores
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLINK="\033[5m"
RESET="\033[0m"

## Validação

# Utilizamos command -v para verificar a presença de executáveis no sistema.
# Isso é uma abordagem mais precisa do que usar dpkg -l e grep para verificar a instalação.
# Quando uma dependência ausente é encontrada, o script perguntará ao usuário se deseja instalá-la 
# permitindo uma escolha mais flexível.
# Usamos read -p para receber a resposta do usuário.#
# O script verifica se a resposta do usuário é "Y" ou "y" antes de prosseguir com a instalação.
# Se o usuário optar por não instalar as dependências ausentes, 
# o script apenas exibirá uma mensagem informando sobre as dependências ausentes.

# Testar se cowsay está instalado
if ! command -v "cowsay" >/dev/null 2>&1; then
    pip install cowsay &>/dev/null
fi

# Lista de dependências e seus binários associados
declare -A dependencies
dependencies["git"]="git"
dependencies["pipx"]="pipx"
dependencies["pyenv"]="pyenv"
dependencies["poetry"]="poetry"

# Verificar e instalar as dependências ausentes
missing_dependencies=()

for dep in "${!dependencies[@]}"; do
    binary="${dependencies[$dep]}"
    if ! command -v "$binary" >/dev/null 2>&1; then
        missing_dependencies+=("$dep")
    fi
done

if [ ${#missing_dependencies[@]} -gt 0 ]; then
    echo -e "${YELLOW}As seguintes dependências estão ausentes: ${missing_dependencies[*]}${RESET}"
    read -p "Deseja instalá-las agora? (Y/N): " install_choice
    if [[ "$install_choice" =~ [Yy] ]]; then
        # Adicione os comandos de instalação aqui para as dependências ausentes
        for dep in "${missing_dependencies[@]}"; do
            case "$dep" in
                "pipx")
                    # Comandos para instalar pipx
                    pip install --user pipx &>/dev/null
                    python3 -m pipx ensurepath &>/dev/null
                    teste_install=$(cowsay -t "Instalação do pipx bem sucedida")
                    echo -e "${GREEN} ${teste_install} ${RESET}"
                    ;;
                "pyenv")
                    # Comandos para instalar pyenv
                    git clone https://github.com/pyenv/pyenv.git ~/.pyenv &>/dev/null
                    # variáveis de ambiente do .bashrc
                    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
                    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
                    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
                    if pyenv --version &>/dev/null; then
                        teste_install=$(cowsay -t "Instalação do pyenv bem sucedida")
                        echo -e "${GREEN} ${teste_install} ${RESET}"
                    fi
                    ;;
                "poetry")
                    # Comandos para instalar poetry
                    curl -sSL https://install.python-poetry.org | python3 - --git https://github.com/python-poetry/poetry.git@master &>/dev/null
                    if poetry --version &>/dev/null; then
                        teste_install=$(cowsay -t "Instalação do poetry bem sucedida")
                        echo -e "${GREEN} ${teste_install} ${RESET}"
                    fi
                    ;;
                *)
                    echo -e "${RED}Comandos de instalação para $dep não especificados. ${RESET}"
                    ;;
            esac
        done
    else
        echo -e "${RED}Você optou por não instalar as dependências ausentes. ${RESET}"
        exit 2
    fi
else
    echo -e "${GREEN}Todas as dependências estão instaladas.${RESET}"
    exit 0
fi


