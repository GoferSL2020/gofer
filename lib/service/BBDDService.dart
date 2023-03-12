
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/modelo/userScout.dart';



class BBDDService {
  static UserScout _userFootFeel=new UserScout("", "","","","");
  DatabaseReference? _userRef;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseDatabase database = new FirebaseDatabase();

  static final BBDDService _instance =
  new BBDDService.internal();

  BBDDService.internal();

  factory BBDDService() {
    return _instance;
  }

  void initState() {
  }



  UserScout getUserScout() {
    return _userFootFeel;
  }


  void deleteUserScout(UserScout user) async {
    await _userRef!.child(user.id).remove().then((_) {
      //print('Transaction  committed.');
    });
  }

  void updateUserScout(UserScout user) async {
    await _userRef!.child(user.id).update({
      "nombre": "" + user.name,
       "email": "" + user.email,

    }).then((_) {
      //print('Transaction  committed.');
    });
  }

  void dispose() {
  }


  Future<UserScout?> getUsuarioIniciar() async {
    User? id = FirebaseAuth.instance.currentUser;
    var doc = await _db.collection("users").doc(id?.uid).get();
    _userFootFeel.name=doc!.data()!["nombre"];// = Usuario.fromMap(doc.data(), doc.id) ;
    _userFootFeel.apellido=doc!.data()!["apellido"];// = Usuario.fromMap(doc.data(), doc.id) ;
    _userFootFeel.email=id!.email!;// = Usuario.fromMap(doc.data(), doc.id) ;
    _userFootFeel.puesto=doc!.data()!["puesto"];
    // = Usuario.fromMap(doc.data(), doc.id) ;
    print("FUTURREEEEEEFINALLL");
    _userFootFeel.equipos= await CRUDUserScout().fetchEquiposUsuario(id.uid);
    _userFootFeel.paises= await CRUDUserScout().fetchPaisesUsuario(id.uid);

  }

  Future<UserScout?> getEquipos() async {
    User? id = FirebaseAuth.instance.currentUser;
    String? idUSSER=id?.uid;
    var doc = await _db.collection("users").doc(idUSSER!).get();
    print("FUTURREEEEEEFINALLL");
    _userFootFeel.equipos= await CRUDUserScout().fetchEquiposUsuario(idUSSER!);

  }

  static UserScout get userFootFeel => _userFootFeel;

  static set userFootFeel(UserScout value) {
    _userFootFeel = value;
  }

/*Future<UserScout> getUserApp() async {
    User result = FirebaseAuth.instance.currentUser;
    print("FUTURREEEEEE:"+result.uid);
     await FirebaseDatabase.instance.reference().child(
       "Users").orderByChild("email").equalTo(result.email).once().then((DataSnapshot snapshot) {
      //FirebaseDatabase.instance.reference().child("Users").child(result.uid).once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        _userFootFeel.name = values['nombre'];
        _userFootFeel.email = values['email'];
        _userFootFeel.apellido = values['apellido'];
        _userFootFeel.puesto = values['puesto'];
      });
    });

    return _userFootFeel;
  }*/

}
