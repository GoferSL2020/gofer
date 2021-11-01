import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

class Pais {
  String _pais;
  Uint8List _imagen;
  String key;
  String _temporada;

  Pais(this._pais,
      this._imagen); // Pais(this._idPais, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Pais.fromMap(dynamic obj) {
    this._pais = obj['pais'];

  }

  Pais.fromJson(this.key, Map data){
    pais = data['pais'];
    if(pais == null){
      pais = 'nadaaa';
    }
  }

  Pais.fromSnapshot(DataSnapshot obj):
        this.key = obj.key,
      this._pais = obj.value['pais'];

  Map toMapSnapshot(){
    return {pais: _pais, key: key};
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["pais"] = _pais;

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

  String get temporada => _temporada;

  set temporada(String value) {
    _temporada = value;
  }
}