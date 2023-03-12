


import 'package:flutter/material.dart';

class EquipoJugador {
  String id="";
  String equipo="";
  String pais="";
  bool lotiene=false;

  EquipoJugador();
  EquipoJugador.fromMap(dynamic snapshot,String id) :
        id = id ?? '',
        equipo= snapshot!['equipo'] ?? '',
        pais = snapshot!['pais'] ?? '';

  EquipoJugador.fromJson(this.id, dynamic obj) {
    id = this.id;
    // obj['_fis_envergadura']
    this.equipo = obj!['equipo'];
    this.pais = obj!['pais'];
  }
  toJson() {
    return {
      "equipo": equipo,
      "pais": pais
    };
  }

}