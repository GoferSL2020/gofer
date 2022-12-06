
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/userScout.dart';



class BBDDService {
  DatabaseReference _counterRef;
  static UserScout _userFootFeel=new UserScout("", "","","","");
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final BBDDService _instance =
  new BBDDService.internal();

  BBDDService.internal();

  factory BBDDService() {
    return _instance;
  }

  void initState() {
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  UserScout getUserScout() {
    return _userFootFeel;
  }

  addUserScout(UserScout user) async {
    final TransactionResult transactionResult =
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _userRef.push().set(<String, String>{
        "nombre": "" + user.name,

      }).then((_) {
        //print('Transaction  committed.');
      });
    } else {
      //print('Transaction not committed.');
      if (transactionResult.error != null) {
        //print(transactionResult.error.message);
      }
    }
  }

  void deleteUserScout(UserScout user) async {
    await _userRef.child(user.id).remove().then((_) {
      //print('Transaction  committed.');
    });
  }

  void updateUserScout(UserScout user) async {
    await _userRef.child(user.id).update({
      "nombre": "" + user.name,
       "email": "" + user.email,

    }).then((_) {
      //print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

   Future<UserScout> getUserApp2() async {
    //print("FUTURREEEEEE");
    User result = FirebaseAuth.instance.currentUser;
    FirebaseDatabase.instance.reference().child("Users").child(result.uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        _userFootFeel.name = values['nombre'];
        _userFootFeel.email = values['email'];
        _userFootFeel.puesto = values['puesto'];
        _userFootFeel.apellido = values['apellido'];

      });
    });

    return _userFootFeel;
  }

  Future<UserScout> getUsuarioIniciar() async {
    User id = FirebaseAuth.instance.currentUser;
    var doc = await _db.collection("users").doc(id.uid).get();
    _userFootFeel.name=doc.data()["nombre"];// = Usuario.fromMap(doc.data(), doc.id) ;
    _userFootFeel.apellido=doc.data()["apellido"];// = Usuario.fromMap(doc.data(), doc.id) ;
    _userFootFeel.email=id.email;// = Usuario.fromMap(doc.data(), doc.id) ;
    _userFootFeel.puesto=doc.data()["puesto"];
    // = Usuario.fromMap(doc.data(), doc.id) ;
    print("FUTURREEEEEEFINALLL");
    _userFootFeel.equipos= await CRUDUserScout().fetchEquiposUsuario(id.uid);
    _userFootFeel.paises= await CRUDUserScout().fetchPaisesUsuario(id.uid);

  }

  Future<UserScout> getEquipos() async {
    User id = FirebaseAuth.instance.currentUser;
    var doc = await _db.collection("users").doc(id.uid).get();
    print("FUTURREEEEEEFINALLL");
    _userFootFeel.equipos= await CRUDUserScout().fetchEquiposUsuario(id.uid);

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
