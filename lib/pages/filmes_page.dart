import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/service/filme_service.dart';
import 'package:flutter_movie/utils/nav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movie/pages/detail_movie_page.dart';

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
          child: _gridBuilder(context),
        ),
        Container(color: Colors.amber,),
        Container(color: Colors.blueGrey,)
      ],
    );
  }

  _gridBuilder(context) {
    Future<List<Filme>> film = FilmesService.getFilmes();

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
            push(context, DatailPage());
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
}
