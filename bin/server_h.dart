import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServerH {
  Handler get handler {
    final router = Router();

    //=========METODO GET=========\\
    //! headers: {'Content-Type': 'text/html'} -> para usarmos tags html
    router.get('/', (Request request) {
      return Response.ok(
        '<h1> Primeira rota </h1>',
        headers: {'Content-Type': 'text/html'},
      );
    });

    router.get('/ola/mundo/<usuario>', (Request req, String usuario) {
      //ok -> 200 + body
      return Response.ok(
        'Ola mundo $usuario',
        headers: {'Content-Type': 'text/html'},
      );
    });

    //Query paramns (nao utilize ao passar dados sensiveis !!)
    //query? -> depois do '?' o navegador sabe que é query paramns
    //query?nome=vitor
    router.get('/query', (Request req) {
      //pegando o query paramns com a variavel nome
      String nome = req.url.queryParameters['nome'] ?? 'Não encontrado';
      String idade = req.url.queryParameters['idade'] ?? 'Não encontrado';
      return Response.ok(
        'Query é: $nome e idade $idade',
        //é preciso por esse headers se nao ele baixa um arquivo 'query'
        headers: {'Content-Type': 'text/plain'},
      );
    });
    //=========METODO GET=========\\

    //=========METODO POST=========\\
    //!obs: no postman quando for fazer um postman selecione 'body > raw > json'
    //e digita {  "chave": "valor" } no corpo to texto

    router.post('/login', (Request req) async {
      //*Pegando a informação json
      var result = await req.readAsString();

      //*Pegando somente o valor do json
      Map json = jsonDecode(result);

      //se usuario == admin e senha == 123 vai autenticar
      //se nao devolvemos um erro
      var usuario = json['usuario'];
      var senha = json['senha'];

      if (usuario == 'admin' && senha == '123') {
        //Para retornar um json (mapUser > JsonResponse > header)
        Map mapUser = {'token': 'token123', 'user_id': 1};
        String jsonResponse = jsonEncode(mapUser);
        return Response.ok(
          jsonResponse,
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        //forbidden -> acesso negado
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}

//jsonDecode -> pega um json e transforma em mapa
//JsonEncode -> pega um mapa e transforma em um json 