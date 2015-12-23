Cuidando do Meu Bairro
======================

Versão |version| - dezembro de 2015.

Projeto *Cuidando do Meu Bairro*: abertura e geolocalização do orçamento municipal. 

**Acesso**:

-  Portal e implantação para o município de São Paulo em  `Cuidando.vc <http://cuidando.vc>`__.
-  Fontes de dados orçamentários nos `webservices do projeto GastosAbertos.org <http://demo.gastosabertos.org>`__.

**Códigos-fonte** (repositórios `git <https://pt.wikipedia.org/wiki/Git>`__):

-  Site:
   `okfn-brasil/cuidando2 <https://github.com/okfn-brasil/cuidando2>`__
-  Módulos de dados orçamentários:
-  Fontes dos engines e extratores:
   `okfn-brasil/gastos\_abertos <https://github.com/okfn-brasil/gastos_abertos>`__,
   `teaser.gastosabertos.org <https://github.com/okfn-brasil/teaser.gastosabertos.org>`__.
-  Dados e documentação:
   `okfn-brasil/gastos\_abertos\_dados <https://github.com/okfn-brasil/gastos_abertos_dados>`__,
   `okfn-brasil/documents/gastos\_abertos <https://github.com/okfn-brasil/documents/blob/master/gastos_abertos>`__.
-  Autenticação de usuários:
   `okfn-brasil/viralata <https://github.com/okfn-brasil/viralata>`__
-  Comunicação dos usuários:
   `okfn-brasil/tagarela <https://github.com/okfn-brasil/tagarela>`__
-  Intermediação do eSIC:
   `okfn-brasil/esiclivre <https://github.com/okfn-brasil/esiclivre>`__

**Documentação**:

-  Tutoriais na `Wikiversity-Português, Projeto Cuidando do Meu
   Bairro <https://pt.wikiversity.org/wiki/Projeto_Cuidando_do_Meu_Bairro>`__.
-  Instruções para o desenvolvedor:
   `okfn-brasil/cuidando2-doc <https://github.com/okfn-brasil/cuidando2-doc>`__.
-  Administração do projeto:
   `wiki.okfn.org <http://wiki.okfn.org/Open_Knowledge_Brasil/Gastos_Abertos>`__.

Histórico e versões
-------------------

Este projeto teve origem no `Cuidando do Meu Bairro de
2013 <http://cuidando.org.br>`__, que buscava mapear a execução do
orçamento municipal de São Paulo, não só em regiões, mas também
colocando um ponto no mapa para cada despesa. Por isso o presente
projeto foi apelidado de **Cuidando2**: uma nova interface, novos
recursos e melhoras nos dados gerados pelo software.

Como os `dados obtidos da
prefeitura <http://orcamento.prefeitura.sp.gov.br/orcamento/execucao.html>`__
não têm as coordenadas geográficas de cada despesa (no máximo algumas
tem a região a que se destinam), o ponto de partida são os endereços nos
textos das descrições das despesas, que por sua vez podem ser submetidos
à `geocodificação <https://en.wikipedia.org/wiki/Geocoding>`__ em
ferramentas adequadas.


A extração dos endereços a partir do texto é obtida através de `expressões regulares <https://pt.wikipedia.org/wiki/Express%C3%A3o_regular>`__. A geocodificação desses endereços é realizada pelas `API <https://en.wikipedia.org/wiki/Application_programming_interface>`__\ s
`OpenStreetMap-Nomination <http://wiki.openstreetmap.org/wiki/Nominatim>`__
e `Google-geocoding <https://developers.google.com/maps/documentation/geocoding/intro>`__.
Esse processo não é perfeito, acumula erros tanto da fase de extração
como da fase de geocodificação, de modo que muitas despesas não são
mapeadas, ou acabam exibidas no local errado. No Cuidando2 o processo
foi aperfeiçoado para reduzir a taxa de erros.

Arquitetura
-----------

