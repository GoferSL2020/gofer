
import 'dart:async';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/service/db.dart';

class PaisDao {
  DB con = new DB();

//insertion
  Future<int> savePais(Pais pais) async {
    var dbClient = await  con.db;
    int res = await dbClient.insert("PAIS", pais.toMap());
    return res;
  }
  //deletion
  Future<int> deletePais(String pais) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM PAIS WHERE PAIS = ?', [pais]);
    return res;
  }
  Future<Pais> checkPais(String pais) async {
    var dbClient = await  con.db;
    var res = await dbClient.rawQuery("SELECT * FROM PAIS WHERE PAIS = '$pais'");

    if (res.length > 0) {
      return new Pais.fromMap(res.first);
    }
    return null;
  }
  Future<List<Pais>> getAllPais() async {
    var dbClient = await con.db;
    var res = await dbClient.query("PAIS");

    List<Pais> list =
    res.isNotEmpty ? res.map((c) => Pais.fromMap(c)).toList() : null;
    //print("${res}");

    return list;
  }
}