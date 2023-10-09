import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gls/modelo/categoria.dart';



class CRUDCategoria extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference ref;



  late List<Categoria> categorias;



  Future<List<Categoria>> fetchCategorias() async {
    //print(categoriaUser);
    var result =
        await _db.collection("categorias").orderBy("categoria", descending: false).get();

    categorias = result.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
    return categorias;
  }



  Future<List<Categoria>> fetchCategoriasTodas() async {

    var result =
    await _db.collection("categorias").orderBy("categoria", descending: false).get();

    categorias = result.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
    return categorias;
  }


  Stream<QuerySnapshot>? getDataCollectionCategorias() {

     _db.collection("categorias").orderBy("categoria", descending: false).snapshots();
  }

  Stream<QuerySnapshot> fetchCategoriasAsStream() {
    return ref.snapshots();
  }




}
