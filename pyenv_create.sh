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



# Verificar se a versão da linha de comando foi fornecida
# Verificação da quantidade de argumentos passados na linha de comando ($#). 
# Se nenhum argumento for fornecido, exibe uma mensagem de uso e sai com um código de erro.
if [ $# -eq 0 ]; then
  echo "Uso: $0 <versão_python>"
  exit 1
fi

# Verificar se a versão informada já está instalada
# Usando o comando pyenv versions --bare e grep. 
# Se já instalada, exibe uma mensagem informando que a versão já está instalada e 
# mostra as versões Python instaladas usando pyenv versions.
if pyenv versions --bare | grep -q "$1"; then
  echo "A versão Python $1 já está instalada. Versões instaladas:"
  pyenv versions
  exit 1
fi

# Instalar a versão Python desejada
pyenv install $1

# Converter a versão para um nome de diretório
version_name="$(echo $1 | tr '.' '_')_py"

# Criar o diretório
mkdir -p ~/python_versions/$version_name

echo "A versão Python $1 foi instalada com sucesso em ~/python_versions/$version_name."