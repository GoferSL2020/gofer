import 'dart:typed_data';

class Categoria {
  String _id="";
  String _categoria="";
  String _pais="";
  String key="";

  Categoria();

  Categoria.fromMap(Map snapshot,String id) :
        _id = id ?? '',
        _categoria = snapshot['categoria'] ?? '';

  toJson() {
    return {
      "categoria": _categoria,

    };
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