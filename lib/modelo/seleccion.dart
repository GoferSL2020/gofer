import 'dart:typed_data';

class Seleccion {
  String _id="";
  String _seleccion="";
  int _indice=0;


  Seleccion(); // Categoria(this._idCategoria, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Seleccion.fromMap(Map snapshot,String id) :
        _id = id ?? '',
        _indice = snapshot['indice'] ?? '',
      _seleccion = snapshot['seleccion'] ?? '';

  toJson() {
    return {
      "seleccion": _seleccion,
      "indice": _indice,

    };
  }

  String get seleccion => _seleccion;

  set seleccion(String value) {
    _seleccion = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  int get indice => _indice;

  set indice(int value) {
    _indice = value;
  }
}