README.md

# Projeto de Estruturação do Ambiente de Desenvolvimento Python

Os Pprojetos possuem duas naturezas:
- estudos de bibliotecas ou áreas de atuação, que compartilham o mesmo ambiente virtual
- projetos (pacotes que desejo distribuir), que possuem um ambiente virtual isolado por projeto;

Independentemente do método e finalidade do ambiente virtual, estes são criados no diretório: `~/.venv/<ambiente-criado>`.

**O Presente repositório pretende ser uma coleção de scripts escitos em bash para gerenciar a instalação e manutenção de ambientes virtuais para desenvolvimento em python**

## Conteúdo:

A Estrutura do Diretório por enquanto é a seguinte:

```bash
$ tree
  .
  ├── README.md
  ├── install_py_env.sh
  ├── manage_env.sh
  └── pyenv_create.sh
  
  0 directories, 4 files

```

Script | Descrição
------------ | -------------
`install_py_env.sh` | Este script objetiva instalar as ferramentas `pyenv`, `pipx` e `poetry` para o gerenciamento do Ambiente de Desenvovlimento Python.
`manage_env.sh` | Este script permite listar, criar, ativar ou desativar ambientes virtuais python usando o módulo `venv` da biblioteca padrão do python
`pyenv_create.sh` | Este script permite a instalação de uma versão do python com o `pyenv`, bem como a criação automática de um diretório nomeado com base nesta versão para a organização dos projetos que compartilhem essa versão do Python.


### `install_py_env.sh`


---

### `manage_env.sh`



---

### `pyenv_create.sh`



---