Buscando ampliar a chance de reuso do código desenvolvido e permitir um nível
maior de interação com outros aplicativos, o projeto seguiu uma arquitetura de
micro serviços. Ou seja, ao invés de ter um único código monolítico que
implementasse todas as funcionalidades desejadas, elas foram distribuídas em
pequenos módulos, cada um com uma funcionalidade específica:

|Alt text|

As setas avermelhadas indicam conexões em que as escritas provavelmente
necessitarão de um
`token <https://github.com/okfn-brasil/viralata#protocol>`__.

A navegação HTML é de responsabilidade do `Cuidando2 <https://github.com/okfn-brasil/cuidando2>`__, implementado
atualmente em `cuidando.vc <https://cuidando.vc>`__, que através de
`Ajax <https://en.wikipedia.org/wiki/Ajax_(programming)>`__ faz a
comunicação com cada módulo, nos respectivos
`endpoints <http://www.w3.org/TR/wsdl20/#Endpoint>`__:

+----------------------------------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------------+--------------------------------------------------------+
| Função                           | Responsabilidade                                             | **Endpoint** em uso                                                                           | Notas                                                  |
+==================================+==============================================================+===============================================================================================+========================================================+
| Geolocalização                   | *Gastos Abertos*                                             | `site-cuidando.rhcloud.com/dados/api/v1 <https://site-cuidando.rhcloud.com/dados/api/v1>`__   | leitura das coordenadas                                |
+----------------------------------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------------+--------------------------------------------------------+
| Dados de execução orçamentária   | *Gastos Abertos*                                             | `demo.gastosabertos.org <http://demo.gastosabertos.org>`__                                    | consulta à base de dados                               |
+----------------------------------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------------+--------------------------------------------------------+
| Autenticação dos usuários        |  `Vira-Lata  <https://github.com/okfn-brasil/viralata>`__    | `viralata-cuidando.rhcloud.com <https://viralata-cuidando.rhcloud.com>`__                     | token de acesso, leitura/escrita                       |
+----------------------------------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------------+--------------------------------------------------------+
| Comentários dos usuários         |  `Tagarela  <https://github.com/okfn-brasil/tagarela>`__     | `tagarela-cuidando.rhcloud.com <https://tagarela-cuidando.rhcloud.com>`__                     | leitura/escrita dos textos                             |
+----------------------------------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------------+--------------------------------------------------------+
| Interface com eSIC               |   `EsicLivre <https://github.com/okfn-brasil/esiclivre>`__   | `cuidando.vc/esiclivre <https://cuidando.vc/esiclivre>`__                                     | realização de pedidos de informação, leitura/escrita   |
+----------------------------------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------------+--------------------------------------------------------+

Cada um desses *endpoints* apresenta também uma documentação mais
detalhada da API quando acessado diretamente do navegador,
exemplificando o uso de cada uma das operações
`REST <https://en.wikipedia.org/wiki/Representational_state_transfer>`__
disponíveis no microserviço.

Modos de operação e replicação
------------------------------

Conforme a finalidade, o projeto pode ser copiado e adaptado, parcial ou
integralmente. O caso típico é a replicação para atuar com outros
municípios, mudando apenas o escopo de dados no Gastos Abertos e
adaptando-se o *EsicLivre* para as peculiaridades do eSIC do município.

Uma outra forma comum de replicação é a integral, quando se deseja
instalar e testar localmente (o programador no seu computador) para
entender melhor o funcionamento do software como um todo, ou para
realizar (através de *fork*) adaptações maiores.

Replicando apenas o site
~~~~~~~~~~~~~~~~~~~~~~~~

Na ausência de dados da cidade, operaria em modo "somente leitura". Util
para designers e trabalhos restritos ao site.

.. toctree::
   :maxdepth: 1

   install-site

(disponível também em `install-site.md <https://github.com/okfn-brasil/cuidando2-doc/blob/master/install-services.md>`__).

Replicando serviços e preparo dos dados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para reproduzir os microserviços, deve-se reproduzir também as bases de
dados.

As instruções para replicação do *software* estão em
`install-services.md <https://github.com/okfn-brasil/cuidando2-doc/blob/master/install-services.md>`__. A preparação dos dados
pode ser realizada de três modos:

