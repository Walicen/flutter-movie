import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_movie/pages/cadastro_page.dart';
import 'package:flutter_movie/pages/filmes_page.dart';
import 'package:flutter_movie/service/firebase_service.dart';
import 'package:flutter_movie/utils/alert.dart';
import 'package:flutter_movie/utils/nav.dart';
import 'package:flutter_movie/widgets/progress.dart';
import 'package:flutter_movie/widgets/forms.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
  }

  var showProgress = false;
  static var styleText = TextStyle(
    color: Colors.white,
    fontSize: 22,
  );

  final _tLogin = TextEditingController(text: "");
  final _tSenha = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      backgroundColor: Colors.white,
    );
  }

  _body(context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              image: AssetImage("assets/imgs/movie.jpg"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                emailField(_tLogin, styleText),
                _space(),
                passField(_tSenha, styleText),
                _space(),
                Container(
                  child: showProgress
                      ? Progress()
                      : loginButon(context, "Entrar", _onClickLogin, styleText,
                          Color(0xff01A0C7)),
                ),
                _space(),
                Text(
                  "OU",
                  textAlign: TextAlign.center,
                ),
                _space(),
                GoogleSignInButton(
                    darkMode: true, onPressed: _loginGoogle, borderRadius: 12),
                FacebookSignInButton(
                  onPressed: () {},
                  borderRadius: 12,
                )
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("Não possui conta? "),
              InkWell(
                child: Text(
                  "Registre-se",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                onTap: () {
                  _signIn(context);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  _signIn(context) => push(context, CadastroPage());

  _onClickLogin(context) async {
    print("Login!");

    setState(() {
      showProgress = true;
    });

    String login = _tLogin.text;
    String senha = _tSenha.text;

//    Response response = await LoginService.login(login, senha);

    var response = await _firebaseService.login(login, senha);

    if (response.isOk()) {
      pushReplacement(context, FilmesPage());
    } else {
      alert(context, msg: response.msg);
    }

    setState(() {
      showProgress = false;
    });
  }

  _space() {
    return SizedBox(
      height: 25,
    );
  }

  _loginGoogle() async {
    var response = await _firebaseService.loginGoogle();

    if (response.isOk()) {
      print("Login efetuado com sucesso!");
      pushReplacement(context, FilmesPage());
    } else {
      print("Something wrong!");
      AlertDialog(
        title: Text("Erro"),
        content: Text("Something wrong!"),
        actions: <Widget>[
          FlatButton(
            child: Text("Fechar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}
