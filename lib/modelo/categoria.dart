import 'dart:typed_data';

class Categoria {
  String _id;
  String _categoria;
  String _pais;
  Uint8List _imagen;
  String key;

  Categoria(); // Categoria(this._idCategoria, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Categoria.fromMap(Map snapshot,String id) :
        _id = id ?? '',
        _categoria = snapshot['categoria'] ?? '';

  toJson() {
    return {
      "categoria": _categoria,

    };
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

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}