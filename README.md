# Teste Konatus

## Introdução

Para o desenvolvimento do sistema Back-end deste teste foi utilizado o software de código aberto, multiplataforma [Node](https://nodejs.org/en/), o (Object-Relational Mapping, ORM) [Sequelize](https://sequelize.org/) para mapeamento objeto-relacional do banco de dados e manutenção do banco de dados baseado em migrations desenvolvido em [SQLite](https://www.sqlite.org/).
Ademas, o desenvolvimento do sistema Front-end utilizou o framework [Flutter](https://flutter.dev/) e a linguaguem de programação [Dart](https://dart.dev/).

## Funcionalidade

O sistema tem como tela inicial um formulário de login, onde são inseridos o email e senha de algum dos usuários cadastrados no banco de dados.
Após o login, o usuário é levado à uma tela de visualização das manutenções de suas manutenções.
Nesta tela, o usuário poderá inserir uma nova manutenção e visualizar as suas manutenções
finalizadas ou pendentes.

## Antes de iniciar

- Entrar na pasta back e inserir no terminal o comando `npm install` para instalar os pacotes do Node.js;
- Inserir o comando `nodemon index.js` ou `node index.js` para iniciar o servidor Node.
- Para rodar o front é necessário ter o SDK do Flutter instalado e executar na linha de comando: `flutter packages get` e em seguida `flutter run` dentro da pasta front/.

## Observações

- Informações de usuário
  - Login: email@email.com
  - Senha: 12345678

Muito obrigado,
