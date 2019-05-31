

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';
import 'package:flutter_movie/service/favoritos_service.dart';
import 'package:flutter_movie/widgets/filmes_list_view.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {

    final service = FavoritosService();

    return Container(
      padding: EdgeInsets.all(12),
      child: StreamBuilder<QuerySnapshot>(
        stream: service.getFilmes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

//            final List<Carro> carros = snapshot.data;
            List<Filme> filmes = service.toList(snapshot);

            return FilmesListView(filmes);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Sem dados",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 26,
                  fontStyle: FontStyle.italic
              ),),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


}

