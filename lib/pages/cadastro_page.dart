import 'package:flutter/material.dart';
import 'package:flutter_movie/service/firebase_service.dart';
import 'package:flutter_movie/utils/alert.dart';
import 'package:flutter_movie/utils/nav.dart';
import 'package:flutter_movie/widgets/forms.dart';

import 'filmes_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _tNome = TextEditingController(text: "");
  final _tEmail = TextEditingController(text: "");
  final _tSenha = TextEditingController(text: "");

  var styleText = TextStyle(
    color: Colors.white,
    fontSize: 22,
  );

  final _formKey = GlobalKey<FormState>();

  bool _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              children: <Widget>[
                nameField(_tNome, styleText),
                space(),
                emailField(_tEmail, styleText),
                space(),
                passField(_tSenha, styleText),
                space(),
                _progress
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : loginButon(
                        context, "Cadastrar", _onClickCadastrar, styleText, null),
                space(),
                cancelButton(context, "Cancelar", _onClickCancelar, styleText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onClickCancelar(context) {
    pop(context);
  }

  _onClickCadastrar(context) async {
    print("Cadastrar!");

    String nome = _tNome.text;
    String email = _tEmail.text;
    String senha = _tSenha.text;

    print("Nome $nome, Email $email, Senha $senha");

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final service = FirebaseService();
    final response = await service.cadastrar(nome, email, senha);

    if (response.isOk()) {
      pushReplacement(context, FilmesPage());
    } else {
      alert(context, title: "Erro", msg: response.msg);
    }

    setState(() {
      _progress = false;
    });
  }
}
