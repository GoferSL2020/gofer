import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';

class Temporada {
  String _temporada;
  Uint8List _imagen;
  String key;

  Temporada(this._temporada,
      this._imagen); // Temporada(this._idPais, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Temporada.fromMap(dynamic obj) {
    this._temporada = obj['temporada'];

  }

  Temporada.fromJson(this.key, Map data){
    temporada = data['temporada'];
    if(temporada == null){
      temporada = 'nada';
    }
  }

  Temporada.fromSnapshot(DataSnapshot obj):
        this.key = obj.key,
      this._temporada = obj.value['temporada'];

  Map toMapSnapshot(){
    return {temporada: _temporada, key: key};
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["temporada"] = _temporada;

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

  String get temporada => _temporada;

  set temporada(String value) {
    _temporada = value;
  }
}