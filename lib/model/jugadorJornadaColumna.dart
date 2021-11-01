import 'dart:typed_data';
import 'dart:io';

import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class JugadorJornadaColumna {
  String _id;
  int  _jornada;
  int  _puntuaciones;

  String _jugador;
  String _posicion;
  String _equipo;

  int _DTG;
  int _MCB;
  int _MSB;
  int _CFG;
  int _SH;

  int _estrella=0;

  JugadorJornadaColumna(
      this._puntuaciones,this._jornada, this._jugador, this._posicion, this._equipo,
      this._DTG, this._MCB, this._MSB, this._CFG, this._SH,this._estrella);




  Map<String, dynamic> toGsheets(int jornada,int puntuaciones,int row) {
    DateTime today = new DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    String punt="";
    if(row==-1) row=1;
    if (_puntuaciones==11) {
      punt = "NA";
    }
    else if (_puntuaciones==12) {
      punt = "SC";
    }
    else punt=_puntuaciones.toString();

    return {
      "_id" :_id,
      "_jugador" : _jugador,
      "_posicion" : _posicion,
      "_equipo" : _equipo,
      "_J${jornada.toString()}" : punt,
      "promedio" : "=SI.ERROR(PROMEDIO(F${row}:BE${row});0)",
      "total" :  "=SUMA(F${row}:BE${row})",
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


  String get id {
    return (_jugador+_posicion).toUpperCase()
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


  int get jornada => _jornada;

  set jornada(int value) {
    _jornada = value;
  }

  String get posicion => _posicion;

  set posicion(String value) {
    _posicion = value;
  }

  JugadorJornadaColumna.name(
      this._id,
      this._jugador,
      this._posicion,
      this._equipo,
    this._jornada,
    this._puntuaciones,
    this._DTG,
    this._MCB,
    this._MSB,
    this._CFG,
    this._SH,
  );

  int get puntuaciones => _puntuaciones;

  set puntuaciones(int value) {
    _puntuaciones = value;
  }

  int get DTG => _DTG;

  set DTG(int value) {
    _DTG = value;
  }

  int get MCB => _MCB;

  set MCB(int value) {
    _MCB = value;
  }

  int get MSB => _MSB;

  set MSB(int value) {
    _MSB = value;
  }

  int get CFG => _CFG;

  set CFG(int value) {
    _CFG = value;
  }

  int get SH => _SH;

  set SH(int value) {
    _SH = value;
  }

  int get estrella => _estrella;

  set estrella(int value) {
    _estrella = value;
  }
}
