import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/cantera.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/scout.dart';
import 'package:iafootfeel/modelo/seleccion.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';

class CRUDCategoria extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  CRUDCategoria() {
  }

  List<Categoria> categorias;
  List<Cantera> canteras;
  List<Seleccion> selecciones;



  Future<List<Categoria>> fetchCategorias(Pais paisAux) async {
    //print(categoriaUser);
    var result =
        await _db.collection("paises").
        doc(paisAux.id).collection("categorias").orderBy("indice", descending: false).get();

    categorias = result.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
    return categorias;
  }

  Future<List<Seleccion>> fetchSelecciones() async {
    //print(categoriaUser);
    var result =
    await _db.collection("selecciones").orderBy("indice", descending: false).get();
    selecciones = result.docs
        .map((doc) => Seleccion.fromMap(doc.data(), doc.id))
        .toList();
    return selecciones;
  }

  Future<List<Categoria>> fetchCategoriasID(String id) async {
    print(id);
    var result =
    await _db.collection("paises").
    doc(id).collection("categorias").orderBy("indice", descending: false).get();

    categorias = result.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
    return categorias;
  }

  Future<List<Categoria>> fetchCategoriasTodas() async {

    var result =
    await _db.collection("categorias").orderBy("indice", descending: false).get();

    categorias = result.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
    return categorias;
  }

  Future<List<Cantera>> fetchCantera() async {
    //print(categoriaUser);
    var result =
    await _db.collection("cantera")
    .orderBy("equipo", descending: false).get();

    canteras = result.docs
        .map((doc) => Cantera.fromMap(doc.data(), doc.id))
        .toList();
    return canteras;
  }


  Future<List<Categoria>> fetchCategoriasScout() async {
    var result =
    await _db.collection("/temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias").orderBy("indice", descending: false).get();

    categorias = result.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
    return categorias;
  }

  List<Scout> scouting;
  Future<List<Scout>> fetchScouting(Pais pais, Categoria categoria) async {
    List<Scout> scouter=[];
    var result = await _db.
    collection("paises").doc(pais.id).collection("scouter").get();
    if (result.docs.isNotEmpty) {
      result.docs.forEach((element) {
        List<String> aux=element.data()['scout'].toString().split(",");
        for(var doc in aux) {
          print(doc);
          Scout scout = new Scout(doc);
          scouter.add(scout);
        }
      });
    }
    scouting=scouter;
    return scouting;
  }

  Stream<QuerySnapshot> getDataCollectionCategorias(Pais pais) {
    print("PAISES:${pais.id}");
     _db.collection("paises").
    doc(pais.id).collection("categorias").orderBy("indice", descending: false).snapshots();
  }




  Stream<QuerySnapshot> fetchCategoriasAsStream() {
    return ref.snapshots();
  }

  Future<Pais> getCategoriaById(String id) async {
    var doc = await ref.doc(id).get();
    return  Pais.fromMap(doc.data(), doc.id) ;
  }


  Future removeCategoria(Temporada temporada,String id) async{
    await _db.collection("paises").doc(id).delete() ;
    return ;
  }
  Future updateCategoria(Pais pais,Categoria categoria) async{
    await _db.collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).update(categoria.toJson());
    return ;
  }

  Future addCategoria(Temporada temporada,Pais data) async{
    var result  = await _db.collection("paises").add(data.toJson()) ;
    return result.id;

  }


  Future<QuerySnapshot> empateContar(Temporada temporada,Pais pais) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("partidos").where("resultado", isEqualTo: "EMPATE").get();
    return result;
  }
  Future<QuerySnapshot> ganadoContar(Temporada temporada,Pais pais) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("pais").doc(pais.id).
    collection("partidos").where("resultado", isEqualTo: "GANADO").get();
    return result;
  }
  Future<QuerySnapshot> perdidoContar(Temporada temporada,Pais pais) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("pais").doc(pais.id).
    collection("partidos").where("resultado", isEqualTo: "PERDIDO").get();
    return result;
  }

  Future<QuerySnapshot> empateContarCASA(Temporada temporada,Pais pais) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("pais").doc(pais.id).
    collection("partidos").where("resultado", isEqualTo: "EMPATE").where("lugar", isEqualTo: "CASA").get();
    return result;
  }
  Future<QuerySnapshot> ganadoContarCASA(Temporada temporada,Pais pais) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("pais").doc(pais.id).
    collection("partidos").where("resultado", isEqualTo: "GANADO").where("lugar", isEqualTo: "CASA").get();
    return result;
  }
  Future<QuerySnapshot> perdidoContarCASA(Temporada temporada,Pais pais) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("pais").doc(pais.id).
    collection("partidos").where("resultado", isEqualTo: "PERDIDO").where("lugar", isEqualTo: "CASA").get();
    return result;
  }

}
