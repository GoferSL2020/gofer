import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';

class CRUDPais extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference ref;

  late List<Pais> paises;


  Future<List<Pais>> fetchPaises() async {
    var result = await  _db.collection("paises").orderBy("indice", descending: false).get();
    paises = result.docs
        .map((doc) => Pais.fromMap(doc.data(), doc.id))
        .toList();
    return paises;
  }

  Stream<QuerySnapshot> getDataCollectionPaises() {
    return
      _db.
    collection("paises").
    orderBy("indice", descending: false).snapshots();
  }




  Stream<QuerySnapshot> fetchPaisesAsStream() {
    return ref.snapshots();
  }

 /* Future<Pais> getEquipoById(String id) async {
    var doc = await ref.doc(id).get();
    return  Pais.fromMap(doc.data(), doc.id) ;
  }*/

  Future<String?> getEquipoByNombre(String pais) async {
      String doc="";
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT
      await _db.collection("paises").where("pais", isEqualTo: pais).get()
          .then((value) {
        doc = value.docs.first.id;
      });
    return doc;
  }

  Future removeEquipo(Temporada temporada,String id) async{
    await _db.collection("temporadas").doc(temporada.id).collection("paises").doc(id).delete() ;
    return ;
  }
  Future updateEquipo(Temporada temporada, Pais data,String id) async{
    await _db.collection("temporadas").doc(temporada.id).collection("paises").doc(id).update(data.toJson());
    return ;
  }

  Future addEquipo(Temporada temporada,Pais data) async{
    var result  = await _db.collection("temporadas").doc(temporada.id).collection("paises").add(data.toJson()) ;
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
