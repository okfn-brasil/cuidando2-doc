Uma versão compacta das instruções a seguir, é oferecida também em [`municipio.sh`](./src/municipio.sh).

## Escolhas e convenções
O projeto pode rodar nas mais diversas plataformas com um mínimo de adaptações. De qualquer forma, a título de teste e por limitação de tempo da equipe, nas homologação apenas alguns ambientes foram adotados, e para reduzir ainda mais o custo de teste e deixar mais clara e limpa a documentação, algumas convenções simples foram adotadas.

Foi  adotada a postura [convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration), ou seja, não serão comentas todas as possibilidades de configuração, pressupomos certas convenções, e ficaria a cargo do usuário ou de uma documentação secundária qualquer desvio da convenção adotada.

Padrões de referência:

* Servidores web homologados:  [Ubuntu 14.04 LTS](https://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29), mais algum?
* Navegadores homologados: Firefox 42+, Chorme 46+.

Pode-se supor também que o *script de instalação* roda sob uma pasta vazia chamada *sandbox*,

```
mkdir sandbox
cd sandbox
```

## Conferir ambiente
Será entendido como "ambiente" do projeto,

* Linux: `lsb_release -a` Exemplo: "No LSB modules are available. (...) Description: Ubuntu 14.04.3 LTS (...)".
* Git: `git --version` Exemplo: "git version 1.9.1".
* Javascript engine V8: 4.6.85
* NodeJS: `nodejs --version` Exemplo: "v5.2.0" (cuidando se inferior, aten0.X)
* npm (do NodeJS): `npm -v` Exemplo: "3.3.12" (cuidado se 1.X)". O mesmo `npm` pode indicar todos com o comando `npm version`

### Atualizar o ambiente
O softeware 
As versões mínimas indicadas de  *NodeJS* ou `npm` precisam ser respeitadas. Na sua instalação default o UBUNTU 14 LTS, todavia, não oferece versões atualizadas, nem mesmo após o tradicional `apt-get install`. O procedimento mais simples e correto para instalar é o seguinte:

```
 curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
 sudo apt-get install -y nodejs
```
que já é suficiente para ambos,  *NodeJS* e `npm`. Confira as versões com `npm -v`  e `nodejs --version`. O V8 em geral já se encontra atualizado, mas vale conferir com `nodejs -p process.versions.v8`.

Nota: o `npm` vem com o `nodejs`, *evite* o `apt-get install npm` pois pode aparentar erro ou gerar versão muito antiga. Para garantir a atualização do `npm` use ele mesmo,

```
 sudo npm install npm -g 
```

## Clonar e instalar o projeto

```
git clone https://github.com/okfn-brasil/cuidando2.git
cd cuidando2
```

Em seguida verifique as configurações de `configs/config.js`. O caso típico é mudar apenas o domínio para o local de teste, 

```
nano configs/config.js
  ...
  const _domain = 'http://localhost:'
  ...
```

Caso não vá apenas simular o site, ou apenas reusar os microserviços de São Paulo, há que se configurar mais parâmetros. Feito isso, roda a instalação:

```
npm i
```
O ultimo comando vai um barra de progresso... Sinal que está indo tudo bem.

## Rodar

Para rodar o site:

```
npm run dev
```

Depois acesse `localhost:5001` em um navegador. Se quiser que o código atualize automaticamente conforme editar os arquivos, acesse `localhost:5001/webpack-dev-server/`.


