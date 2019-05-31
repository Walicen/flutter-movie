import 'package:flutter/material.dart';
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
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();

    // _firebaseMessaging.getToken().then((s)=>{
    //   print("Token $s")
    // });
  }

  var showProgress = false;
  static var styleText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 22,
  );

  final _tLogin = TextEditingController(text: "teste@gmail.com");
  final _tSenha = TextEditingController(text: "123456");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      backgroundColor: Colors.white,
    );
  }

  _body(context) {
    return Container(
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
              child: showProgress ? Progress() : loginButon(context, "Login", _onClickLogin, styleText ),
            ),
            _space(),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  push(context, CadastroPage());
                },
                child: Text(
                  "Registre-se",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
