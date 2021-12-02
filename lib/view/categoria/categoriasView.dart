import 'dart:async';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDPais.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/categoria/categoriaCard.dart';
import 'package:iadvancedscout/view/pais/paisCard.dart';
import 'package:iadvancedscout/view/temporada/temporadaCard.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';


class CategoriasView extends StatefulWidget {
  final Temporada temporada;
  final Pais pais;

  CategoriasView({@required this.temporada,@required this.pais});

  @override
  _CategoriasViewState createState() => new _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  List<Categoria> categorias;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final dao = new CRUDCategoria();

    return new Scaffold(
        key: _scaffoldkey,
        appBar: new AppBar(
          actions: <Widget>[
            Container(
                    width: 50,
                    child: IconButton(
                      icon: new Image.asset(Config.icono),onPressed: () {},

                    )),
          ],
          backgroundColor: Colors.black,
          title: Text("IAScout - Categorias",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
      bottomNavigationBar: Abajo(temporada: widget.temporada,),
      body:
      Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text(
                  widget.temporada.temporada,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorCard,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
              Expanded(
                child: StreamBuilder(
                    stream:  dao.getDataCollectionCategorias(widget.temporada, widget.pais),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        categorias = snapshot.data.docs
                            .map((doc) => Categoria.fromMap(doc.data(), doc.id))
                            .toList();

                        return ListView.builder(
                          itemCount: categorias.length,
                          itemBuilder: (buildContext, index) =>
                              CategoriaCard(temporada: widget.temporada,paisDetails: widget.pais, categoria: categorias[index]),
                        );
                      } else {
                        return Text('fetching');
                      }
                    }),
              ),
            ]
        ),
      ),
    );
  }
}
