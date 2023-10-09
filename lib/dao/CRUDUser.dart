
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gls/modelo/UserOficina.dart';



class CRUDUser {
  DatabaseReference? _userRef;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseDatabase database = new FirebaseDatabase();

  static final CRUDUser _instance =
  new CRUDUser.internal();

  CRUDUser.internal();

  factory CRUDUser() {
    return _instance;
  }

  void initState() {
  }



  Future getUsuarioIniciar(UserOficina userOficina) async {
    User? id = FirebaseAuth.instance.currentUser;
    var doc = await _db.collection("users").doc(id?.uid).get();
    userOficina.nombre=doc.data()!["nombre"];// = Usuario.fromMap(doc.data(), doc.id) ;
    userOficina.lugar=doc.data()!["lugar"];// = Usuario.fromMap(doc.data(), doc.id) ;
    userOficina.numeroOficina=doc.data()!["numeroOficina"];// = Usuario.fromMap(doc.data(), doc.id) ;
    userOficina.plataforma=doc.data()!["plataforma"];// = Usuario.fromMap(doc.data(), doc.id) ;
    userOficina.email=id!.email!; // = Usuario.fromMap(doc.data(), doc.id) ;
  }



}
