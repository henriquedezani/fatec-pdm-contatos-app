import 'package:contatos_app/views/cadastro.view.dart';
import 'package:contatos_app/views/lista.view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => ListaView(),
        '/cadastro': (context) => CadastroView(),
      },
      initialRoute: '/',
    );
  }
}
