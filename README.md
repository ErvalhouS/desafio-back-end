# BLU - Desafio Backend

Essa aplicação consiste em um sistema de gerenciamento de transações a partir do upload de arquivos CNAB.

# Requerimentos

 - [Ruby 2.5.3](http://rvm.io/)
 - [Uma JRE, indico o Node.js](https://nodejs.org)
 - [SQLite](https://www.sqlite.org/index.html)
 - [Redis](https://redis.io/)
 - [Bundler](https://bundler.io/)

# Instalação

Instale os requerimentos do projeto, acesse o link de cada um deles para saber como. Clone este repositório para instalar a aplicação.

Primeiramente navegue até a pasta com o repositório clonado e execute o comando para instalar as dependências do projeto:

```
$ bundle install
```

Para executar pela primeira vez, além de ter as dependências instalados você precisa fazer a configuração do banco de dados.

```
$ bundle exec rails db:create && bundle exec rails db:migrate
```

Após isso utilize o seguinte comando para rodar a aplicação:

```
$ bundle exec foreman start
```

PRONTO :tada:
Agora acesse `http://localhost:3000`

# Testes

Essa aplicação foi construída com testes, para rodá-los basta executar o comando:

```
$ bundle exec rspec
```

# Como funciona?

Primeiro você deve se cadastrar. Isso serve para a segurança de suas informações, tornando disponível apenas para você os registros relacionados as suas operações. Após o cadastro entre no sistema.

Ao preencher [o formulário de upload de arquivos CNAB](http://localhost:3000/cnabs/new), o seu upload para uma fila de processamento assíncrono. Você pode ver o status do processamento de seus arquivos CNAB na [listagem](http://localhost:3000/cnabs).

Após o processamento do arquivo serão criadas as transações contidas nele, que você pode visualizar loja a loja na área de [gerência de lojas](http://localhost:3000/stores). Lá você pode visualizar o saldo atual de cada loja e ver mais informações sobre cada transação ao acessar o link inidividual de uma loja.
