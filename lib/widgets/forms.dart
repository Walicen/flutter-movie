import 'package:flutter/material.dart';

space() {
  return SizedBox(
    height: 25,
  );
}

nameField(controller, styleText) => TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: false,
      style: styleText,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff01A0C7)),
            borderRadius: BorderRadius.circular(32),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff01A0C7)),
            borderRadius: BorderRadius.circular(32),
          )),
    );

emailField(controller, styleText) => TextField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      obscureText: false,
      style: styleText,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "E-mail",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff01A0C7)),
            borderRadius: BorderRadius.circular(32),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff01A0C7)),
            borderRadius: BorderRadius.circular(32),
          )),
    );

passField(controller, styleText) => TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: true,
      style: styleText,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff01A0C7)),
            borderRadius: BorderRadius.circular(32),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff01A0C7)),
            borderRadius: BorderRadius.circular(32),
          )),
    );

loginButon(context, text, _onClick, styleText, backgroundColor) => Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: backgroundColor != null ? backgroundColor : Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _onClick(context);
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: styleText.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

cancelButton(context, text, _onClick, styleText) => Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffF44336),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _onClick(context);
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: styleText.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
