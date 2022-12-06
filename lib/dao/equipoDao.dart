
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:iafootfeel/model/equipo.dart';
import 'package:iafootfeel/model/jugador.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/service/db.dart';
import 'package:firebase_database/firebase_database.dart';

class EquipoDao {
  DB con = new DB();

//insertion
  Future<int> saveEquipo(Equipo equipo) async {
    var dbClient = await  con.db;
    int res = await dbClient.insert("EQUIPO", equipo.toMap());
    return res;
  }
  //deletion
  Future<int> deleteEquipo(String equipo) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM EQUIPO WHERE EQUIPO = ?', [equipo]);
    return res;
  }
  Future<Equipo> checkEquipo(String equipo) async {
    var dbClient = await  con.db;
    var res = await dbClient.rawQuery("SELECT * FROM EQUIPO WHERE EQUIPO = '$equipo'");

    if (res.length > 0) {
      return new Equipo.fromMap(res.first);
    }
    return null;
  }
  getAllEquipo(String pais, String categoria) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM EQUIPO WHERE PAIS = '$pais' and CATEGORIA='$categoria' ORDER BY EQUIPO");
    List<Equipo> list =
    res.isNotEmpty ? res.map((c) => Equipo.fromMap(c)).toList() : [];
    //updateEquipo(list[0]);
    //for (var i=0;i<list.length;i++)
      //updateEquipo(list[i]);
    return list;
  }

  getAllEquipoTodos(String pais) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM EQUIPO WHERE PAIS = '$pais'  ORDER BY EQUIPO");
    List<Equipo> list =
    res.isNotEmpty ? res.map((c) => Equipo.fromMap(c)).toList() : [];
    //updateEquipo(list[0]);
    //for (var i=0;i<list.length;i++)
    //updateEquipo(list[i]);
    return list;
  }

  addEquipoIAScout(Equipo _equipo) async {
    String path="temporadas/${BBDDService().getUserScout().puesto}/pais/${_equipo.pais}/categorias/${_equipo.categoria}/equipos/${_equipo.equipo}";

    //String path2="temporadas/2021-2022/pais/${_jugador.pais}/categorias/${_jugador.categoria}/equipo/${_jugador.equipo}/jugadores/${_jugador.id}";
    // Write a message to the database
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path);
    dbRef.set({
      "equipo":  _equipo.equipo,
      "imagen":  _equipo.imagen,
    }).then((res) {
      //print('Transaction  committed.');
    }).catchError((err) {
      //print(err);
    });
  }



}