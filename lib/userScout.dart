import 'package:firebase_database/firebase_database.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/service/BBDDService.dart';

import 'modelo/equipoJugador.dart';
import 'modelo/pais.dart';

class UserScout {
  String _id;
  String _name;
  String _apellido;
  String _email;
  String _puesto;
  List<Pais> _paises=List();
  List<EquipoJugador> _equipos=List();

  UserScout(this._id, this._name, this._email, this._apellido,this._puesto);

  UserScout.fromJson(this._id, Map obj) {
    this._id = this._id;
    this._name = obj['nombre'];
    //this._email = obj['email'];
    this._puesto = obj['puesto'];
    this._apellido = obj['apellido'];
  }

    UserScout.map(dynamic obj){
      this._id = this._id;
    this._name = obj['nombre'];
    this._email = obj['email'];
    this._apellido = obj['apellido'];
    this._puesto = obj['puesto'];
  }

  UserScout.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['nombre'];
    _email = snapshot.value['email'];
    _puesto = snapshot.value['puesto'];
    _apellido = snapshot.value['apellido'];
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get puesto => _puesto;

  set puesto(String value) {
    _puesto = value;
  }

  String get apellido => _apellido;

  set apellido(String value) {
    _apellido = value;
  }


  List<Pais> get paises => _paises;

  set paises(List<Pais> value) {
    _paises = value;
  }


  List<EquipoJugador> get equipos => _equipos;

  set equipos(List<EquipoJugador> value) {
    _equipos = value;
  }

  bool tengoPais(String pais){
    if(BBDDService().getUserScout().puesto=="FootFeel")
      return true;
    print("PAIS:$pais");
    for(var p in _paises){
      print("MIPAIS:${p.pais}");
      if(p.pais==pais)
         return true;
    }
    return false;
  }

  bool tengoEquipo(String equipo){
    if(BBDDService().getUserScout().puesto=="FootFeel")
      return true;
    for(var e in _equipos){
      print("MIEquipo:${e.equipo}");
      if(e.equipo==equipo)
        return true;
    }
    return false;
  }

}