-  *sandbox*: base de dados mínima com dados de teste.
-  *referência*: dados da base em operação, em um site Cuidando já
   implantado.
-  *novo*: construir uma base de dados nova (por exemplo para um novo
   município). A metodologia e dicas encontram-se descritas `nesta
   Wiki <https://pt.wikiversity.org/wiki/Projeto_Cuidando_do_Meu_Bairro/Novos_dados>`__.

Replicação completa
~~~~~~~~~~~~~~~~~~~

Para replicar ambos, o site e os serviços, um script mais consido também
é oferecido: `src/full.sh <https://github.com/okfn-brasil/cuidando2-doc/blob/master/src/full.sh>`__.

CRÉDITOS E LICENÇAS
-------------------

A presente documentação e todos os scripts `deste módulo de
documentação <https://github.com/okfn-brasil/cuidando2-doc>`__ estão
licenceados sob `CC-BY 4.0 <http://creativecommons.org/licenses/by/4.0/>`__.

O Cuidando2 é um projeto realizado por várias mãos,

-  Alexandre Evangelista de Souza Júnior
   (`@alexandre <https://github.com/alexandre>`__)
-  Andrés M. R. Martano (`@andresmrm <https://github.com/andresmrm>`__)
-  Gisele S. Craveiro (coordenação),
-  Jutta Machado Schimdt
-  Solaine Lima
-  ... e todos os parceiros e beta-testers, que  auxiliaram com sugestoes criativas e construtivas

com apoio de,

-  `COLAB-USP <http://colab.each.usp.br/>`__
-  `OKBR <http://br.okfn.org/>`__
-  ? (financeamento)

e disperso por alguns módulos, listados a seguir com indicação das
respectivas licenças e equipes:

-  `Site Cuidando do
   Município <https://github.com/okfn-brasil/cuidando2.git>`__: licença `AGPLv3 <https://github.com/okfn-brasil/cuidando2/blob/master/LICENSE.txt>`__.

-  *equipe*: Gisele (coordenação), Andrés (software), Solaine (design).

-  `Software <https://github.com/okfn-brasil/cuidando2/graphs/contributors>`__:
   @andresmrm e @LuizArmesto

-  `Gastos Abertos <https://github.com/okfn-brasil/gastos_abertos>`__:
   licença `AGPLv3 <https://github.com/okfn-brasil/gastos_abertos/blob/master/LICENSE>`__
   em nome de `OKBR <http://br.okfn.org/>`__/`Projeto Gastos
   Abertos <http://wiki.okfn.org/Open_Knowledge_Brasil/Gastos_Abertos>`__.

-  `*Dados* <https://github.com/okfn-brasil/gastos_abertos/commits/master/data>`__:
   @aivuk, @andresmrm.

-  `*Software* <https://github.com/okfn-brasil/gastos_abertos/graphs/contributors>`__:
   @andresmrm , @aivuk, @LuizArmesto, @waffle-iron, @carlosandrade,
   @lpirola.

-  Demais
   `microserviços <https://en.wikipedia.org/wiki/Microservices>`__ e
   módulos de apoio:

-  `eSIC Livre <https://github.com/okfn-brasil/esiclivre>`__: licença `AGPLv3 <https://github.com/okfn-brasil/esiclivre/blob/master/LICENSE.txt>`__.

   -  *equipe*: @alexandre e @andresmrm

-  `Tagarela <https://github.com/okfn-brasil/tagarela>`__: licença `AGPLv3 <https://github.com/okfn-brasil/tagarela/blob/master/LICENSE.txt>`__,
   software @andresmrm.

-  `Viralata <https://github.com/okfn-brasil/viralata>`__: licença `AGPLv3 <https://github.com/okfn-brasil/viralata/blob/master/LICENSE.txt>`__,
   software @andresmrm.

-  `Viratoken <https://github.com/okfn-brasil/viratoken>`__: licença `AGPLv3 <https://github.com/okfn-brasil/viratoken/blob/master/LICENSE.txt>`__,
   software @andresmrm.

.. |Alt text| image:: cuidando2_arq2-827px.png


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

