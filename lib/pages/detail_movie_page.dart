import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/service/favoritos_service.dart';
import 'package:flutter_movie/service/filme_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatailFilmePage extends StatefulWidget {
  final Filme filme;

  const DatailFilmePage({Key key, this.filme}) : super(key: key);

  @override
  _DatailFilmePageState createState() => _DatailFilmePageState();
}

class _DatailFilmePageState extends State<DatailFilmePage> {
  bool _isFavorito = false;

  Filme get filme => widget.filme;

  @override
  void initState() {
    super.initState();
    final service = FavoritosService();

    service.exists(filme).then((b) {
      if (b) {
        setState(() {
          _isFavorito = b;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: _buildBody(filme),
    );
  }

  _buildBody(Filme filme) {
    return _sliverlist(filme);
  }

  _sliverlist(Filme filme) {
    String name = filme.title != null ? filme.title : filme.name;
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 40),
          elevation: 8.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.favorite,
                  color: _isFavorito ? Colors.red : Colors.white,
                ),
                onTap: () {
                  _onClickFavorito(context, filme);
                },
              ),
            )
          ],
          expandedHeight: 320.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              name,
              style: TextStyle(
                backgroundColor: Colors.black12,
                decorationThickness: 30,
              ),
            ),
            titlePadding: EdgeInsets.only(left: 50, bottom: 20),
            collapseMode: CollapseMode.parallax,
            background: Image.network(
                FilmesService.urlImage + filme.backdropPath,
                fit: BoxFit.cover),
          ),
        ), //SliverFixedExtentList
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _divider(),
                Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Image.network(
                            FilmesService.urlImage + filme.posterPath,
                            fit: BoxFit.scaleDown,
                          ),
                          height: 120,
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellowAccent,
                            ),
                            Text(
                              "${filme.voteAverage}/10",
                              style: TextStyle(fontSize: 28),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _data(),
                              style: TextStyle(fontSize: 28),
                            ),
                            Text(
                              "Release",
                              style: TextStyle(
                                  fontSize: 22, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    )),
                _divider(),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Sinopse",
                      style: TextStyle(fontSize: 33, fontFamily: "Ranga"),
                      textAlign: TextAlign.left,
                    )),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    filme.overview,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 23,
                        color: Colors.white30),
                  ),
                ),
                _divider(),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Gêneros",
                      style: TextStyle(fontSize: 33, fontFamily: "Ranga"),
                      textAlign: TextAlign.left,
                    )),
                Container(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filme.genreIds.length,
                    itemBuilder: (context, idx) {
                      return Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            FilmesService.getGenre(filme.genreIds[idx]),
                            style: TextStyle(fontSize: 18),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future _onClickFavorito(context, filme) async {
    final service = FavoritosService();
    final b = await service.favoritar(filme);

    Fluttertoast.showToast(
      msg: "${filme.title} foi adicionado a os favoritos!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
    );

    setState(() {
      _isFavorito = b;
    });
  }

  _divider() {
    return Divider(
      color: Colors.white12,
    );
  }

  _data() {
    return filme.releaseDate != null
        ? filme.releaseDate.substring(0, 4)
        : filme.firstAirDate.substring(0, 4);
  }
}
