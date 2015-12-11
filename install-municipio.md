Uma versão compacta das instruções a seguir, é oferecida também em [`municipio.sh`](./src/municipio.sh).

## Convenções

Estamos adotando [Convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration), ou seja, não ficamos comentando opções do usuário, pressupomos um padrão, e ficaria a cargo do usuário ou de uma documentação secundária qualquer desvio do padrão.

Padrões:

* Ambiente [Ubuntu 14.04 LTS](https://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29)
* Navegadores homologados: Firefox 42+, Chorme 46+.

Outra convenção é que o script de instalação roda sob uma pasta vazia chamada *sandbox*,

```
mkdir sandbox
cd sandbox
```

## Conferir ambiente
Será entendido como "ambinete",

* Linux: `lsb_release -a` Exemplo: "No LSB modules are available. (...) Description: Ubuntu 14.04.3 LTS (...)".
* Git: `git --version` Exemplo: "git version 1.9.1".
* NodeJS: `npm -v` Exemplo: "1.3.10".


## Clonar e instalar o projeto

```
git clone https://github.com/okfn-brasil/cuidando2.git

#@IF sem Node-JS, instalar
sudo apt-get install npm

npm i
```

O ultimo comando vai listar milhares de linhas na forma `npm http GET https://registry.npmjs.org/...` e mensagens vinculadas, sendo algumas na forma `npm ERR! ...` que podem ser ignorsdas. Quando terminar, todavia, não podem haver mensagens de erro. 

"Depois configure um `src/config.js`"?? de onde copiar?

## Rodar

Para rodar o site:

```
npm run dev
```

Depois acesse `localhost:5001` em um navegador. Se quiser que o código atualize automaticamente conforme editar os arquivos, acesse `localhost:5001/webpack-dev-server/`.


