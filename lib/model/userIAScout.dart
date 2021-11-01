import 'package:firebase_database/firebase_database.dart';

class UserIAScout {
  String _id;
  String _name;
  String _email;
  String _age;
  String _idioma;
  String _color;
  String _temporada;

  UserIAScout(this._id,this._name, this._email, this._age, this._idioma, this._color,String temporada);


  set id(String value) {
    _id = value;
  }

  String get name => _name;

  String get email => _email;

  String get age => _age;

  String get id => _id;

  String get idioma => _idioma;

  String get color => _color;

  UserIAScout.map(dynamic obj){
    this._name = obj['nombre'];
    this._email = obj['email'];
    this._age = obj['año'];
    this._idioma = obj['idioma'];
    this._color = obj['color'];
  }

  UserIAScout.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['nombre'];
    _email = snapshot.value['email'];
    _age = snapshot.value['año'];
    _idioma = snapshot.value['idioma'];
    _color = snapshot.value['color'];


  }

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set age(String value) {
    _age = value;
  }

  set idioma(String value) {
    _idioma = value;
  }

  set color(String value) {
    _color = value;
  }

  String get temporada => _temporada;

  set temporada(String value) {
    _temporada = value;
  }
}
