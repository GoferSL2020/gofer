


import 'package:flutter/material.dart';

class EquipoJugador {
  String id="";
  String equipo="";
  String pais="";
  bool lotiene=false;


  EquipoJugador({@required this.id, this.equipo});

  EquipoJugador.fromMap(Map snapshot,String id) :
        id = id ?? '',
        equipo= snapshot['equipo'] ?? '',
        pais = snapshot['pais'] ?? '';

  EquipoJugador.fromJson(this.id, Map obj) {
    id = this.id;
    // obj['_fis_envergadura']
    this.equipo = obj['equipo'];
    this.pais = obj['pais'];
  }
  toJson() {
    return {
      "equipo": equipo,
      "pais": pais
    };
  }

}