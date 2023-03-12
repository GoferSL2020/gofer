import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';

import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/modelo/temporada.dart';

class CRUDJugador extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference ref;



  List<Player> jugadores=[];
  late Player jugador;

  List<Player> jugadoresDATA = [];

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresFootFeelDDFirmado(FiltroJugadores scouter) async {

    //FOOTFEEL FIRMADO
      ///////DIRECTOR DEPORTIVO///////
        var result = await _db
            .collection("jugadores")
            .where("firmado", isEqualTo: true)
            .get();
        jugadores = result.docs
            .map((doc) =>
            Player.fromJson(
              doc.id,
              doc.data(),
            )).toList();
    return jugadores;
  }

  Future<List<Player>> fetchJugadoresFootFeelAgenteFirmado(FiltroJugadores scouter) async {

    jugadores.clear();
    jugadoresDATA.clear();
    //FOOTFEEL FIRMADO
    ///////DIRECTOR DEPORTIVO///////
    print("AGENTE:${scouter.scouter}");
    var result = await _db
        .collection("jugadores")
        .where("scouter", isEqualTo: scouter.scouter)
        .get();
    jugadoresDATA = result.docs
        .map((doc) =>
        Player.fromJson(
          doc.id,
          doc.data(),
        )).toList();

    jugadoresDATA.forEach((element) {
      if(element.firmado==true)
        jugadores.add(element);
      if(element.proceso==true)
        jugadores.add(element);
    });
    return jugadores;
  }

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresFootFeelTodos() async {

    //FOOTFEEL FIRMADO
    ///////DIRECTOR DEPORTIVO///////
    var result = await _db
        .collection("jugadores")
        .get();
    jugadores = result.docs
        .map((doc) =>
        Player.fromJson(
          doc.id,
          doc.data(),
        )).toList();
    return jugadores;
  }

  Future<List<Player>> fetchJugadoresFootFeelCanteraAgente(FiltroJugadores filtro) async {

    //FOOTFEEL FIRMADO
    ///////DIRECTOR DEPORTIVO///////
    print("EQUIPO:${filtro.equipo}${filtro.cantera}");
    if(filtro.equipo=="") {
      var result = await _db
          .collection("jugadores")
          .where("pais", isEqualTo: filtro.pais)
          .where("firmado", isEqualTo: false)
          .where("competecion", isEqualTo: filtro.cantera)
          .get();
      jugadores = result.docs
          .map((doc) =>
          Player.fromJson(
            doc.id,
            doc.data(),
          )).toList();
    }else{
      var result = await _db
          .collection("jugadores")
          .where("pais", isEqualTo: filtro.pais)
          .where("equipo", isEqualTo: filtro.equipo)
          .where("categoria", isEqualTo: filtro.cantera)
          .where("firmado", isEqualTo: false)
          .get();
      jugadores = result.docs
          .map((doc) =>
          Player.fromJson(
            doc.id,
            doc.data(),
          )).toList();
      print("ORDENAR");
      jugadores.sort((a,b)=>a.catCantera.compareTo(b.catCantera));
    }

    return jugadores;
  }

  Future<List<Player>> fetchJugadoresFootFeelSelecciones(FiltroJugadores filtro) async {
    //FOOTFEEL FIRMADO
    ///////DIRECTOR DEPORTIVO///////
    print("fetchJugadoresFootFeelSelecciones:${filtro.pais}${filtro.equipo}${filtro.cantera}");
      var result = await _db
          .collection("jugadores")
          .where("nacionalidad", isEqualTo: filtro.pais)
          .where("seleccion", isEqualTo: filtro.cantera)
          .get();
      jugadores = result.docs
          .map((doc) =>
          Player.fromJson(
            doc.id,
            doc.data(),
          )).toList();
    return jugadores;
  }

    Future<List<Player>> fetchJugadoresFootFeelCanteraDD(FiltroJugadores filtro) async {

    //FOOTFEEL FIRMADO
    print("///////DIRECTOR DEPORTIVO//////${filtro.pais}/");
    print("///////DIRECTOR DEPORTIVO//////${filtro.equipo}:${filtro.cantera}/");

    if(filtro.equipo=="") {
      var result = await _db
          .collection("jugadores")
          .where("firmado", isEqualTo: false)
          .where("competecion", isEqualTo: filtro.cantera)
          .where("pais", isEqualTo: filtro.pais)
          .get();

      jugadores = result.docs
          .map((doc) =>
          Player.fromJson(
            doc.id,
            doc.data(),
          )).toList().where((element) => element.categoriaEdadBBDD.contains(filtro.cantera!)).toList();

      }else{
      var result = await _db
          .collection("jugadores")
          .where("firmado", isEqualTo: false)
          .where("pais", isEqualTo: filtro.pais)
          .where("equipo", isEqualTo: filtro.equipo)
          .get();

      jugadores = result.docs
          .map((doc) =>
          Player.fromJson(
            doc.id,
            doc.data(),
          )).toList();
    }
    
    return jugadores;
  }




  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresFootFeel(FiltroJugadores filtro) async {
    ////FOOTFEEL
        if(filtro.scouter=="")
          return fetchJugadoresFootFeelDDFirmado(filtro);
        else {
          return fetchJugadoresFootFeelAgenteFirmado(filtro);
        }

  }

  Future<List<Player>> fetchJugadoresFootFeelCanteraSelecciones(FiltroJugadores filtro) async {
    ////FOOTFEEL
      return fetchJugadoresFootFeelSelecciones(filtro);
  }


  Future<List<Player>> fetchJugadoresFootFeelCantera(FiltroJugadores filtro) async {
    ////FOOTFEEL
    return fetchJugadoresFootFeelCanteraAgente(filtro);
  }



  Stream<QuerySnapshot>? getDataCollectionJugadores(FiltroJugadores scouter) {
    if(BBDDService().getUserScout().puesto=="FootFeel") {
      if(scouter.scouter=="")
      return _db
          .collection("jugadores")
          .where("firmado", isEqualTo: scouter.firmado)
          .orderBy("jugador", descending: false)
          .snapshots();

    }
    else {
      print("SCOUTER:${BBDDService()
          .getUserScout()
          .name}");
      return _db
          .collection("jugadores")
          .where("scouter", isEqualTo: BBDDService().getUserScout().name)
          .orderBy("jugador", descending: false)
          .snapshots();
    }
    // /temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/jugadores
    // temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/jugadores
  }

  Stream<QuerySnapshot> getDataCollectionJugadoresScouter(FiltroJugadores scouter) {
    if(BBDDService().getUserScout().puesto=="FootFeel"){
      if(scouter.scouter=="")
      return _db
          .collection("jugadores")
          .where("firmado", isEqualTo: scouter.firmado)
          .snapshots();
      else{
        return _db
            .collection("jugadores")
            .where("scouter", isEqualTo: scouter.scouter)
            .where("firmado", isEqualTo: scouter.firmado)
            .snapshots();
      }
    }
    else {
      if(scouter.scouter=="")
        scouter.scouter=BBDDService().getUserScout().name;
      print("SCOUTER:${scouter.scouter}:${scouter.firmado}:${scouter.cantera}");
      return _db
          .collection("jugadores")
          .where("scouter", isEqualTo: scouter.scouter)
          .where("firmado", isEqualTo: scouter.firmado)
          //.orderBy("dorsal", descending: false)
          .snapshots();
    }
    // /temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/jugadores
    // temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/jugadores
  }

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadores() async {

    var result = await _db
        .collection("jugadores").orderBy("jugador")
        .get();
    jugadores = result.docs
        .map((doc) => Player.fromJson(
              doc.id,
              doc.data(),
            ))
        .toList();
    return jugadores;
  }




  Future<List<Player>> fetchJugadoresList(Temporada temporada, Pais pais,
      Categoria categoria, Equipo equipo) async {
    var result = await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("categorias")
        .doc(categoria.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("jugadores")
        .orderBy("dorsal")
        .get();
    jugadores = result.docs
        .map((doc) => Player.fromJson(
              doc.id,
              doc.data(),
            ))
        .toList();
    return jugadores;
  }



  Stream<QuerySnapshot> fetchJugadorsAsStream() {
    return ref.snapshots();
  }

  Future removeJugador( Player jugador) async {
    await _db
        .collection("jugadores")
        .doc(jugador.key)
        .delete();
    return;
  }


  Future updateJugadorScouting( Player jugador) async {
    print("${jugador.jugador}:${jugador.key}:${jugador.equipo}:");
    await _db
        .collection("jugadores")
        .doc(jugador.key)
        .update({"valor": "0"});
    return;
  }

  Future updateJugadorDatos(Player jugador) async {
    Map<String, dynamic> map = jugador.toTodoJson();
    await _db
        .collection("jugadores")
        .doc(jugador.key)
        .update(map);
    return;
  }

  Future addJugadorDatos( Player jugador) async {
    Map<String, dynamic> map = jugador.toJson();
    var result = await _db
        .collection("jugadores")
        .add(jugador.toTodoJson())
        .then((value) => jugador.key = value.id);
  }

  Future addJugadorDatosDATABIG(Temporada temporada, Pais pais,
      Categoria categoria, Equipo equipo, Player jugador) async {
    await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("jugadoresDATA")
        .doc(jugador.key)
        .set(jugador.toTodoJson());
    return;
  }

  Future updateJugadorDATABIG(Temporada temporada, Pais pais,
      Categoria categoria, Equipo equipo, Player jugador) async {
    await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("jugadoresDATA")
        .doc(jugador.key)
        .set(jugador.toTodoJson());
    return;
  }

  Future addJugador(Temporada temporada, Equipo equipo, Player data) async {
    var result = await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("jugadores")
        .add(data.toJson());
    return result.id;
  }

  toJson(String jornada) {
    return {
      "jornada": jornada,
    };
  }



}
