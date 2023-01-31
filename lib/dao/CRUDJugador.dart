import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/dao/CRUDEquipo.dart';
import 'package:iafootfeel/dao/CRUDPartido.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/jornada.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/partido.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/modelo/temporada.dart';

class CRUDJugador extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  CRUDJugador() {}

  List<Player> jugadores=List();
  Player jugador;

  List<Player> jugadoresDATA = List();

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresFootFeelDDFirmado(FiltroJugadores scouter) async {
    CRUDEquipo dao = CRUDEquipo();
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
    CRUDEquipo dao = CRUDEquipo();
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
    CRUDEquipo dao = CRUDEquipo();
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
    CRUDEquipo dao = CRUDEquipo();
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
    CRUDEquipo dao = CRUDEquipo();
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
    CRUDEquipo dao = CRUDEquipo();
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
          )).toList().where((element) => element.categoriaEdadBBDD.contains(filtro.cantera)).toList();

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



  Stream<QuerySnapshot> getDataCollectionJugadores(FiltroJugadores scouter) {
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
    CRUDEquipo dao = CRUDEquipo();
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

  Future<Player> fetchJugador(Temporada temporada, Pais pais,
      Categoria categoria, Equipo equipo, String key) async {
    CRUDEquipo dao = CRUDEquipo();
    var doc = await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("categorias")
        .doc(categoria.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("jugadores")
        .doc(key)
        .get();
    await new Future.delayed(new Duration(seconds: 2));

    jugador = Player.fromJson(doc.id, doc.data());

    return jugador;
  }

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresEstrella(Temporada temporada, Pais pais,
      Categoria categoria, String equipo, int jornada) async {
    CRUDEquipo dao = CRUDEquipo();
    String id = await dao.getEquipoByNombre(temporada, pais, categoria, equipo);
    print("${id}:${jornada}");
    var result = await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("categorias")
        .doc(categoria.id)
        .collection("equipos")
        .doc(id)
        .collection("jugadores")
        .where("estrella_jornada_$jornada", isEqualTo: true)
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

  Future<List<Player>> fetchJugadoresPuntuaciones(
      String donde,
      List<Player> jugadores,
      Temporada temporada,
      Pais pais,
      Categoria categoria,
      Jornada jornada,
      Partido partido) async {
    for (var d in jugadores) {
      var result = await _db
          .collection("temporadas")
          .doc(temporada.id)
          .collection("paises")
          .doc(pais.id)
          .collection("categorias")
          .doc(categoria.id)
          .collection("jornadas")
          .doc(jornada.id)
          .collection("partidos")
          .doc(partido.id)
          .collection(donde)
          .doc(d.key)
          .get()
          .then((value) {
        d.estrella = value.data()["estrella"];
        d.puntuacion = value.data()["puntuacion"];
        d.estado = value.data()["estado"];
      });
    }

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

  Future updateJugadorPuntuaciones(
      Temporada temporada,
      Pais pais,
      Categoria categoria,
      Jornada jornada,
      Partido partido,
      List<Player> jugadorCASA,
      List<Player> jugadorFUERA) async {
    for (var jugadorCASA in jugadorCASA) {
      await _db
          .collection("temporadas")
          .doc(temporada.id)
          .collection("paises")
          .doc(pais.id)
          .collection("categorias")
          .doc(categoria.id)
          .collection("jornadas")
          .doc(jornada.id)
          .collection("partidos")
          .doc(partido.id)
          .collection("jugadoresCASA")
          .doc(jugadorCASA.key)
          .set(jugadorCASA.toJsonpuntaciones());
    }
    for (var jugadorFUERA in jugadorFUERA) {
      await _db
          .collection("temporadas")
          .doc(temporada.id)
          .collection("paises")
          .doc(pais.id)
          .collection("categorias")
          .doc(categoria.id)
          .collection("jornadas")
          .doc(jornada.id)
          .collection("partidos")
          .doc(partido.id)
          .collection("jugadoresFUERA")
          .doc(jugadorFUERA.key)
          .set(jugadorFUERA.toJsonpuntaciones());
    }
    return;
  }

  Future updatePartidoAccion(
      Temporada temporada,
      Pais pais,
      Categoria categoria,
      Jornada jornada,
      Partido partido,
      String accion) async {
    String aux = accion == "SIM"
        ? "Sin imágenes"
        : accion == "SV"
            ? "Sin visualizar"
            : accion == "A"
                ? "Aplazado"
                : accion == "EV"
                    ? "Evaluar"
                    : "";
    await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("categorias")
        .doc(categoria.id)
        .collection("jornadas")
        .doc(jornada.id)
        .collection("partidos")
        .doc(partido.id)
        .update({"accion": aux});
    return;
  }

  Future updateJugadorScouting( Player jugador) async {
    print("${jugador.jugador}:${jugador.key}:${jugador.nacionalidad2}:");
    await _db
        .collection("jugadores")
        .doc(jugador.key)
        .update({"nacionalidad2": jugador.nacionalidad2.toUpperCase()});
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

  Future<String> getJugadorByNombre(Temporada temporada, Pais pais,
      Categoria categoria, String equipo, String jugador) async {
    String doc;
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT
    await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("paises")
        .doc(pais.id)
        .collection("categorias")
        .doc(categoria.id)
        .collection("equipos")
        .doc(equipo)
        .collection("jugadores")
        .where("jugador", isEqualTo: jugador)
        .get()
        .then((value) {
      doc = value.docs.first.id;
    });
    return doc;
  }

  Stream<QuerySnapshot> getDataCollectionJugadoresEntrenamientos(
      Temporada temporada, Equipo equipo, int jornada) {
    return _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("entrenamientos")
        .doc(jornada.toString())
        .collection("jugadores")
        .orderBy("jugador", descending: false)
        .snapshots();
  }

  Future<QuerySnapshot> getDataCollectionJugadoresQuerySnapshot(
      Temporada temporada, Equipo equipo) {
    return _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("jugadores")
        .orderBy("jugador", descending: false)
        .get();
  }

  Future<int> entrenamientosContar(Temporada temporada, Equipo equipo) async {
    // TODO: implement initState
    _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("entrenamientos")
        .get()
        .then((QuerySnapshot querySnapshot) {
      return (querySnapshot.docs.length);
    });
  }

  Future<QuerySnapshot> esPortero(
      Temporada temporada, Equipo equipo, String jugador) async {
    var result = await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("jugadores")
        .where("jugador", isEqualTo: jugador)
        .where("posicion", isEqualTo: "Portero")
        .get();
    return result;
  }

  Future<String> posiciconJugador(
      Temporada temporada, Equipo equipo, String jugador) async {
    String p = "";
    QuerySnapshot qs = await _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("jugadores")
        .where("jugador", isEqualTo: jugador)
        .get();
    if (qs.docs.isNotEmpty) {
      qs.docs.forEach((element) {
        p = element.data()['posicion'];
      });
      return p;
    }
  }

  Future<QuerySnapshot> getDataCollectionJugadoresConvocatoriaQuerySnapshot(
      Temporada temporada, Equipo equipo, Partido partido) {
    return _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("partidos")
        .doc(partido.id)
        .collection("jugadoresDetalle")
        .orderBy("jugador")
        .get();
  }

  Future<QuerySnapshot> getDataCollectionJugadoresIncidenciasQuerySnapshot(
      Temporada temporada, Equipo equipo, Partido partido) {
    return _db
        .collection("temporadas")
        .doc(temporada.id)
        .collection("equipos")
        .doc(equipo.id)
        .collection("partidos")
        .doc(partido.id)
        .collection("incidencias")
        .orderBy("minuto")
        .get();
  }

  //Jugadores  Nombre del club
  Future<List<Player>> fetchJugadoresOnce(Player jugadorFiltro,
      Temporada temporada, Pais pais, Categoria categoria) async {
    print(jugadorFiltro.jornada);
    jugadoresDATA.clear();
    Partido partido = new Partido();
    partido.jornada = jugadorFiltro.jornada;
    CRUDEquipo dao = CRUDEquipo();
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/jugadoresDATA
    print("temporadas/${temporada.id}/paises/${pais.id}/jugadoresDATA");
    var result = await _db
        .collection(
            "temporadas/${temporada.id}/paises/${pais.id}/jugadoresDATA")
        .where("estrella_jornada_${jugadorFiltro.jornada}", isEqualTo: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Player jug = Player.fromJson(element.id, element.data());

        jugadoresDATA.add(jug);
      });
    });
    return jugadoresDATA;
  }


  //Jugadores  Nombre del club
  Future<List<Player>> fetchImportar(Player jugadorFiltro,
      Temporada temporada, Pais pais, Categoria categoria) async {
    print(jugadorFiltro.jornada);
    jugadoresDATA.clear();
    Partido partido = new Partido();
    partido.jornada = jugadorFiltro.jornada;
    CRUDEquipo dao = CRUDEquipo();
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/jugadoresDATA
    print("temporadas/${temporada.id}/paises/${pais.id}/jugadoresDATA");
    var result = await _db
        .collection(
        "/temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/jugadoresDATA")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Player jug = Player.fromJson(element.id, element.data());

        jugadoresDATA.add(jug);
      });
    });
    return jugadoresDATA;
  }



  fetchJugadoresdescatados(Temporada temporada, Pais pais, Categoria categoria,
      Jornada jornada) async {
    List<Player> destacados = List();
    List<Partido> partidos = await CRUDPartido()
        .fetchPartidosJornada(temporada, pais, categoria, jornada);
    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/jugadoresDATA
    CRUDPartido dao = CRUDPartido();
    CRUDJugador dao2 = CRUDJugador();
    for (var partido in partidos) {
      List<Player> jugadoresCASA = await dao2.fetchJugadoresEstrella(
          temporada, pais, categoria, partido.equipoCASA, jornada.jornada);
      List<Player> jugadoresFUERA = await dao2.fetchJugadoresEstrella(
          temporada, pais, categoria, partido.equipoFUERA, jornada.jornada);
      destacados.addAll(jugadoresCASA);
      destacados.addAll(jugadoresFUERA);
    }

    return destacados;
  }

}
