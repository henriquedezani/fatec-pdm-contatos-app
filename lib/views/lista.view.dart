import 'dart:convert';

import 'package:contatos_app/models/contato.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaView extends StatelessWidget {
  Future<List<Contato>> read() async {
    var response = await http.get('https://dezani-contatos-api.herokuapp.com');
    if (response.statusCode == 200) {
      Iterable contatos = jsonDecode(response.body) as List;
      var lista = contatos.map((objeto) => Contato.fromJson(objeto));
      return lista.toList();
    }
    return List<Contato>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: FutureBuilder<List<Contato>>(
        future: read(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text("Erro ao carregar os dados.");

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              Contato contato = snapshot.data[index];
              return ListTile(
                title: Text(contato.nome),
                subtitle: Text(contato.telefone),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/cadastro'),
      ),
    );
  }
}
