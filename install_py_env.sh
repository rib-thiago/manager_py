#!/usr/bin/env bash
################################################################################

#
# Script: 
# install_py_env.sh

#
# Description:
# This script aims to install the `pyenv`, `pipx` and `poetry` tools for 
# managing the Python Development Environment in Ubuntu and his flavors

#
# Author: Thiago Ribeiro
# Date: 2023-09-15
# Version: 0.0.2

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
# 0.0.2     [2023-09-20]  Thiago Ribeiro  Simplication of the logic,
#                                         and checking python then pip before 
#                                         trying to install pipx, poetry and pyenv 


# 
# TODO: Verificar as Dependências para instalar o pynv, pipx e poetry

#
# FIXME:  


################################################################################



# Lista de dependências e seus binários associados
declare -A dependencies
dependencies["python3"]="python3"
dependencies["pip"]="pip"
dependencies["cowsay"]="cowsay"
dependencies["pipx"]="pipx"
dependencies["pyenv"]="pyenv"
dependencies["poetry"]="poetry"

# Definir a ordem desejada para a instalação das dependências
install_order=("pip" "cowsay" "pipx" "poetry" "pyenv")

# Verificar e remover dependências já instaladas
for dep in "${!dependencies[@]}"; do
    if command -v "${dependencies[$dep]}" >/dev/null 2>&1; then
        unset dependencies["$dep"]
    fi
done

if [ ${#dependencies[@]} -gt 0 ]; then
    echo -e "As seguintes dependências estão ausentes: ${dependencies[@]}"
    read -p "Deseja instalá-las agora? (Y/N): " install_choice
    if [[ "$install_choice" =~ [Yy] ]]; then
        # Adicione os comandos de instalação aqui para as dependências ausentes
        for dep in "${install_order[@]}"; do
            if [[ -n "${dependencies[$dep]}" ]]; then
                case "$dep" in
                    "python3")
                        sudo apt install -y python3
                        [[ $? -ne 0 ]] && echo "Falhou" && exit 1
                        ;;
                    "pip")
                        sudo apt install python3-pip
                        [[ $? -ne 0 ]] && echo "Falhou" && exit 1
                        ;;
                    "cowsay")
                        pip install cowsay
                        [[ $? -ne 0 ]] && echo "Falhou" && exit 1
                        ;;
                    "pipx")
                        # Comandos para instalar pipx
                        pip install --user pipx &>/dev/null
                        python3 -m pipx ensurepath &>/dev/null
                        teste_install=$(cowsay -t "Instalação do pipx bem sucedida")
                        echo -e "${teste_install}"
                        ;;
                    "pyenv")
                        # Comandos para instalar pyenv
                        git clone https://github.com/pyenv/pyenv.git ~/.pyenv &>/dev/null
                        # variáveis de ambiente do .bashrc
                        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
                        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
                        echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
                        source .bashrc
                        if pyenv --version &>/dev/null; then
                            teste_install=$(cowsay -t "Instalação do pyenv bem sucedida")
                            echo -e "${teste_install}"
                        fi
                        ;;
                    "poetry")
                        # Comandos para instalar poetry
                        curl -sSL https://install.python-poetry.org | python3 - --git https://github.com/python-poetry/poetry.git@master &>/dev/null
                        if poetry --version &>/dev/null; then
                            teste_install=$(cowsay -t "Instalação do poetry bem sucedida")
                            echo -e "${teste_install}"
                        fi
                        ;;
                    *)
                        echo -e "Comandos de instalação para $dep não especificados."
                        ;;
                esac
            fi
        done
    else
        echo -e "Você optou por não instalar as dependências ausentes."
        exit 2
    fi
else
    echo -e "Todas as dependências estão instaladas."
    exit 0
fi