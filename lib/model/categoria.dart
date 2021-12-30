import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';

class Categoria {
  String _categoria;
  String _pais;
  Uint8List _imagen;
  String key;

  Categoria( this._categoria, this._pais,
      this._imagen); // Categoria(this._idCategoria, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Categoria.fromMap(dynamic obj) {

    this._categoria = obj['CATEGORIA'];
    this._pais = obj['PAIS'];
    this._imagen = obj['IMAGEN'];
  }

  Categoria.fromJson(this.key, Map data){
    this._categoria = data['categoria'];
    this._pais = data['pais'];
    this._imagen = data['imagen'];
    this.key = key;
  }

  Categoria.fromSnapshot(DataSnapshot obj):
        this._categoria = obj.value['categoria'],
        this._pais = obj.value['pais'],
        this._imagen = obj.value['imagen'];


  Map toMapSnapshot(){
    return {pais: _pais, key: key, categoria: _categoria};
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["CATEGORIA"] = _categoria;
    map["PAIS"] = _pais;
    map["IMAGEN"] = _imagen;
    return map;
  }

  static Uint8List decode(File imagen){
    Uint8List aux=imagen.readAsBytesSync();
    //var thumbnail =copyResize(imagen, width: 500)
    //print("DECODE:"+imagen.path);
    //print("DECODE2:"+imagen.readAsBytesSync().toString());
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

}