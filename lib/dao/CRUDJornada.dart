import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/jornada.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/temporada.dart';

class CRUDJornada extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  CRUDJornada() {
  }

  List<Jornada> jornadas;



  Stream<QuerySnapshot> getDataCollectionJornadas(Temporada temporada, Pais pais, Categoria categoria) {
      return _db.
      collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("jornadas").
      orderBy("jornada", descending: false).snapshots();
  }
  
  


  Stream<QuerySnapshot> fetchJornadasAsStream() {
    return ref.snapshots();
  }

  Future<Jornada> getEquipoById(String id) async {
    var doc = await ref.doc(id).get();
    return  Jornada.fromMap(doc.data(), doc.id) ;
  }


  Future<List<Jornada>> fetchJornadas(Temporada temporada, Pais pais, Categoria categoria) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("jornadas").orderBy("jornada",descending: false).get();
    jornadas = result.docs
        .map((doc) => Jornada.fromMap(doc.data(), doc.id))
        .toList();
    return jornadas;
  }


  Future removeJornada(Temporada temporada,Categoria categoria, Pais pais,Jornada jornada) async{
     await _db.collection("temporadas").doc(temporada.id).
     collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("jornadas").doc(jornada.id).delete() ;
     return ;
  }
  Future updateJornada(Temporada temporada,Categoria categoria, Pais pais,Jornada jornada) async{
    await _db.collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("jornadas").doc(jornada.id).update(jornada.toJson());
    return ;
  }

  Future addJornada(Temporada temporada,Categoria categoria, Pais pais,Jornada jornada,) async{
    var result =await _db.collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("jornadas").add(jornada.toJson()) ;
    return result;

  }

  Future<String> getJornadaByNumero(Temporada temporada, Pais pais, Categoria categoria,int jornada) async {
    String doc ;
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT
    await  _db.collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").
    doc(categoria.id).collection("jornadas").
    where("jornada",isEqualTo: jornada).get().then((value) {
      doc= value.docs.first.id;
    });
    return doc;
  }

}
