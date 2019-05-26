import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  Progress(
      {this.size = 25.0, this.color = Colors.blue, this.strokeWidth = 2.0});

  @override
  Widget build(BuildContext context) {
    bool ios = Platform.isIOS;

    // Progress
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: ios ? _iOS() : _android(),
      ),
    );
  }

  _iOS() {
    return SizedBox(
      child: CupertinoActivityIndicator(
        radius: size / 2,
      ),
      height: size,
      width: size,
    );
  }
  _android() {
    return SizedBox(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
      height: size,
      width: size,
    );
  }
}
