import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/service/filme_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DatailFilmePage extends StatefulWidget {
  final Filme filme;

  const DatailFilmePage({Key key, this.filme}) : super(key: key);

  @override
  _DatailFilmePageState createState() => _DatailFilmePageState();
}

class _DatailFilmePageState extends State<DatailFilmePage> {
  double rating = 2.5;

  var favoriteColor = Colors.white;

  Filme get filme => widget.filme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(filme),
    );
  }

  _buildBody(Filme filme) {
    return _sliverlist(filme);
  }

  _sliverlist(Filme filme) {
    String name = filme.title != null ? filme.title : filme.name;
    return CustomScrollView(
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
                  color: favoriteColor,
                ),
                onTap: () {
                  setState(() {
                    favoriteColor = Colors.red;
                  });
                },
              ),
            )
          ],
          expandedHeight: 300.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              name,
              style: TextStyle(
                  backgroundColor: Colors.black12, decorationThickness: 30),
            ),
            titlePadding: EdgeInsets.only(left: 50, bottom: 20),
            collapseMode: CollapseMode.parallax,
            background: Image.network(
                FilmesService.url_image + filme.backdrop_path,
                fit: BoxFit.cover),
          ),
        ), //SliverFixedExtentList
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Text(
                        filme.vote_average,
                        style: TextStyle(fontSize: 40),
                      )
                    ],
                  )),
              Divider(
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  filme.overview,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 23),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }

  /*
  * SliverFixedExtentList(
          itemExtent: 150,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.transparent,
                child: Text(name, style: TextStyle(color: Colors.white)),
              ),
              Container(
                color: Colors.purple,
                child:
                    Text(filme.overview, style: TextStyle(color: Colors.white)),
              ),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
              Container(color: Colors.pink),
            ],
          ),
        ),*/

  SmoothStarRating _ratting() {
    return SmoothStarRating(
      allowHalfRating: false,
      starCount: 5,
      rating: rating,
      size: 40.0,
      color: Colors.yellow,
      borderColor: Colors.yellowAccent,
    );
  }

  _imageBack(Filme filme) {
    return Image.network(
      FilmesService.url_image + filme.backdrop_path,
      fit: BoxFit.fitHeight,
    );
  }

  _myAppBar() {
    return Container(
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
    );
  }
}
