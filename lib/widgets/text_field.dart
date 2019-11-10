import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final String hint;
  final Function validator;
  final Function onSaved;
  final bool password;

  AppText(this.label, this.hint,
      {this.validator, this.onSaved, this.password = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: this.validator,
      onSaved: this.onSaved,
      obscureText: password,
      keyboardType: TextInputType.text,
      cursorColor: Colors.lightBlue,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      decoration: InputDecoration(
          labelText: this.label,
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          hintText: this.hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(width: 1, color: Colors.lightBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(width: 1, color: Colors.lightBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.grey)),
          errorStyle: TextStyle(fontSize: 18)),
    );
  }
}
