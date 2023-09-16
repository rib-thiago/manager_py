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
### `install_py_env.sh`

**Descrição**: Este script objetiva instalar as ferramentas `pyenv`, `pipx` e `poetry` para o gerenciamento do Ambiente de Desenvovlimento Python.

---

### `manage_env.sh`

**Descrição**: Este script permite a listagem, criação, ativação e desativação de ambientes virtuais python.
---

### `pyenv_create.sh`

**Descrição**: Este script permite a instalação de uma versão do python com o `pyenv`, bem como a criação de diretórios para a organização de projetos com base nesta versão.