class UserOficina {
  String? _id;
  String? _nombre;
  String? _lugar;
  String? _email;
  int? _numeroOficina;
  bool? _plataforma;

  UserOficina(this._id, this._nombre, this._email, this._lugar,
      this._numeroOficina, this._plataforma);

  UserOficina.fromJson(this._id, Map obj) {
    this._id = this._id;
    this._nombre = obj['nombre'];
    this._email = obj['email'];
    this._lugar = obj['lugar'];
    this._numeroOficina = obj['numeroOficina'];
    this._plataforma = obj['plataforma'];
  }

  UserOficina.map(dynamic obj) {
    this._id = this._id;
    this._nombre = obj['nombre'];
    this._email = obj['email'];
    this._lugar = obj['lugar'];
    this._numeroOficina = obj['numeroOficina'];
    this._plataforma = obj['plataforma'];
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  String get lugar => _lugar!;

  set lugar(String value) {
    _lugar = value;
  }

  String get nombre => _nombre!;

  set nombre(String value) {
    _nombre = value;
  }

  String get id => _id!;

  set id(String value) {
    _id = value;
  }

  bool get plataforma => _plataforma!;

  set plataforma(bool value) {
    _plataforma = value;
  }

  int get numeroOficina => _numeroOficina!;

  set numeroOficina(int value) {
    _numeroOficina = value;
  }
}
