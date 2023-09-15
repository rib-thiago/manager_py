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

# TODO:
# None.
#
# FIXME:
# None.
#
# XXX:
# None.
#
################################################################################

pyenv install $1  # Instale a versão Python desejada
version_name="$(echo $1 | tr '.' '_')_py"  # Converta a versão para um nome de diretório
mkdir -p ~/python_versions/$version_name  # Crie o diretório