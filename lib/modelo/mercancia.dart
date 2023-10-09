class Mercancia {
  String _id = "";
  String _referenciaProducto = "";
  String _descripcion = "";
  String _fechaRecogido = "";
  String _plataforma = "";
  int _plataformaNumero = 0;
  String _fechaAlta = "";
  String _categoria = "";
  String _categoria2 = "";
  String _oficinaRecogido = "";
  int _oficinaNumero = 0;
  String key = "";

  Mercancia();

  Mercancia.fromMap(Map snapshot, String id)
      : _id = id ?? '',
        _referenciaProducto = snapshot['referenciaProducto'] ?? '',
        _descripcion = snapshot['descripcion'] ?? '',
        _categoria = snapshot['categoria'] ?? '',
        _categoria2 = snapshot['categoria2'] ?? '',
        _plataforma = snapshot['plataforma'] ?? '',
        _plataformaNumero = snapshot['plataformaNumero'] ?? '',
        _fechaRecogido = snapshot['fechaRecogido'] ?? '',
        _oficinaRecogido = snapshot['oficinaRecogido'] ?? '',
        _oficinaNumero = snapshot['oficinaNumero'] ?? '',
        _fechaAlta = snapshot['fechaAlta'] ?? '';

  toJson() {
    return {
      "referenciaProducto": _referenciaProducto,
      "descripcion": _descripcion,
      "plataforma": _plataforma,
      "plataformaNumero": _plataformaNumero,
      "categoria": _categoria,
      "categoria2": _categoria2,
      "oficinaNumero": _oficinaNumero,
      "oficinaRecogido": _oficinaRecogido,
      "fechaRecogido": _fechaRecogido,
      "fechaAlta": _fechaAlta,
    };
  }

  int get oficinaNumero => _oficinaNumero;

  set oficinaNumero(int value) {
    _oficinaNumero = value;
  }

  String get oficinaRecogido => _oficinaRecogido;

  set oficinaRecogido(String value) {
    _oficinaRecogido = value;
  }

  String get categoria2 => _categoria2;

  set categoria2(String value) {
    _categoria2 = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get fechaAlta => _fechaAlta;

  set fechaAlta(String value) {
    _fechaAlta = value;
  }

  String get plataforma => _plataforma;

  set plataforma(String value) {
    _plataforma = value;
  }

  String get fechaRecogido => _fechaRecogido;

  set fechaRecogido(String value) {
    _fechaRecogido = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  String get referenciaProducto => _referenciaProducto;

  set referenciaProducto(String value) {
    _referenciaProducto = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  int get plataformaNumero => _plataformaNumero;

  set plataformaNumero(int value) {
    _plataformaNumero = value;
  }
}
