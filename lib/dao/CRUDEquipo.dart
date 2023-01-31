import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/dao/CRUDJornada.dart';
import 'package:iafootfeel/dao/CRUDJugador.dart';
import 'package:iafootfeel/model/jugadorJornada.dart';
import 'package:iafootfeel/model/partidosJugadores.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/jornada.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/partido.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';

class CRUDEquipo extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  CRUDEquipo() {
  }

  List<Equipo> equipos;


  Future<List<Equipo>> fetchEquipos(Temporada temporada, Pais pais, Categoria categoria) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("equipos").orderBy("equipo",descending: false).get();
    equipos = result.docs
        .map((doc) => Equipo.fromMap(doc.data(), doc.id))
        .toList();
    return equipos;
  }

  Stream<QuerySnapshot> getDataCollectionEquipos(Temporada temporada, Pais pais, Categoria categoria) {
      return _db.
      collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("equipos").
      orderBy("equipo", descending: false).snapshots();
  }
  
  


  Stream<QuerySnapshot> fetchEquiposAsStream() {
    return ref.snapshots();
  }

  Future<Equipo> getEquipoById(String id) async {
    var doc = await ref.doc(id).get();
    return  Equipo.fromMap(doc.data(), doc.id) ;
  }

  Future<String> getEquipoByNombre(Temporada temporada, Pais pais, Categoria categoria,String equipo) async {
    String doc ;
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT
      await  _db.collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").
    doc(categoria.id).collection("equipos").
    where("equipo",isEqualTo: equipo).get().then((value) {
        doc= value.docs.first.id;
       });
    return doc;
  }



  List<Partido> partidos=List();
  Future<List<Partido>> getEquipoPartidos(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo) async {
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT

    var result= await  _db.collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").
    doc(categoria.id).collection("jornadas").orderBy("jornada").get();
    result.docs.forEach((element)async {
      var doc = await _db.collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).collection("categorias").
      doc(categoria.id).collection("jornadas").doc(element.id).collection(
          "partidos").where("equipoCASA", isEqualTo: equipo.equipo).get();
      partidos.addAll(doc.docs
          .map((doc) => Partido.fromMap(doc.data(),doc.id ))
          .toList());

      doc = await _db.collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).collection("categorias").
      doc(categoria.id).collection("jornadas").doc(element.id).collection(
          "partidos").where("equipoFUERA", isEqualTo: equipo.equipo).get();
        partidos.addAll(doc.docs
            .map((doc) => Partido.fromMap(doc.data(),doc.id ))
            .toList());
        });

    return partidos;
  }



  Future<List<Partido>> getEquipoJugadoresPuntuacionesPartidosNuevo(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo) async {
    List<Partido> partidosAux=[];
    partidosAux=await getEquipoPartidos(temporada, pais, categoria, equipo);
    print("PARTIDO:"+partidosAux.length.toString());
    return partidosAux;
  }


  Future<AccionPutuacionJugadorPartido> getPuntosPartidosJugador(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo, Partido partido, Player jugador, String local,String keyJornada) async {
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT
    String puntuaciones="";

    AccionPutuacionJugadorPartido accionPutuacionJugadorPartido=new AccionPutuacionJugadorPartido();
    await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("jornadas").doc(keyJornada).collection("partidos").doc(partido.id).collection(local).doc(jugador.key).get().then((value) {
      if(value!=null) {
        if(value.data()!=null){
          if(value.data()["puntuacion"]!=null)
            accionPutuacionJugadorPartido.putuacion=value.data()["puntuacion"].toString();
          if(value.data()["accion"]!=null)
            accionPutuacionJugadorPartido.accion=value.data()["accion"].toString();
          if(value.data()["estrella"]!=null)
            accionPutuacionJugadorPartido.estrella=value.data()["estrella"].toString();
        }}
    });
    print("${jugador.jugador}:${accionPutuacionJugadorPartido.accion}:${accionPutuacionJugadorPartido.putuacion}:");
    return accionPutuacionJugadorPartido;
  }


  Future<AccionPutuacionJugadorPartido> getPuntosPartidos(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo, Partido partido, Player jugador, String local) async {
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT
    String puntuaciones="";
      String keyJornada="";

      var result=await _db.collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).
      collection("categorias").doc(categoria.id).
      collection("jornadas").where("jornada",isEqualTo:partido.jornada).get().then((value) {
        keyJornada= value.docs.first.id;
      });
      AccionPutuacionJugadorPartido accionPutuacionJugadorPartido=new AccionPutuacionJugadorPartido();
      await _db.collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).
      collection("categorias").doc(categoria.id).
      collection("jornadas").doc(keyJornada).collection("partidos").doc(partido.id).collection(local).doc(jugador.key).get().then((value) {
        if(value!=null) {
          if(value.data()!=null){
          if(value.data()["puntuacion"]!=null)
            accionPutuacionJugadorPartido.putuacion=value.data()["puntuacion"].toString();
          if(value.data()["accion"]!=null)
            accionPutuacionJugadorPartido.accion=value.data()["accion"].toString();
          if(value.data()["estrella"]!=null)
            accionPutuacionJugadorPartido.estrella=value.data()["estrella"].toString();
        }}
      });
      print("${jugador.jugador}:${accionPutuacionJugadorPartido.accion}:${accionPutuacionJugadorPartido.putuacion}:");
      return accionPutuacionJugadorPartido;
  }


  Future removeEquipo(Temporada temporada,String id) async{
     await _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(id).delete() ;
     return ;
  }
  Future updateEquipo(Temporada temporada, Equipo data,String id) async{
    await _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(id).update(data.toJson());
    return ;
  }

  Future addEquipo(Temporada temporada,Equipo data) async{
    var result  = await _db.collection("temporadas").doc(temporada.id).collection("equipos").add(data.toJson()) ;
    return result.id;

  }

  Future addEquipoBackup(Temporada temporada,Equipo data) async{
    var result  = await _db.collection("temporadas").
    doc("sDA3dWP4QXbmsTcDOScS").collection("equipos").doc("ZFnAQblbQRHP2u6OBH6s");
    return result.id;

  }

  Future updateEquipoScouter(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo, String scouter) async {
    await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").doc(categoria.id).collection("equipos").doc(equipo.id).update
      ( {"scouter":  scouter});
    return ;
  }

  Future<QuerySnapshot> empateContar(Temporada temporada,Equipo equipo) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("partidos").where("resultado", isEqualTo: "EMPATE").get();
    return result;
  }
  Future<QuerySnapshot> ganadoContar(Temporada temporada,Equipo equipo) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("partidos").where("resultado", isEqualTo: "GANADO").get();
    return result;
  }
  Future<QuerySnapshot> perdidoContar(Temporada temporada,Equipo equipo) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("partidos").where("resultado", isEqualTo: "PERDIDO").get();
    return result;
  }

  Future<QuerySnapshot> empateContarCASA(Temporada temporada,Equipo equipo) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("partidos").where("resultado", isEqualTo: "EMPATE").where("lugar", isEqualTo: "CASA").get();
    return result;
  }
  Future<QuerySnapshot> ganadoContarCASA(Temporada temporada,Equipo equipo) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("partidos").where("resultado", isEqualTo: "GANADO").where("lugar", isEqualTo: "CASA").get();
    return result;
  }
  Future<QuerySnapshot> perdidoContarCASA(Temporada temporada,Equipo equipo) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("partidos").where("resultado", isEqualTo: "PERDIDO").where("lugar", isEqualTo: "CASA").get();
    return result;
  }

}
