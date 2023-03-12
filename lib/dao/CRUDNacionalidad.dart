import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/nacionalidad.dart';

class CRUDNacionalidad extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
 late CollectionReference ref;


  late List<Nacionalidad> nacionalidades;


  Future<List<Nacionalidad>> fetchNacionalidades() async {
    var result = await  _db.collection("nacionalidad").get();
    nacionalidades = result.docs
        .map((doc) => Nacionalidad.fromMap(doc.data(), doc.id))
        .toList();
    return nacionalidades;
  }

  Stream<QuerySnapshot> getDataCollectionNacionalidades() {
    return
      _db.
    collection("nacionalidad").
    snapshots();
  }




  Stream<QuerySnapshot> fetchnacionalidadesAsStream() {
    return ref.snapshots();
  }



  Future addEquipo(Nacionalidad nacionalidad) async{
    var result  =   await _db.collection("nacionalidad").
    add(nacionalidad.toJson()) ;
    //print("users/${BBDDService().getUsuario().idClub}/temporadas").doc(temporada.id).collection("equipos").doc(data.id).collection("equiposContrarios");
    return result.id;

  }

  Future removeEquipo(String id) async{
    await _db.collection("nacionalidad").doc(id).delete() ;
    return ;
  }
  Future updateEquipo( Nacionalidad data) async{
    await _db.collection("nacionalidad").doc(data.id).update(data.toJson());
    return ;
  }


}
