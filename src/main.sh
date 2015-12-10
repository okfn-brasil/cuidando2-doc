##
## main.sh
## Script principal de comandos de instalação do Projeto Cuidando2, descrito em ../README.md 
## Comentários usuais em "#", seções em "##", e diretivas "@see", "@notice" e "@IF".
##

## ATENÇÃO
# Leia o ../README.MD antes de usar este script.
# Este script.sh não é só um resumo, com vários trechos condicionais e interativos.
# Por hora !!!!NÃO RODA DIRETO!!!!, precisa copiar/colar trechos.


## Preparo do UBUNTU
sudo updatedb # locate
sudo apt-get update

#@see uso do UTF8 e lingua desejada. Supor português do Brasil, pt-BR.  
locale -a|grep pt_BR
#@IF nada aparecer, usar
sudo locale-gen pt_BR
sudo locale-gen pt_BR.UTF-8
sudo update-locale

#@notice python 3.4 já vem instalado pelo Ubuntu 14 LTS. É só lembrar que o comando é python3 e não python.


## Instalar PostgreSQL e drivers
#@IF se nunca usou, fazer antes
sudo apt-get install postgresql postgresql-contrib


sudo apt-get install python-psycopg2
sudo apt-get install libpq-dev


#@see exists postgres
cut -d: -f1 /etc/passwd  | grep post
#@IF se não existe criar usuário default "postgres"
sudo -u postgres psql postgres
\password postgres 
pwd123
\q

## Criar bases PostgreSQL
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

## Iniciar a parte específica
mkdir sandbox
cd sandbox

## Clonar tudo
#site
git clone https://github.com/okfn-brasil/cuidando2.git

#microservices
git clone https://github.com/okfn-brasil/esiclivre.git
git clone https://github.com/okfn-brasil/tagarela.git
git clone https://github.com/okfn-brasil/viralata.git

#apoio
git clone https://github.com/okfn-brasil/viratoken.git

## Criar virtualenv 

#@IF se nunca usou, fazer antes
sudo apt-get install python-virtualenv

virtualenv env
. env/bin/activate
#@notice a partir de agora o terminal parece com "(env)", por exemplo "(env)peter@pk:~/sandbox$". 
 
pip install psycopg2
#@if se "Error: You need to install postgresql-server-dev-X.Y" ver acima seção "Instalar PostgreSQL e drivers".

## Configurar cada micro serviço e o cuidando2

cp esiclivre/settings/local_settings.example.py esiclivre/settings/local_settings.py
cp tagarela/settings/local_settings.example.py tagarela/settings/local_settings.py

sudo nano esiclivre/settings/local_settings.py
sudo nano tagarela/settings/local_settings.py


# Instale as dependências Python.
# É importante instalar nessa ordem para usar as versões do ViraToken
# e do Vira-Lata do repositório clonado, e não do PyPi.
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


