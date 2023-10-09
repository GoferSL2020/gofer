class Categoria {
  String _id = "";
  String _categoria = "";
  String key = "";

  Categoria();

  Categoria.fromMap(Map snapshot, String id)
      : _id = id ?? '',
        _categoria = snapshot['categoria'] ?? '';

  toJson() {
    return {
      "categoria": _categoria,
    };
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
