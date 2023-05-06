#### Prática 01 - Semana 09

Nesse exercício iremos abordar o conteúdo apresentado nas nossas 3 semanas de aula sobre banco de dados.

## Problema abordado:

A empresa Raro Geek comercializadora de produtos de informática solicitou a elaboração de um sistema para controlar suas vendas.
Para os produtos comercializados devem ser armazenados código único, nome, preço unitário e descrição.
Um produto pode ser fornecido por vários fornecedores e cada fornecedor é responsável por fornecer vários produtos. Para os fornecedores devem ser armazenados código único, nome, CNPJ e endereço.
A Raro Geek possui várias lojas e para cada uma delas deve-se armazenar o código único, nome, CNPJ e endereço.
Cada loja pode vender todos ou alguns dos produtos cadastrados.
Cada loja deve realizar o controle de estoque, ou seja, controlar a quantidade disponível para os produtos que ela vende.
Cada venda realizada para um cliente pode conter vários produtos e um produto pode fazer parte de várias vendas.
A venda para um cliente é realizada em uma das lojas.
Para cada venda devem ser armazenados código único, número da nota fiscal, data/hora, valor total e uma flag sinalizando que foi concluída.
Para cada cliente devem ser armazenados código único, nome, CPF e endereço.
Um produto poderá ser vendido apenas se a loja possuí-lo e se a quantidade desejada é suficiente.
Após a conclusão de uma venda, os estoques dos produtos para a loja precisam ser atualizados.

O que será considerado na avaliação desse exercício:

1. Diagrama Entidade Relacionamento;
2. Diagrama Lógico Relacional;
3. Inicialização correta do projeto Rails;
4. Criação correta das migrations e suas respectivas estruturas: nomenclatura, timestamps, etc;
5. Utilização dos modificadores para as colunas definidas nas migrations;
6. Utilização correta das referências para outras tabelas;
7. Adição/atualização das associações nos models, acrescentando as opções que julgarem necessário;
8. Validações inseridas nos models (desde que haja relevância para determinado model);
9. Callbacks inseridos nos models (desde que haja relevância para determinado model);
10. Scopes inseridos nos models (desde que haja relevância para determinado model);
11. Fluxo de trabalho com criação de issues/branches no gitlab;
12. Criação de um seed para popular a base de dados com dados iniciais;
13. Documentação das tomadas de decisão;

Para facilitar o desenvolvimento do exercício prático, sugiro que sigam os seguintes passos:

1. Elabore o Diagrama ER, aplicando as regras que vimos;
2. Transforme o Diagrama ER para o Modelo Lógico Relacional, aplicando as regras que vimos;
3. Identifique chaves primárias, estrangeiras e outras colunas que possam existir;
4. Identifique os tipos de dados, constraints para cada coluna e os relacionamentos entre as tabelas;

Observações:

1. Vocês poderão escolher o banco de dados que desejarem.
2. Vocês poderão escolher o nome que desejarem para a aplicação.
3. Vocês possuem a liberdade para tomarem as decisões no projeto que julgarem importantes;
4. Não nos preocuparemos com a criação de views e controllers.
5. A escrita do código não é obrigatório que seja feita em Inglês, porém é uma boa prática, portanto, priorizem a escrita em Inglês.

Como deverá ser entregue:

Até a data de entrega do exercício, vocês deverão criar um repositório em sua conta privada do gitlab da raro academy, realizar todo o desenvolvimento da nossa prática e publicar todo seu conteúdo na branch _main_.
Para entrega no **classroom**, vocês devem anexar o link para o repositório.

Não se esqueça de dar a permissão de "developer" aos professores e monitores desta turma, caso contrário, eles não terão acesso à sua entrega.

Seu repositório deve conter todos os arquivos necessários para o devido funcionamento do seu projeto.

Ainda no seu repositório, altere o arquivo README.md acrescentando uma seção onde será descrita a resolução e as premissas adotadas por você. Estas respostas serão levadas em consideração na avaliação da sua entrega, além de ajudar muito os professores.

Os professores deverão avaliar sua entrega até o último commit feito até a data limite. Caso sua entrega possua commits após a data limite, nós avaliaremos a entrega considerando as penalidades de atraso.
Para avaliar sua entrega, utilizaremos o ambiente de desenvolvimento do rails.

Garanta que tudo esteja funcionando. Qualquer pré-condição para o funcionamento deve ser registrada no README do projeto.
