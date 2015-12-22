Uma versão compacta das instruções a seguir, é oferecida também em [`services.sh`](./src/services.sh).

## Escolhas e convenções
O projeto pode rodar nas mais diversas plataformas com um mínimo de adaptações. A título de homologação, todavia, apenas um ambiente foi apreciado.

Para a obtenção de uma documentação mais clara e limpa foi adotada [convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration), ou seja, não serão comentadas todas as possibilidades de configuração, pressupomos certas convenções, e ficaria a cargo do usuário ou de uma documentação secundária qualquer desvio da convenção adotada.  Padrões de referência:

* Servidores web homologados:  [Ubuntu 14 LTS](https://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29), mais algum?
* Navegadores homologados: Firefox 42+, Chorme 46+.


## Conferir ambiente
Será entendido como "ambiente" do servidor do projeto,

* Linux **Ubuntu 14.04+ LTS**: pode ser mais atualizado, mas são pressupostas restrições do LTS nos exemplos de atualização. Conferir com `lsb_release -a` (resultará ex. 14.04.3).
* **Git 1.9+**: `git --version` (ex. 1.9.1).
* **Python v3.4+**: `python3 --version` (ex. Python 3.4.3)

### Atualizar o ambiente

As versões mínimas indicadas precisam ser respeitadas. Na sua instalação default o UBUNTU 14 LTS, todavia, não oferece versões atualizadas. O procedimento mais simples e correto para instalar ou atualizar é o seguinte:

```
...
```

## Clonar e instalar o projeto


