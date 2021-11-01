import 'package:firebase_database/firebase_database.dart';

class UserScout {
  String _id;
  String _name;
  String _email;
  String _categoria;
  String _temporada;


  UserScout(this._id, this._name, this._email, this._categoria,this._temporada);



  UserScout.map(dynamic obj){
    this._name = obj['nombre'];
    this._email = obj['email'];
    this._categoria = obj['categoria'];
  }

  UserScout.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['nombre'];
    _email = snapshot.value['email'];
    _categoria = snapshot.value['categoria'];
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get temporada => _temporada;

  set temporada(String value) {
    _temporada = value;
  }
}
