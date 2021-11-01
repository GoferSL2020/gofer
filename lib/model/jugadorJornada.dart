import 'dart:typed_data';
import 'dart:io';

import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class JugadorJornada {
  int _puntuacion;
  int _estrella;
  String _fecha;
   String _id;
  int  _jornada;
  String _jugador;
  String _posicion;
  String _equipo;
  String _equipoContrario;
  String _fechaNacimiento;
  String _casaFuera;
  String _categoria;
  String key;


  JugadorJornada(this._puntuacion, this._fecha,
      this._jornada, this._jugador, this._posicion, this._equipo, this._casaFuera, this._equipoContrario, this._estrella,this._fechaNacimiento);

  JugadorJornada.fromJson(this.key, Map obj) {
    this._categoria = obj['categoria'];
    this._equipo = obj['equipo'];
    this._fecha = obj['fecha'];
    this._jugador = obj['jugador'];
    this._estrella = obj['estrella'];
    this._puntuacion = obj['puntuacion'];
    this._categoria = obj['categoria'];
    this._jornada = obj['jornada'];
    this._posicion = obj['posicion'];
    this._fechaNacimiento = obj['fechaNacimiento'];
  }

  Map<String, dynamic> toGsheets() {
    DateTime today = new DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";

    return {
      "_id" :_id,
      "_jornada" : _jornada,
      "_jugador" : _jugador,
      "_posicion" : _posicion,
      "_fecha" : _fecha,
      "_equipo" : _equipo,
      "_casaFuera": _casaFuera,
      "_equipoContrario" : _equipoContrario,
      "_puntuacion" : _puntuacion,
      "_estrella" : _estrella,
      "nombre" : BBDDService().getUserScout().name,
      "email" : BBDDService().getUserScout().email,
      "fecha" : dateSlug
    };
  }

  String get equipo => _equipo;

  set equipo(String value) {
    _equipo = value;
  }

  String get jugador => _jugador;

  set jugador(String value) {
    _jugador = value;
  }

  int get jornada => _jornada;

  set jornada(int value) {
    _jornada = value;
  }

  String get id {
    return (_jornada.toString()+_jugador+_equipo).toUpperCase()
        .replaceAll(" ", "")
        .replaceAll("É", "E")
        .replaceAll("Í", "I")
        .replaceAll("Ó", "O")
        .replaceAll("Ú", "U")
        .replaceAll("Á", "A")
        .replaceAll(".", "")
        .replaceAll("Ñ", "N");
  }


  set id(String value) {
    _id = value;
  }


  String get equipoContrario => _equipoContrario;

  set equipoContrario(String value) {
    _equipoContrario = value;
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

  int get puntuacion => _puntuacion;

  set puntuacion(int value) {
    _puntuacion = value;
  }

  String get posicion => _posicion;

  set posicion(String value) {
    _posicion = value;
  }

  String get casaFuera => _casaFuera;

  set casaFuera(String value) {
    _casaFuera = value;
  }

  int get estrella => _estrella;

  set estrella(int value) {
    _estrella = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(String value) {
    _fechaNacimiento = value;
  }


}