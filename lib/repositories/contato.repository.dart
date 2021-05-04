import 'dart:convert';

import 'package:contatos_app/models/contato.model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ContatoRepository extends ChangeNotifier {
  List<Contato> contatos = new List<Contato>();

  ContatoRepository() {
    read();
  }

  Future<void> create(Contato contato) async {
    var response = await http.post(
      'https://dezani-contatos-api.herokuapp.com',
      body: jsonEncode(contato.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      Contato contato = Contato.fromJson(jsonDecode(response.body));
      contatos.add(contato);
      notifyListeners();
    }
  }

  Future<void> read() async {
    var response = await http.get('https://dezani-contatos-api.herokuapp.com');
    if (response.statusCode == 200) {
      Iterable contatos = jsonDecode(response.body) as List;
      var lista = contatos.map((objeto) => Contato.fromJson(objeto));
      contatos = lista.toList();
      notifyListeners();
    }
  }
}
