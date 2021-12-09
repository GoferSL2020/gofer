import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';

import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/service/BBDDService.dart';

class CRUDEntrenador extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  CRUDEntrenador() {
  }

  List<Entrenador> entrenadores;



  Stream<QuerySnapshot> getDataCollectionEntrenadores(Temporada temporada,
      Equipo equipo, Pais pais, Categoria categoria) {
    print("temporadas/${temporada.id}/paises/${pais.id}/categorias/${categoria.id}/equipos/${equipo.id}/entrenadores");
    return _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").snapshots();
   // /temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/entrenadores
    // temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/entrenadores
  }


  Future<List<Entrenador>> fetchEntrenadores(Temporada temporada, Pais pais, Categoria categoria, String equipo) async {
    CRUDEquipo dao=CRUDEquipo();
    String id=await dao.getEquipoByNombre(temporada, pais,categoria,equipo);
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).collection("categorias").
    doc(categoria.id).collection("equipos").doc(id).collection("entrenadores").orderBy("dorsal").get();
    entrenadores = result.docs
        .map((doc) => Entrenador.fromJson(doc.id,doc.data(), ))
        .toList();
    return entrenadores;
  }



  ///temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/entrenadores
//temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/yuShjetPqtJA6TI1ovwT/entrenadores
  Stream<QuerySnapshot> fetchJugadorsAsStream() {
    return ref.snapshots();
  }


  Future removeEntrenador(Temporada temporada, Equipo equipo, String id) async {
    await _db.collection("temporadas").doc(temporada.id).collection("equipos")
        .doc(equipo.id).collection("entrenadores").doc(id)
        .delete();
    return;
  }



  Future updateEntrenadorDATABIG(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo, Entrenador jugador) async {
      await _db.
      collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).
      collection("DATABIG").doc(jugador.key).set(
          jugador.toJson());
    return;
  }

  Future updatePartidoAccion(Temporada temporada, Pais pais,
      Categoria categoria, Jornada jornada, Partido partido,
      String accion) async {
      String aux=
      accion=="SIM"?"Sin imágenes":accion=="SV"?"Sin visualizar":accion=="A"?"Aplazado":accion=="EV"?"Evaluar":"";
      await _db.
      collection("temporadas").doc(temporada.id).
      collection("paises").doc(pais.id).
      collection("categorias").doc(categoria.id).
      collection("jornadas").doc(jornada.id).
      collection("partidos").doc(partido.id).update(
          {"accion":  aux});
    return;
  }



  Future updateEntrenadorDatos(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo, Entrenador entrenador) async {
    Map<String, dynamic> map=entrenador.toJson();
    print(entrenador.key);
    await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").doc(entrenador.key).update(map);
    return;
  }

  Future addEntrenadorDatos(Temporada temporada, Pais pais, Categoria categoria, Equipo equipo, Entrenador entrenador) async {
    Map<String, dynamic> map=entrenador.toJson();
    print(entrenador.key);
    await _db.
    collection("temporadas").doc(temporada.id).
    collection("paises").doc(pais.id).
    collection("categorias").doc(categoria.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").add(entrenador.toJson());
    return;
  }
  Future addEntrenador(Temporada temporada, Equipo equipo, Entrenador data) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").add(data.toJson());
    return result.id;
  }

  toJson(String jornada) {
    return {
      "jornada": jornada,
    };
  }


  Stream<QuerySnapshot> getDataCollectionEntrenadoresEntrenamientos(
      Temporada temporada, Equipo equipo, int jornada) {
    return _db.collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("entrenamientos").doc(jornada.toString())
        .collection("entrenadores")
        .orderBy("entrenador", descending: false)
        .snapshots();
  }

  Future<QuerySnapshot> getDataCollectionEntrenadoresQuerySnapshot(
      Temporada temporada, Equipo equipo) {
    return _db.collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").orderBy("entrenador", descending: false).get();
  }


  Future<int> entrenamientosContar(Temporada temporada, Equipo equipo) async {
    // TODO: implement initState
    _db.collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("entrenamientos").get()
        .then((QuerySnapshot querySnapshot) {
      return (querySnapshot.docs.length);
    });
  }

  Future<QuerySnapshot> esPortero(Temporada temporada,Equipo equipo, String entrenador) async {
    var result = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").where("entrenador", isEqualTo: entrenador).where("posicion", isEqualTo: "Portero").get();
    return result;
  }

  Future<String> posiciconEntrenador(Temporada temporada,Equipo equipo, String entrenador) async {
    print("posicon:${temporada.id} ${equipo.id} $entrenador");
    String p="";
    QuerySnapshot qs = await _db.
    collection("temporadas").doc(temporada.id).
    collection("equipos").doc(equipo.id).
    collection("entrenadores").where("entrenador", isEqualTo: entrenador).get();
    if (qs.docs.isNotEmpty) {
      qs.docs.forEach((element) {
        p=element.data()['posicion'] ;
      });
      return p;
    }
  }



  Future<QuerySnapshot> getDataCollectionEntrenadoresConvocatoriaQuerySnapshot(
      Temporada temporada, Equipo equipo,Partido partido) {
    return _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).
    collection("partidos").doc(partido.id).
    collection("entrenadoresDetalle").orderBy("entrenador").get();
  }

  Future<QuerySnapshot> getDataCollectionEntrenadoresIncidenciasQuerySnapshot(
      Temporada temporada, Equipo equipo,Partido partido) {
    return _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).
    collection("partidos").doc(partido.id).
    collection("incidencias").orderBy("minuto").get();
  }


}
