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
	
Criar um workflow para a ativação ou desativação destes ambientes:

- script para criar diretório com o nome da versão criada com pyenv (ex 3_11_5_py/)
- listar os ambientes através de um script.
- script para criar uma infraestrutura compartilhada com módulo venv
- script para criar um diretório dentro do diretório da versão (ex 3_11_5_py/) para o ambiente virtual criado, independentemente do método. (ex: 3_11_5_py/env_<nome-do-ambiente>/<projeto_que_recebeu_link_>/)
- script para criar um link simbólico entre um ambiente virtual para o diretório do ambiente virtual


___

# Script para criar diretório:

# FIXME: Para Instalar o versões abaixo de 3.6, precisamos seguir um [workaroud](https://github.com/pyenv/pyenv/issues/945)



---

# Proposta de script para gerenciamento de ambientes virtuais

```bash {.line-numbers}
#!/bin/bash

# Função para criar um ambiente virtual com venv
create_venv() {
    python_version="$1"
    env_name="$2"
    python -m venv ~/.venv/$env_name
    source ~/.venv/$env_name/bin/activate
}

# Função para criar um ambiente virtual com Poetry
create_poetry_env() {
    env_name="$1"
    poetry env use ~/.venv/$env_name
    poetry install
}

# Função para listar ambientes virtuais
list_envs() {
    ls -d ~/.venv/*/
}

# Função para ativar um ambiente virtual
activate_env() {
    source ~/.venv/$1/bin/activate
}

# Função para desativar um ambiente virtual
deactivate_env() {
    deactivate
}

# Uso: ./manage_virtual_env.sh create venv 3.11.5 my_shared_env
# Uso: ./manage_virtual_env.sh create poetry my_project_env
# Uso: ./manage_virtual_env.sh list
# Uso: ./manage_virtual_env.sh activate my_shared_env
# Uso: ./manage_virtual_env.sh deactivate

if [ "$1" == "create" ]; then
    if [ "$2" == "venv" ]; then
        create_venv "$3" "$4"
    elif [ "$2" == "poetry" ]; then
        create_poetry_env "$3"
    fi
elif [ "$1" == "list" ]; then
    list_envs
elif [ "$1" == "activate" ]; then
    activate_env "$2"
elif [ "$1" == "deactivate" ]; then
    deactivate_env
fi
```

Salvar como manage_virtual_env.sh.

#### Função para ativar um ambiente virtual

```bash {.line-numbers}
activate_env() {
    env_name="$1"
    if [[ -d ~/.venv/$env_name ]]; then
        if [[ -f ~/.venv/$env_name/bin/activate ]]; then
            source ~/.venv/$env_name/bin/activate
        else
            echo "Atenção: Não foi possível ativar o ambiente virtual $env_name."
        fi
    else
        echo "Atenção: O ambiente virtual $env_name não existe."
    fi
}
```

#### Função para desativar um ambiente virtual

```
deactivate_env() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        if command -v poetry &>/dev/null; then
            poetry env exit
        else
            deactivate
        fi
    else
        echo "Atenção: Nenhum ambiente virtual ativo."
    fi
}
```


# Script para criar links simbólicos para ambientes virtuais:

```bash {.line-numbers}
#!/bin/bash

# Uso: ./create_env_links.sh 3.11.5 my_shared_env

python_version="$1"
env_name="$2"
version_name="$(echo $python_version | tr '.' '_')_py"
env_dir="~/.venv/$env_name"

if [ -d "$env_dir" ]; then
    mkdir -p ~/python_versions/$version_name/env_$env_name
    ln -s $env_dir ~/python_versions/$version_name/env_$env_name/
    echo "Link simbólico criado para $env_name em ~/python_versions/$version_name/env_$env_name/"
else
    echo "O ambiente virtual $env_name não existe."
fi

```
Salvar arquivo create_env_links.sh. 
Executar ./create_env_links.sh 3.11.5 my_shared_env 
	para criar um link simbólico para o ambiente virtual my_shared_env na versão Python 3.11.5.

___

# Configuração do Poetry

Pode ser realizada através do comando `config` ou diretamente no arquivo `config.toml` que é gerado automaticamente quando executamos o comando `config` pela primeira vez.

O arquivo `config.toml` nos sitemas *UNIX Like* segue, as especificações [XDG Base Directory], e está localizado em `~/.config/pypoetry`.

## Configuração Local

Poetry também permite ter configurações específicas para um projeto, passando a opção `--local` para o comando `config`:

```bash {.line-numbers}
poetry config virtualenvs.create false --local
```

As configurações locais de uma aplicação Poetry são armazenadas no arquivo `poetry.toml`, separado do arquivo `pyproject.toml`.

***Atenção ao fazer check-in deste arquivo em seu repositório, pois ele pode conter informações confidenciais ou específicas do usuário.***

## Listando as configurações atuais

Para listar as configurações atuais, informe a opção `--list` ao comando `config`:

```bash {.line-numbers}
poetry config --list
```

que gerará uma saída semelhante a :

```{.line-numbers}

```



___


[XDG Base Directory]:<https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html>

