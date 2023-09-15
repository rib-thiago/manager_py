# Projeto de Estruturação do Ambiente de Desenvolvimento Python

Os Pprojetos possuem duas naturezas:
- estudos de bibliotecas ou áreas de atuação:
    - compartilham o mesmo ambiente virtual, criado com o módulo venv do python
- projetos (pacotes que desejo distribuir):
    - Ambiente virtual:Projeto, criado com o comando poetry install

Independentemente do método e finalidade do ambiente virtual, estes são criados no diretório:
- (~/.venv/<ambiente-criado>)
    1 - python3 -m venv ~/.venv/<nome-do-ambiente>
    2 - virtualenvs.path = "/home/thiago/.venv"

# TODO: AUTOMATIZAR:
	- criar um workflow para a ativação ou desativação destes ambientes
		- script para criar diretório com o nome da versão criada com pyenv (ex 3_11_5_py/)
		- listar os ambientes através de um script.
		- script para criar uma infraestrutura compartilhada com módulo venv
		- script para criar um diretório dentro do diretório da versão (ex 3_11_5_py/)
		    para o ambiente virtual criado, independentemente do método.
		    (ex: 3_11_5_py/env_<nome-do-ambiente>/<projeto_que_recebeu_link_>/)
		- script para criar um link simbólico entre um ambiente virtual para o diretório do ambiente virtual


# Proposta de script para criar diretório:

```bash {.line-number}
#!/bin/bash

pyenv install $1  # Instale a versão Python desejada
version_name="$(echo $1 | tr '.' '_')_py"  # Converta a versão para um nome de diretório
mkdir -p ~/python_versions/$version_name  # Crie o diretório
```
Salvar este script, pyenv_create.sh
Executar: bash pyenv_create.sh 3.11.5
