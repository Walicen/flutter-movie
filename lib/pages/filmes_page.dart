import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/pages/favoritos_page.dart';
import 'package:flutter_movie/service/filme_service.dart';
import 'package:flutter_movie/utils/nav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movie/pages/detail_movie_page.dart';

import 'login_page.dart';

class FilmesPage extends StatefulWidget {
  @override
  _FilmesPageState createState() => _FilmesPageState();
}

class _FilmesPageState extends State<FilmesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      appBar: AppBar(
        title: Text("Flutter Movie App"),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: (){_logout(context);},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.movie)),
            Tab(icon: Icon(Icons.local_movies)),
            Tab(icon: Icon(Icons.movie_filter))
          ],
        ),
      ),
    );
  }

  _buildBody(context) {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Container(
          child: _gridBuilder(context, 'filme'),
        ),
        Container(
          child: _gridBuilder(context, 'serie'),
        ),
        FavoritosPage(),
      ],
    );
  }

  _gridBuilder(context, tipo) {
    Future<List<Filme>> film = FilmesService.getFilmes(tipo);

    return FutureBuilder<List<Filme>>(
      future: film,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Filme> filmes = snapshot.data;

        return _staggeredGridView(filmes);
      },
    );
  }

  _staggeredGridView(List<Filme> filmes) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: filmes.length,
      itemBuilder: (context, idx) {
        return InkWell(
          onTap: () {
            push(context, DatailFilmePage(filme: filmes[idx],));
          },
          child: Container(
            color: Colors.black,
            child: CachedNetworkImage(
              imageUrl: FilmesService.url_image + filmes[idx].poster_path,
              placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.extent(2, 350),
    );
  }

  _logout(context) {
    pushReplacement(context, LoginPage());
  }
}
