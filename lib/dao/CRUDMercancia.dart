import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gls/modelo/categoria.dart';
import 'package:gls/modelo/mercancia.dart';


class CRUDMercancia extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference ref;

  CRUDMercancia.internal();

  late List<Mercancia> productos;


  Future<List<Mercancia>> fetchMercancia(Categoria categoria) async {
    var result =
    await _db.collection("productos").where("categoria", isEqualTo: categoria.categoria).get();
    productos = result.docs
        .map((doc) => Mercancia.fromMap(doc.data(), doc.id))
        .toList();
    return productos;
  }

  Future<List<Mercancia>> fetchMercanciasRecogidoOficina(int codigo) async {
    var result =
    await _db.collection("productos").where("oficinaNumero", isEqualTo: codigo).get();
    productos = result.docs
        .map((doc) => Mercancia.fromMap(doc.data(), doc.id))
        .toList();
    return productos;
  }

  Future<List<Mercancia>> fetchProductosRecogidoPlataforma() async {
    var result =
    await _db.collection("productos").where("oficinaNumero", isNotEqualTo: 0).get();
    productos = result.docs
        .map((doc) => Mercancia.fromMap(doc.data(), doc.id))
        .toList();
    return productos;
  }



  Future<List<Mercancia>> fetchMercanciasRecogido() async {
    var result =
    await _db.collection("productos").where("fechaRecogido", isNotEqualTo: "").get();
    productos = result.docs
        .map((doc) => Mercancia.fromMap(doc.data(), doc.id))
        .toList();
    return productos;
  }



  Future<bool> estaElProducto(String id) async {
    var result =
    await _db.collection("productos").where("referenciaProducto", isEqualTo: id).get();
    if(result.size>0)
      return true;
    else
      return false;
  }


  Stream<QuerySnapshot>? getDataCollectionMercancias(Categoria categoria) {
     _db.collection("productos").where("categoria", isEqualTo: categoria.categoria).snapshots();
  }




  Future removeMercancia(Mercancia mercancia) async{
    await _db.collection("productos").doc(mercancia.id).delete() ;
    return ;
  }
  Future updateMercancia(Mercancia mercancia) async{
    await _db.collection("productos").doc(mercancia.id).update(mercancia.toJson());
    return ;
  }

  Future addMercancia(Mercancia mercancia) async{
    var result  = await _db.collection("productos").add(mercancia.toJson()) ;
    return result.id;

  }



}
