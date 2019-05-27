
import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/response.dart';
import 'package:flutter_movie/service/firebase_service.dart';
import 'package:flutter_movie/pages/filmes_page.dart';
import 'package:flutter_movie/utils/alert.dart';
import 'package:flutter_movie/utils/nav.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_movie/widgets/progress.dart';

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
    color: Colors.green,
    fontSize: 22,
  );

  final _tLogin = TextEditingController(text: "walicen.r@gmail.com");
  final _tSenha = TextEditingController(text: "123456");

   _emailField() => TextField(
     controller: _tLogin,
    obscureText: false,
    style: styleText,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "E-mail",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        )),
  );
   _passField() => TextField(
    controller: _tSenha,
    obscureText: true,
    style: styleText,
    decoration: InputDecoration(
        fillColor: Colors.amber,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),)),
  );

   _loginButon(context) => Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: (){_onClickLogin(context);},
      child: Text("Login",
          textAlign: TextAlign.center,
          style: styleText.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );

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
            _emailField(),
            _space(),
            _passField(),
            _space(),
            Container(
              child: showProgress ? Progress() : _loginButon(context),
            ),
            _space(),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Cadastre-se",
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
