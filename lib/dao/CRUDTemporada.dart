
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/partido.dart';
import 'package:iafootfeel/modelo/temporada.dart';
class CRUDTemporada{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;
  CollectionReference refNuevo;

  CRUDTemporada() {
  }

  List<Temporada> temporadas;

  Future<QuerySnapshot> getDataCollection() {
      return _db.collection("temporadas").get() ;
  }

  Future<List<Temporada>> fetchTemporadas() async {
    var result = await _db.collection("temporadas").get();

    temporadas = result.docs
        .map((doc) => Temporada.fromMap(doc.data(), doc.id))
        .toList();

    return temporadas;
  }

  Stream<QuerySnapshot> fetchTemporadasAsStream() {
    return _db.collection("temporadas").orderBy("temporada", descending: true).snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return _db.collection("temporadas").doc(id).get();
  }
  Future<void> removeDocument(String id){
    return _db.collection("temporadas").doc(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    ref = _db.collection("temporadas");
    return ref.add(data);
  }
  Future<void> updateTemporada(Temporada data , String id) {
    return ref.doc(id).update(data.toJson()) ;
  }




  Future<QuerySnapshot> getDataCollectionJugadoresConvocatoriaQuerySnapshot(
      Temporada temporada, Equipo equipo,Partido partido) {
    return _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).
    collection("partidos").doc(partido.id).
    collection("jugadoresDetalle").orderBy("jugador").get();
  }

  Future<QuerySnapshot> getDataCollectionJugadoresIncidenciasQuerySnapshot(
      Temporada temporada, Equipo equipo,Partido partido) {
    return _db.collection("temporadas").doc(temporada.id).collection("equipos").doc(equipo.id).
    collection("partidos").doc(partido.id).
    collection("incidencias").orderBy("minuto").get();
  }

}