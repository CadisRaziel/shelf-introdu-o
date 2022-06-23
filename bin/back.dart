import 'dart:io';

import 'package:shelf/shelf_io.dart' as shelf_io;

import 'server_h.dart';

void main() async {
  var _server = ServerH();

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final servidor = await shelf_io.serve(_server.handler, 'localhost', port);

  print('Servidor iniciado na porta $port');
}
