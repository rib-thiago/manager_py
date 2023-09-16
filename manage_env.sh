#!/usr/bin/env bash
################################################################################

#
# Script: 
# manage_env.sh

#
# Description:
# This is a bash script that allows you manage virtualenvs

#
# Author: Thiago Ribeiro
# Date: 2023-09-16
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
# 0.0.1     [2023-09-16]  Thiago Ribeiro  Initial release.


# 
# TODO: Criar Função para excluir venvs

#
# FIXME: 


################################################################################

## Paleta de Cores
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

## Inicialização de variáveis

# Caminho absoluto para o diretório .venv na sua home
DIR="$HOME/.venv"

## função que cria ambiente virtual
function create_venv() {
    echo -e "${YELLOW}Qual o nome do ambiente a ser criado? ${RESET}"
    read venv_name
    
    python3 -m venv $DIR/$venv_name

    # Verifica se o ambiente virtual foi ativado com sucesso
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}O Ambiente virtual '$venv_name' foi criado com sucesso.${RESET}"
    else
        echo -e $RED"O ambiente virtual '$venv_name' não foi criado com sucesso.${RESET}"
    fi

    list_venvs
}

## Função que exibe lista de ambientes virtuais disponíveis
function list_venvs() {
    # Cria uma lista de todos os ambientes virtuais
    venvs=($(ls -d $HOME/.venv/*/ 2>/dev/null))

    # Exibe a lista de ambientes virtuais
    if [[ ${#venvs[@]} -eq 0 ]]; then
        echo -e "${RED}Não há ambientes virtuais disponíveis.${RESET}"
    else
        echo "Ambientes virtuais disponíveis:"
        for ((i=0; i<${#venvs[@]}; i++)); do
            venv_name=$(basename ${venvs[$i]})
            printf "%-5s %s\n" "$i:" "$venv_name" 
        done
    fi
}

# Função que ativa venv
function activate_venv() {
    # Solicita ao usuário que escolha um ambiente virtual
    read -p "Escolha o número do ambiente virtual a ser ativado: " choice

    # Verifica se a escolha é válida
    if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -ge 0 ] && [ $choice -lt ${#venvs[@]} ]; then
        selected_venv=${venvs[$choice]}
        venv_name=$(basename $selected_venv)

        # Monta o caminho absoluto para ativar o ambiente virtual
        activate_script="$DIR/$venv_name/bin/activate"
        read -p "$activate_script"
        # Ativa o ambiente virtual usando o caminho absoluto
        source $activate_script

        # Verifica se o ambiente virtual foi ativado com sucesso
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}Ambiente virtual '${venv_name}' ativado.${RESET}"
        else
            echo -e "${RED}O ambiente virtual '${venv_name}' não foi ativado.${RESET}"
        fi
    else
        echo -e  "${RED}Escolha Inválida.${RESET}"
    fi
}


## main

if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
else
    list_venvs
    # Pergunta ao usuário se deseja criar um novo ambiente virtual
    read -p "Deseja ativar ambiente virtual? (Ss / Nn) " escolha
    case $escolha in
        [Ss])
            activate_venv
            ;;
        [Nn])
            read -p "Deseja aticriar um ambiente virtual? (Ss / Nn) " criar
            if [[ $criar =~ [Ss] ]]; then
                create_venv
                activate_venv
            fi
            ;;
        *)
            echo "A escolha não é válida."
            ;;
    esac
fi
