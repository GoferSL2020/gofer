

class Scout {
  String _id;
  String _scout;

  Scout( this._scout); // Categoria(this._idCategoria, this._idCategoria, this._idPais, this._nombre,
 //     this._imagen);

  Scout.fromMap(Map snapshot,String id) :
        _id = id ?? '',
        _scout = snapshot['scout'] ?? '';

  toJson() {
    return {
      "scout": _scout,

    };
  }

  String get scout => _scout;

  set scout(String value) {
    _scout = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}