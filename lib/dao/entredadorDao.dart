import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iadvancedscout/icon_mio_icons.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/service/db.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/gsheetsSCOUT.dart';
import 'package:firebase_database/firebase_database.dart';
final FirebaseFirestore _db = FirebaseFirestore.instance;

class EntrenadorDao {
  DB con = new DB();
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;
  DatabaseReference _counterRef;
//insertion

  getTodosEntrenadores() async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM ENTRENADOR  ORDER BY ENTRENADOR.ENTRENADOR");

    List<Entrenador> list =
    res.isNotEmpty ? res.map((c) => Entrenador.fromMap(c)).toList() : [];
    return list;
  }

  getEntrenadoresSolo(Categoria categoria, Equipo equipo) async {
    print("getEntrenadoresSolo");
    print(categoria.categoria);
    print(equipo.equipo);
    var dbClient = await con.db;
    String sql="SELECT * FROM ENTRENADOR "
        " where EQUIPO='${equipo.equipo}' and CATEGORIA like  '%2ª División A%'";
    print(sql);
    var res = await dbClient.rawQuery(sql);

    List<Entrenador> list =
    res.isNotEmpty ? res.map((c) => Entrenador.fromMap(c)).toList() : [];
    print(list.length);


    return list;
  }

  getEntrenadoresSoloEquipo(String equipo) async {
    print("getEntrenadoresSolo");
    var dbClient = await con.db;
    String sql="SELECT * FROM ENTRENADOR "
        " where EQUIPO='${equipo}'";
    print(sql);
    var res = await dbClient.rawQuery(sql);

    List<Entrenador> list =
    res.isNotEmpty ? res.map((c) => Entrenador.fromMap(c)).toList() : [];
    print(list.length);


    return list;
  }

  getTodosPartidosJORNADAS(Categoria categoria, int jornada) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JORNADAS "
        " where CATEGORIA='${categoria.categoria}'  and "
        " JORNADA =$jornada "
        " ORDER BY JORNADAS.JORNADA");

    List<Partido> list =
    res.isNotEmpty ? res.map((c) => Partido.fromMapBBDD(c)).toList() : [];
    return list;
  }

  getTodosJORNADAS(Categoria categoria) async {
    print("getTodosJORNADAS:${categoria.categoria}");
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT *  FROM JORNADAS "
        " ORDER BY JORNADAS.JORNADA");

    List<Partido> list =
    res.isNotEmpty ? res.map((c) => Partido.fromMapBBDD(c)).toList() : [];
    print(list.length);

    return list;
  }



}



