
import 'package:iadvancedscout/userScout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';



class BBDDService {
  DatabaseReference _counterRef;
  static UserScout _userAppalabros=new UserScout("", "","","","");
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
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
    return _userAppalabros;
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
        _userAppalabros.name = values['nombre'];
        _userAppalabros.email = values['email'];
        _userAppalabros.categoria = values['categoria'];

      });
    });

    return _userAppalabros;
  }

  Future<UserScout> getUserApp() async {
    User result = FirebaseAuth.instance.currentUser;
    //print("FUTURREEEEEE:"+result.uid);
     await FirebaseDatabase.instance.reference().child(
       "Users").orderByChild("email").equalTo(result.email).once().then((DataSnapshot snapshot) {
      //FirebaseDatabase.instance.reference().child("Users").child(result.uid).once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        _userAppalabros.name = values['nombre'];
        _userAppalabros.email = values['email'];
        _userAppalabros.categoria = values['categoria'];

      });
    });

    return _userAppalabros;
  }
}
