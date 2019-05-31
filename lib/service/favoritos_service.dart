
import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/filme.dart';

class FavoritosService {
  getFilmes() => _filmes.snapshots();

  CollectionReference get _filmes => Firestore.instance.collection("filmes");

  List<Filme> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((document) => Filme.fromJson(document.data) )
        .toList();
  }

  Future<bool> favoritar(Filme filme) async {

    var document = _filmes.document("${filme.id}");
    var documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print("${filme.title}, adicionado nos favoritos");
      document.setData(filme.toMap());

      return true;
    } else {
      print("${filme.title}, removido nos favoritos");
      document.delete();

      return false;
    }
  }

  Future<bool> exists(Filme filme) async {

    // Busca o filme no Firestore
    var document = _filmes.document("${filme.id}");
    if(document == null) {
      return false;
    }

    var documentSnapshot = await document.get();

    // Verifica se o filme está favoritado
    return await documentSnapshot.exists;
  }
}