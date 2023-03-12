import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';

class CRUDEquipoJugador extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference ref;


  late List<EquipoJugador> equipos;


  Stream<QuerySnapshot> getDataCollectionEquipos(Pais pais) {
    print(pais.id)
;    return _db.
        collection("paises").doc(pais.id).collection("equipos").orderBy("equipo", descending: false).snapshots();
  }

  Future<List<EquipoJugador>> fetchEquiposJugadores(String pais) async {

    //FOOTFEEL FIRMADO
    ///////DIRECTOR DEPORTIVO///////
    print(pais);
    var result = await _db
        .collection("paises").doc(pais).collection("equipos").orderBy("equipo", descending: false)
        .get();
    equipos = result.docs
        .map((doc) =>
        EquipoJugador.fromJson(
          doc.id,
          doc.data(),
        )).toList();
    return equipos;
  }
  


  Stream<QuerySnapshot> fetchEquiposAsStream(Pais pais) {
    return ref.snapshots();
  }


  Future removeEquipo(Pais pais,String id) async{
     await _db.collection("paises").doc(pais.id).collection("equipos").doc(id).delete() ;
     return ;
  }
  Future updateEquipo(Pais pais,EquipoJugador equipo) async{
    await _db.collection("paises").doc(pais.id).collection("equipos").
    doc(equipo.id).update(equipo.toJson());
    return ;
  }

  Future addEquipo(Pais pais,EquipoJugador equipo) async{
    var result  =   await _db.collection("paises").doc(pais.id).collection("equipos").
    add(equipo.toJson()) ;
    //print("users/${BBDDService().getUsuario().idClub}/temporadas").doc(temporada.id).collection("equipos").doc(data.id).collection("equiposContrarios");
    return result.id;

  }


}
