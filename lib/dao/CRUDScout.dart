
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/modelo/userScout.dart';

class CRUDUserScout {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference? ref;
  CollectionReference? refNuevo;
  
  List<UserScout>? UserScouts;
  List<Pais>? paises;
  List<EquipoJugador>? equipos;
  
  CRUDUserScout() ;

 

  Future<QuerySnapshot> getDataCollection() {
    return _db.collection("users").get();
  }

  Future<List<UserScout>> fetchUserScouts() async {
    var result = await _db.collection("users").where("puesto",isEqualTo:"Agenda FootFeel").get();
    UserScouts = result.docs
        .map((doc) => UserScout.fromJson(doc.id, doc.data()))
        .toList();
    UserScouts?.sort((a,b)=>a.apellido.compareTo(b.apellido));
    return UserScouts??[];
  }


  Stream<QuerySnapshot> fetchUserScoutsAsStream() {
    return _db.collection("users")
        .orderBy("users", descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return _db.collection("users").doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return _db.collection("users").doc(id).delete();
  }



  updateUserScout(UserScout data) async {
    String path = "users/${data.id}";
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path);
    print(path);
    print(data.id);
     await dbRef.update({
      "puesto": data.puesto,

    });
  }


  Future<List<EquipoJugador>> fetchEquiposUsuario(String id) async {
    List<EquipoJugador> equiposAux=[];
    var result = await  _db.collection("users").doc(id).collection("equipos").get();
    equiposAux = result.docs
        .map((doc) => EquipoJugador.fromMap(doc.data(), doc.id))
        .toList();
    print("fetchEquiposTieneScout:${id}");
    print("fetchEquiposTieneScout:${equiposAux.length}");
    BBDDService().getUserScout().equipos=equiposAux;
    return equiposAux;
  }
  Future<List<EquipoJugador>> fetchEquiposTieneScout(String id) async {
    List<EquipoJugador> equiposAux=[];

    var result = await  _db.collection("users").doc(id).collection("equipos").get();
    equiposAux = result.docs
        .map((doc) => EquipoJugador.fromMap(doc.data(), doc.id))
        .toList();
    print("fetchEquiposTieneScout:${equiposAux.length}");
    return equiposAux;
  }

  Future<List<Pais>> fetchPaisesUsuario(String id) async {
    List<Pais> paisAux=[];
    var result = await  _db.collection("users").doc(id).collection("paises").get();
    paisAux = result.docs
        .map((doc) => Pais.fromMap(doc.data(), doc.id))
        .toList();
    print("fetchPaisesTieneScout:${id}");
    print("fetchPaisesTieneScout:${paisAux.length}");
    return paisAux;
  }

  Future<List<Pais>> fetchPaisesTieneUsuario(String id) async {
    List<Pais> paisAux=[];
    var result = await  _db.collection("users").doc(id).collection("paises").get();
    paisAux = result.docs
        .map((doc) => Pais.fromMap(doc.data(), doc.id))
        .toList();
    print("fetchEquiposTieneScout:${id}");
    print("fetchEquiposTieneScout:${paisAux.length}");
    BBDDService().getUserScout().paises=paisAux;
    return paisAux;
  }



  Future<List<EquipoJugador>> fetchEquipo(String data, Pais pais) async {
    List<EquipoJugador> equiposAux=[];
    var result = await  _db.collection("users").doc(data).collection("paises").
    doc(pais.id).collection("equipos").orderBy("equipo", descending: false).get();
    equiposAux = result.docs
        .map((doc) => EquipoJugador.fromMap(doc.data(), doc.id))
        .toList();
    return equiposAux;
  }

  Future<List<EquipoJugador>> fetchEquiposPaisesScout() async {
    List<EquipoJugador> equiposAux=[];
    equipos=[];
    var result = await  _db.collection("paises").where("pais",isEqualTo:"LALIGA").get();
    paises = result.docs
        .map((doc) => Pais.fromMap(doc.data(), doc.id))
        .toList();
    for(var p in paises!){
      equiposAux=await fetchEquiposScout(p);
      equipos?.addAll(equiposAux);
    }
    return equipos??[];
  }


  Future<List<EquipoJugador>> fetchEquiposScout(Pais pais) async {
    List<EquipoJugador> equiposAux=[];
    var result = await  _db.collection("paises").doc(pais.id).collection("equipos").get();
    equiposAux = result.docs
        .map((doc) => EquipoJugador.fromMap(doc.data(), doc.id))
        .toList();
    return equiposAux;
  }

  Future grabarEquipos(List<EquipoJugador> equipoJugador, UserScout scout)async {
    var collection = FirebaseFirestore.instance.collection("users").doc(scout.id).collection("equipos");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    for(var equipo in equipoJugador){
      if(equipo.lotiene)
        FirebaseFirestore.instance.collection("users").doc(scout.id).
        collection("equipos").add(equipo.toJson());
    }
  }

}