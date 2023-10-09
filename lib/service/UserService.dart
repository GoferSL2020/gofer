import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gls/dao/CRUDUser.dart';
import 'package:gls/modelo/UserOficina.dart';

class UserService {
  static UserOficina userOficina = new UserOficina("", "", "", "", 0, false);
  static final CRUDUser _instanceCRUDUser = new CRUDUser.internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final UserService _instance = new UserService.internal();

  UserService.internal();

  factory UserService() {
    return _instance;
  }

  void initState() {}

  Future<UserOficina?> getUsuarioIniciar() async {
    await _instanceCRUDUser.getUsuarioIniciar(userOficina);
  }
}
