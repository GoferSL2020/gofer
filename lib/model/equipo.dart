import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

class Equipo {
  String _equipo;
  String _categoria;
  String _pais;
  Uint8List _imagen;

  String _escudo="";


String key;

  Equipo(this._equipo, this._categoria, this._pais,
      this._imagen); // Equipo(this._idEquipo, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Equipo.fromMap(dynamic obj) {
    this._equipo = obj['equipo'];
    this._categoria = obj['categoria'];
    this._pais = obj['pais'];
  }
  Equipo.fromJson(this.key, Map data){
    this._equipo = data['equipo'];
    this._categoria = data['categoria'];
    this._pais = data['pais'];
    //this._imagen = data['imagen'];

    }
  Equipo.fromSnapshot(DataSnapshot obj):
        this._equipo = obj.value['equipo'],
        this._categoria = obj.value['categoria'],
        this._pais = obj.value['pais'],
        this._imagen = obj.value['imagen'];


  Map toMapSnapshot(){
    return {pais: _pais, key: key, categoria: _categoria, equipo:_equipo};
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["EQUIPO"] = _equipo;
    map["CATEGORIA"] = _categoria;
    map["PAIS"] = _pais;
     map["IMAGEN"] = _imagen;
    return map;
  }

  static Uint8List decode(File imagen){
    Uint8List aux=imagen.readAsBytesSync();
    //var thumbnail =copyResize(imagen, width: 500)
    //print("DECODE:"+imagen.path);
    return aux;

    /* Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    var thumbnail = copyResize(image, width: 500);

    // Save the thumbnail as a PNG.
    File('thumbnail.png').writeAsBytesSync(encodePng(thumbnail));
    return imagen;*/
  }

  Uint8List get imagen => _imagen;

  set imagen(Uint8List value) {
    _imagen = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get equipo => _equipo;

  set equipo(String value) {
    _equipo = value;
  }




}

class EquipoCloud{
  String key="";
  String nombre="";
}
