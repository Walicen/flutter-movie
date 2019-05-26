import 'package:flutter/material.dart';

class DatailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      color: Colors.amber,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.arrow_back),
                  Icon(Icons.settings),
                ],
              ),
              Image.network('https://qph.fs.quoracdn.net/main-qimg-27d25d3fd343a3d2e4384c7f0eeaf785')
            ],
          ),
        ),
      ),
    );
  }
}
