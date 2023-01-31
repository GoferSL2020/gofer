

class Jornada {
  String _id;
  int _jornada;
  String _fecha;

  Jornada( this._jornada, this._fecha); // Categoria(this._idCategoria, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);


  Jornada.fromMap(Map snapshot,String id) :
        _id = id ?? '',
        _fecha= snapshot['fecha'] ?? '',
        _jornada = snapshot['jornada'] ?? '';

  toJson() {
    return {
      "jornada": _jornada,
      "fecha": _fecha,

    };
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

  int get jornada => _jornada;

  set jornada(int value) {
    _jornada = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}