import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';

class Cantera {
  String _equipo="";
  String _cantera="";
  String _pais="";
  String _id="";
  Cantera( this._equipo, this._pais,
      ); // Categoria(this._idCategoria, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Cantera.fromMap(Map snapshot,String id) :
        _id = id ?? '',
        _equipo = snapshot['equipo'] ?? '';

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get equipo => _equipo;

  set equipo(String value) {
    _equipo = value;
  }

  String get cantera => _cantera;

  set cantera(String value) {
    _cantera = value;
  }
}