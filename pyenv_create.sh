#!/usr/bin/env bash
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

# 
# TODO: Testar se script recebeu versão da linha de comando, se não recebeu, exibir mensagem de ajuda 
# TODO: Testar se versão informada já está instalada, se sim, mostrar versões instaladas
# TODO: Instalar versão do python instalada
# TODO: Usar versão instalada do para gerar a variável usada para criar o nome do diretório
# TODO: Criar diretório com o nome da versão;
# TODO: Exibir mensagem de confirmação
# TODO: Testar se o pyenv está instalado e, do contrário, exibir mensagem de erro
#
# FIXME: None.
#
################################################################################



pyenv install $1  # Instale a versão Python desejada
version_name="$(echo $1 | tr '.' '_')_py"  # Converta a versão para um nome de diretório
mkdir -p ~/python_versions/$version_name  # Crie o diretório