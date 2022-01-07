import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';

class PartidoJugadores {
  Partido _partido;
  List<Player> _jugadores;
  int _jornada=0;
  Partido get partido => _partido;

  set partido(Partido value) {
    _partido = value;
  }

  List<Player> get jugadores => _jugadores;

  set jugadores(List<Player> value) {
    _jugadores = value;
  }

  int get jornada => _jornada;

  set jornada(int value) {
    _jornada = value;
  }
}