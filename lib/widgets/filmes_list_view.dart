
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/pages/detail_movie_page.dart';
import 'package:flutter_movie/utils/nav.dart';

class FilmesListView extends StatefulWidget {
  final List<Filme> filmes;

  final bool search;

  final ScrollController scrollController;

  final bool showProgress;

  final bool scrollToTheEnd;

  const FilmesListView(this.filmes,
      {this.search = false, this.scrollController,this.showProgress=false, this.scrollToTheEnd = false});

  @override
  _FilmesListViewState createState() => _FilmesListViewState();
}

class _FilmesListViewState extends State<FilmesListView> {

  ScrollController get scrollController => widget.scrollController;
  bool get showProgress => widget.showProgress;
  List<Filme> get carros => widget.filmes;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if(widget.scrollToTheEnd) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: showProgress ? carros.length + 1 : carros.length,
      itemBuilder: (ctx, idx) {

        if (showProgress && carros.length == idx) {
          return Container(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Filme
        final f = widget.filmes[idx];
        return Container(
          height: 280,
          child: InkWell(
            onTap: () {
              _onClickFilme(context, f);
            },
            onLongPress: () {
              _onLongClickFilme(context, f);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        f.poster_path ??
                            "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                        height: 150,
                      ),
                    ),
                    Text(
                      f.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      f.overview,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () {
                              _onClickFilme(context, f);
                            },
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {
//                              _onClickShare(context, f);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onLongClickFilme(BuildContext context, Filme f) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  f.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text("Detalhes"),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  pop(context);
                  _onClickFilme(context, f);
                },
              ),
              ListTile(
                title: Text("Share"),
                leading: Icon(Icons.share),
                onTap: () {
                  pop(context);
//                  _onClickShare(context, c);
                },
              )
            ],
          );
        });
  }

  void _onClickFilme(BuildContext context, Filme filme) async {
    if (widget.search) {
      // Retorna da busca
//      pop(context, filme);
    } else {
      // Navega para a tela de detlahes
      Filme f = await push(context, DatailFilmePage(filme: filme));
      if(f != null) {
        // Remove o carro excluído da lista
        widget.filmes.remove(filme);
        setState(() {});
      }
    }
  }

//  void _onClickShare(BuildContext context, Filme c) {
//    print("Share ${c.nome}");
//
//    Share.share(c.urlFoto);
//  }
}
