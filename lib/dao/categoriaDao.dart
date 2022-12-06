
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:iafootfeel/model/categoria.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/service/db.dart';

class CategoriaDao {
  DB con = new DB();

//insertion
  Future<int> saveCategoria(Categoria equipo) async {
    var dbClient = await  con.db;
    int res = await dbClient.insert("CATEGORIA", equipo.toMap());
    return res;
  }
  //deletion
  Future<int> deleteCategoria(String equipo) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM CATEGORIA WHERE CATEGORIA = ?', [equipo]);
    return res;
  }
  Future<Categoria> checkCategoria(String equipo) async {
    var dbClient = await  con.db;
    var res = await dbClient.rawQuery("SELECT * FROM CATEGORIA WHERE CATEGORIA = '$equipo'");

    if (res.length > 0) {
      return new Categoria.fromMap(res.first);
    }
    return null;
  }
   getAllCategoria(String pais) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM CATEGORIA WHERE PAIS = '$pais'");
    //print("getAllCategoria");
    List<Categoria> list =
    res.isNotEmpty ? res.map((c) => Categoria.fromMap(c)).toList() : [];
    //print(list);
    return list;

    /*final db = await database;
    //print(db);
    var res = await db.query("PALABRAS");
    List<MIPalabra> list =
    res.isNotEmpty ? res.map((c) => MIPalabra.fromMap(c)).toList() : [];
    return list;*/
  }

  addCategoriaIAScout(Categoria _categoria) async {
    String path="temporadas/${BBDDService().getUserScout().puesto}/pais/${_categoria.pais}/categorias/${_categoria.categoria}";

    //String path2="temporadas/2021-2022/pais/${_jugador.pais}/categorias/${_jugador.categoria}/equipo/${_jugador.equipo}/jugadores/${_jugador.id}";
    // Write a message to the database
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path);
    dbRef.set({
      "categoria":  _categoria.categoria,
      "imagen":  _categoria.imagen,
    }).then((res) {
      //print('Transaction  committed.');
    }).catchError((err) {
      //print(err);
    });
  }
}
