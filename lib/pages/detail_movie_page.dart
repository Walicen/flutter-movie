import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/service/filme_service.dart';

class DatailFilmePage extends StatefulWidget {
  final Filme filme;

  const DatailFilmePage({Key key, this.filme}) : super(key: key);

  @override
  _DatailFilmePageState createState() => _DatailFilmePageState();
}

class _DatailFilmePageState extends State<DatailFilmePage> {
  Filme get filme => widget.filme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(filme),
    );
  }

  _buildBody(Filme filme) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            child: Image.network(
              FilmesService.url_image + filme.backdrop_path,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
