import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/jornada.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/partido.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/modelo/temporada.dart';

import 'CRUDJugador.dart';
class CRUDPartido extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  CRUDPartido();

  List<Partido> equipos;
  List<String> scouting;
  //_db.collection("temporadas")
  List<Partido> partidos;

  Future<List<Partido>> fetchPartidos(Temporada temporada, Equipo equipo) async {
    var result = await _db.collection("temporadas").doc(temporada.id).collection("equipos").get();
    equipos = result.docs
        .map((doc) => Partido.fromMap(doc.data(), doc.id))
        .toList();
    return equipos;
  }




  Stream<QuerySnapshot> getDataCollectionPartidos(Temporada temporada, Pais pais,Categoria categoria, Jornada jornada) {
    return
     _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
     collection("categorias").doc(categoria.id).
     collection("jornadas").doc(jornada.id).
    collection("partidos").snapshots();
  }


  Stream<QuerySnapshot> fetchPartidosAsStream(Temporada temporada, Equipo equipo) {
    return _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).collection("partidos").snapshots();
  }

  Stream<QuerySnapshot> fetchJornadasEquipoAsStream(Temporada temporada, Equipo equipo) {
    return _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).collection("partidos").snapshots();
  }


  Future<List<String>> fetchJornadasTodasAsStream(String temporada) async {
    List<String> fechas=[];
    await _db.collection("temporadas/$temporada/equipos").get().then((equiposAux) =>
        equiposAux.docs.forEach((element) {
          _db.collection("temporadas/${temporada}/equipos").
          doc(element.id).collection("partidos").get().then((partidos) =>
              partidos.docs.forEach((partido) {
                fechas.add(partido.get("fecha"));
              })
          );
        }
        )
    );

      return fechas;
  }

  Future<List<Partido>> fetchPartidosJornada(Temporada temporada, Pais pais,Categoria categoria, Jornada jornada) async {
    List<String> fechas=[];
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("jornadas").
    doc(jornada.id).collection("partidos").get();
    partidos = result.docs
        .map((doc) => Partido.fromMap(doc.data(), doc.id))
        .toList();
    return partidos;
  }




  Future<Partido> getPartidoById(Temporada temporada, Equipo equipo,String id) async {
    var doc = await _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).collection("partidos").doc(id).get();
    return  Partido.fromMap(doc.data(), doc.id) ;
  }


  Future removePartido(Temporada temporada, Pais pais,Categoria categoria, Jornada jornada, Partido partido) async{
     await _db.
     collection("temporadas").doc(temporada.id).
     collection("paises").doc(pais.id).
     collection("categorias").doc(categoria.id).
     collection("jornadas").doc(jornada.id).
     collection("partidos").doc(partido.id).delete() ;

     return ;
  }
  Future updatePartido(Temporada temporada, Pais pais,Categoria categoria, Jornada jornada, Partido partido) async{
    await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("jornadas").doc(jornada.id).
    collection("partidos").doc(partido.id).update(partido.toJson());

    return;
  }

  Future updatePartidoAccion(Temporada temporada, Pais pais,Categoria categoria, Jornada jornada, Partido partido) async{
    await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("jornadas").doc(jornada.id).
    collection("partidos").doc(partido.id).update({
      "accion": partido.accion,
    });

    return;
  }
  Future addPartido(Temporada temporada, Pais pais,Categoria categoria, Jornada jornada, Partido partido) async{
    var result  = await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("jornadas").doc(jornada.id).
    collection("partidos").add(partido.toJson()) ;

    return true;

  }

  update(Temporada temporada, Equipo equipo, Partido partido, String id) async {
    final productProvider = new CRUDJugador();
    QuerySnapshot qs = await productProvider
        .getDataCollectionJugadoresConvocatoriaQuerySnapshot(
        temporada, equipo,partido);
    }


}
