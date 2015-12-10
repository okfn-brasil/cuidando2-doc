Uma versão compacta das instruções a seguir é oferecida também em [`main.sh`](./src/main.sh). (ops rever para municipio.sh).

## Convenções

Estamos adotando [Convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration), ou seja, não ficamos comentando opções do usuário, pressupomos um padrão, e ficaria a cargo do usuário ou de uma documentação secundária qualquer desvio do padrão.

Padrões:

* Ambiente [Ubuntu 14.04 LTS](https://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29)
* Motores default [Python3](https://docs.python.org/3/)
* Base de dados default [PostgreSQL 9.3](http://www.postgresql.org/docs/9.3/static/), que vem com o apt-get do UBUNTU 14 em 2015.

Dessa forma foram removidas todas as condicionantes, como "Se for usar Postgres".
Outra convenção é que o script de instalação roda sob uma pasta vazia chamada *sandbox*,

```
mkdir sandbox
cd sandbox
```

## Conferir ambiente
Será entendido como "ambinete",

* Linux: `lsb_release -a` Exemplo: "No LSB modules are available. (...) Description: Ubuntu 14.04.3 LTS (...)".
* Git: `git --version` Exemplo: "git version 1.9.1".
* Python: `python3 -V` Exemplo: "Python 3.4.3".
* Base SQL: `SELECT version()` Exemplo: "PostgreSQL 9.3.10 on ... (Ubuntu ...) ..., 64-bit".
* PostGIS: `SELECT PostGIS_version();` Exemplo: "2.1 USE_GEOS=1 USE_PROJ=1 USE_STATS=1".

Outros elementos pré-configurados:
* Usuário default do PostgreSQL é `postgres`, e sua senha `pwd123`, a título de simplicidade nos scripts de instalação (evitando interrupções e meta-instruções sobre o assunto).
* ...

## Clonar tudo

```
#site
git clone https://github.com/okfn-brasil/cuidando2.git

#microservices
git clone https://github.com/okfn-brasil/esiclivre.git
git clone https://github.com/okfn-brasil/tagarela.git
git clone https://github.com/okfn-brasil/viralata.git

#apoio
git clone https://github.com/okfn-brasil/viratoken.git
```

## Conferir UBUNTU
...

## Criar bases dos microserviços

Abra um terminal postgres e crie uma base para cada microserviço (viralata, tagarela, esiclivre). Convenção de nomes: usar prefixo `cd2_` a cada user e base. Usuários (OWNER) da base serão todos `postgres` por garantia de simplicidade. Dessa forma o o comando básico é : `CREATE DATABASE cd2_<nome> OWNER postgres;`.

```
sudo -u postgres psql postgres
CREATE DATABASE cd2_viralata
WITH OWNER = postgres
        ENCODING = 'UTF-8'
        TABLESPACE = pg_default
        LC_COLLATE = 'pt_BR.UTF-8'
        LC_CTYPE = 'pt_BR.UTF-8'
    CONNECTION LIMIT = -1
   TEMPLATE template0;

CREATE DATABASE cd2_tagarela
WITH OWNER = postgres
        ENCODING = 'UTF-8'
        TABLESPACE = pg_default
        LC_COLLATE = 'pt_BR.UTF-8'
        LC_CTYPE = 'pt_BR.UTF-8'
    CONNECTION LIMIT = -1
   TEMPLATE template0;

CREATE DATABASE cd2_esiclivre
WITH OWNER = postgres
        ENCODING = 'UTF-8'
        TABLESPACE = pg_default
        LC_COLLATE = 'pt_BR.UTF-8'
        LC_CTYPE = 'pt_BR.UTF-8'
    CONNECTION LIMIT = -1
   TEMPLATE template0;
\q
```

## Criar virtualenv 
O comando `virtualenv env` não é default no UBUNTU. Deve-se avisar como foi habilitado.

Quanto ao comentário "não esqueça de escolher o virtualenv 2 ou 3 de acordo com o Python que quiser usar"
optou-se por impor Python3 como default.

> . env/bin/activate



Configure cada microserviço e o Cuidando2. Para isso entre pasta settings de cada um e crie um arquivo `local_settings.py` baseado no
`local_settings.example.py`

## Configurar cada microserviço e o cuidando2

cp esiclivre/settings/local_settings.example.py esiclivre/settings/local_settings.py
cp tagarela/settings/local_settings.example.py tagarela/settings/local_settings.py

sudo nano esiclivre/settings/local_settings.py
sudo nano tagarela/settings/local_settings.py


# Instale as dependências Python.

É importante instalar nessa ordem para usar as versões do ViraToken
e do Vira-Lata do repositório clonado, e não do PyPi.

```
cd viratoken
python setup.py develop

cd ../viralata
python setup.py develop
python manage.py initdb

cd ../tagarela
python setup.py develop
python manage.py initdb

cd ../esiclivre
python setup.py develop
python manage.py initdb

cd ../cuidando2
python setup.py develop
```

