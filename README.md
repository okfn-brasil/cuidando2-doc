# Cuidando do Meu Bairro

Projeto *Cuidando do Meu Bairro*: abertura e geolocalização do orçamento municipal. 

**Acesso**:

* Portal e implantação para o município de São Paulo em [*Cuidando.vc*](http://cuidando.vc).
* Fontes de dados orçamentários nos [webservices do projeto *GastosAbertos.org*](http://demo.gastosabertos.org).

**Códigos-fonte** (repositórios [git](https://pt.wikipedia.org/wiki/Git)):

* Site: [okfn-brasil/cuidando2](https://github.com/okfn-brasil/cuidando2) 
* Módulos de dados orçamentários:
  * Fontes dos engines e extratores: [okfn-brasil/gastos\_abertos](https://github.com/okfn-brasil/gastos_abertos), [teaser.gastosabertos.org](https://github.com/okfn-brasil/teaser.gastosabertos.org).
  * Dados e documentação: [okfn-brasil/gastos\_abertos\_dados](https://github.com/okfn-brasil/gastos_abertos_dados), [okfn-brasil/documents/gastos\_abertos](https://github.com/okfn-brasil/documents/blob/master/gastos_abertos).
* Autenticação de usuários: [okfn-brasil/viralata](https://github.com/okfn-brasil/viralata) 
* Comunicação dos usuários: [okfn-brasil/tagarela](https://github.com/okfn-brasil/tagarela) 
* Intermediação do eSIC:  [okfn-brasil/esiclivre](https://github.com/okfn-brasil/esiclivre) 

**Documentação**:

* Tutoriais na [*Wikiversity-Português*, Projeto Cuidando do Meu Bairro](https://pt.wikiversity.org/wiki/Projeto_Cuidando_do_Meu_Bairro).
* Instruções para o desenvolvedor: [okfn-brasil/cuidando2-doc](https://github.com/okfn-brasil/cuidando2-doc).
* Administração do projeto: [wiki.okfn.org](http://wiki.okfn.org/Open_Knowledge_Brasil/Gastos_Abertos).

## Histórico e versões
Este projeto teve origem no [Cuidando do Meu Bairro de 2013](http://cuidando.org.br), que buscava mapear a execução do orçamento municipal de São Paulo, não só em regiões, mas também colocando um ponto no mapa para cada despesa. Por isso o presente projeto foi apelidado de **Cuidando2**: uma nova interface, novos recursos e melhoras nos dados gerados pelo software.

Como os [dados obtidos da prefeitura](http://orcamento.prefeitura.sp.gov.br/orcamento/execucao.html) não têm as coordenadas geográficas de cada despesa (no máximo algumas tem a região a que se destinam), o ponto de partida são os endereços nos textos das descrições das despesas, que por sua vez podem ser submetidos à [geocodificação](https://en.wikipedia.org/wiki/Geocoding) em ferramentas adequadas.

A extração dos endereços a partir do texto é obtida através de  [*expressões regulares*](https://pt.wikipedia.org/wiki/Express%C3%A3o_regular).
A geocodificação desses endereços é realizada pelas [API](https://en.wikipedia.org/wiki/Application_programming_interface)s [OpenStreetMap-Nomination](http://wiki.openstreetmap.org/wiki/Nominatim) e [Google-geocoding](https://developers.google.com/maps/documentation/geocoding/intro). Esse processo não é perfeito, acumula erros tanto da fase de extração como da fase de geocodificação, de modo que muitas despesas não são mapeadas, ou acabam exibidas no local errado. No Cuidando2 o processo foi aperfeiçoado para reduzir a taxa de erros.

## Arquitetura

Abaixo estão representados os diversos módulos nos quais esse projeto se baseia:

![Alt text](https://raw.githubusercontent.com/okfn-brasil/cuidando2-doc/master/img/cuidando2_arq2-827px.png)

As setas avermelhadas indicam conexões em que as escritas provavelmente necessitarão de um [token](https://github.com/okfn-brasil/viralata#protocol).

A navegação HTML é de responsabilidade do [*Cuidando2*](https://github.com/okfn-brasil/cuidando2), implementado atualmente em [cuidando.vc](https://cuidando.vc), que através de [Ajax](https://en.wikipedia.org/wiki/Ajax_(programming)) faz a comunicação com cada módulo, nos respectivos [endpoints](http://www.w3.org/TR/wsdl20/#Endpoint):

| Função | Responsabilidade | **Endpoint** em uso | Notas |
|--------|------------------|--------------|-------|
|Geolocalização|*Gastos Abertos*|[site-cuidando.rhcloud.com/dados/api/v1](https://site-cuidando.rhcloud.com/dados/api/v1)|leitura das coordenadas|
|Dados de execução orçamentária|*Gastos Abertos*|[demo.gastosabertos.org](http://demo.gastosabertos.org)|consulta à base de dados|
|Autenticação dos usuários|[*Vira-Lata*](https://github.com/okfn-brasil/viralata)|[viralata-cuidando.rhcloud.com](https://viralata-cuidando.rhcloud.com)|token de acesso, leitura/escrita|
|Comentários dos usuários|[*Tagarela*](https://github.com/okfn-brasil/tagarela) |[tagarela-cuidando.rhcloud.com](https://tagarela-cuidando.rhcloud.com)|leitura/escrita dos textos|
|Interface com eSIC|[*EsicLivre*](https://github.com/okfn-brasil/esiclivre)|[cuidando.vc/esiclivre](https://cuidando.vc/esiclivre) |realização de pedidos de informação, leitura/escrita|

Cada um desses *endpoints* apresenta também uma documentação mais detalhada da API quando acessado diretamente do navegador, exemplificando o uso de cada uma das operações [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) disponíveis no microserviço.

## Modos de operação e replicação

Conforme a finalidade, o projeto pode ser copiado e adaptado, parcial ou integralmente. O caso típico é a replicação para atuar com outros municípios, mudando apenas o escopo de dados no Gastos Abertos e adaptando-se o *EsicLivre* para as peculiaridades do eSIC do município. 

Uma outra forma comum de replicação é a integral, quando se deseja instalar e testar localmente (o programador no seu computador) para entender melhor o funcionamento do software como um todo, ou para realizar (através de *fork*) adaptações maiores.

### Replicando apenas o site
Na ausência de dados da cidade, operaria em modo "somente leitura". Util para designers e trabalhos restritos ao site.

Texto completo de instruções em [install-site.md](install-site.md).


### Replicando serviços e preparo dos dados
Para reproduzir os microserviços, deve-se reproduzir também as bases de dados. 

As instruções para replicação do *software* estão em [install-services.md](install-services.md). A preparação dos dados pode ser realizada de três modos:

* *sandbox*: base de dados mínima com dados de teste.
* *referência*: dados da base em operação, em um site Cuidando já implantado.
* *novo*: construir uma base de dados nova (por exemplo para um novo município). A metodologia e dicas encontram-se descritas [nesta Wiki](https://pt.wikiversity.org/wiki/Projeto_Cuidando_do_Meu_Bairro/Novos_dados).

### Replicação completa 
Para replicar ambos, o site e os serviços, um script mais consido também é oferecido:  [install-full.sh](install-full.sh).

## CRÉDITOS E LICENÇAS

A presente documentação e todos os scripts [deste módulo de documentação](https://github.com/okfn-brasil/cuidando2-doc) estão licenceados sob **[CC-BY 4.0](http://creativecommons.org/licenses/by/4.0/)**.
 
O Cuidando2 é um projeto realizado por várias mãos,

* Alexandre Evangelista de Souza Júnior ([@alexandre](https://github.com/alexandre))
* Andrés M. R. Martano ([@andresmrm](https://github.com/andresmrm))
* Gisele S. Craveiro (coordenação), 
* Jutta Machado Schimdt
* Solaine Lima
* e todos os parceiros e beta-testers, que  auxiliaram com sugestoes criativas e construtivas

com apoio de,

* [COLAB-USP](http://colab.each.usp.br/) 
* [OKBR](http://br.okfn.org/)
* ? (financeamento)

e disperso por alguns módulos, listados a seguir  com indicação das respectivas licenças e equipes:

* [Site Cuidando do Município](https://github.com/okfn-brasil/cuidando2.git): *licença [AGPLv3](https://github.com/okfn-brasil/cuidando2/blob/master/LICENSE.txt)*. 

 * *equipe*: Gisele (coordenação),  Andrés (software), Solaine (design).

 * [*Software*](https://github.com/okfn-brasil/cuidando2/graphs/contributors): @andresmrm e  @LuizArmesto

* [Gastos Abertos](https://github.com/okfn-brasil/gastos_abertos): *licença [AGPLv3](https://github.com/okfn-brasil/gastos_abertos/blob/master/LICENSE)* em nome de [OKBR](http://br.okfn.org/)/[Projeto Gastos Abertos](http://wiki.okfn.org/Open_Knowledge_Brasil/Gastos_Abertos).

 * [*Dados*](https://github.com/okfn-brasil/gastos_abertos/commits/master/data):  @aivuk, @andresmrm.

 * [*Software*](https://github.com/okfn-brasil/gastos_abertos/graphs/contributors): @andresmrm , @aivuk, @LuizArmesto, @waffle-iron, @carlosandrade, @lpirola.

* Demais [microserviços](https://en.wikipedia.org/wiki/Microservices) e módulos de apoio:

  *  [eSIC Livre](https://github.com/okfn-brasil/esiclivre): *licença [AGPLv3](https://github.com/okfn-brasil/esiclivre/blob/master/LICENSE.txt)*. 
    *  *equipe*: @alexandre e @andresmrm

  *  [Tagarela](https://github.com/okfn-brasil/tagarela): *licença [AGPLv3](https://github.com/okfn-brasil/tagarela/blob/master/LICENSE.txt)*, software @andresmrm.
     
  *  [Viralata](https://github.com/okfn-brasil/viralata): *licença [AGPLv3](https://github.com/okfn-brasil/viralata/blob/master/LICENSE.txt)*, software @andresmrm.

  *  [Viratoken](https://github.com/okfn-brasil/viratoken): *licença [AGPLv3](https://github.com/okfn-brasil/viratoken/blob/master/LICENSE.txt)*, software @andresmrm.


