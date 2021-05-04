import 'dart:convert';

import 'package:contatos_app/models/contato.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroView extends StatelessWidget {
  Contato contato = new Contato();
  var _formKey = GlobalKey<FormState>();

  Future<void> salvar(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String url = 'https://dezani-contatos-api.herokuapp.com';
      var response = await http.post(
        url,
        body: jsonEncode(contato.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Falha no cadastro"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Contato"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nome",
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => contato.nome = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Telefone",
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => contato.telefone = value,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Salvar"),
                        onPressed: () => salvar(context),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
