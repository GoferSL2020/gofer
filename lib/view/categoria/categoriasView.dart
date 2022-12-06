import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDCategoria.dart';
import 'package:iafootfeel/modelo/cantera.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/view/categoria/categoriaCard.dart';
import 'package:iafootfeel/wigdet/abajo.dart';

class CategoriasView extends StatefulWidget {
  final Pais pais;
  final EquipoJugador equipo;
  final bool menu;
  CategoriasView({@required this.pais,@required this.equipo,@required this.menu});

  @override
  _CategoriasViewState createState() => new _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  List<Categoria> categorias = new List<Categoria>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });
    setState(() {
      _cogerCategorias();
    });
    super.initState();
  }

  _cogerCategorias() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Categoria> datos;
    if(widget.pais.pais=="LALIGA")
    datos = await CRUDCategoria().fetchCategoriasTodas();
    else
      datos = await CRUDCategoria().fetchCategorias(widget.pais);
    setState(() {
      print("DATOS:${datos.length}");
      categorias = datos;
    });
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
                icon: new Image.asset(Config.icono),
                onPressed: () {},
              )),
        ],
        backgroundColor: Colors.black,
        title: Text("FootFeel- World",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Config.colorFootFeel)),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Abajo(),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              widget.pais.pais,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Visibility(
              visible: categorias.isNotEmpty,
              child: Flexible(
                child: ListView.builder(
                    itemCount: categorias.length,
                    itemBuilder: (buildContext, index) {
                      return CategoriaCard(
                          paisDetails: widget.pais,
                          equipo : widget.equipo,
                          categoria: categorias[index],
                          menu: widget.menu);
                    }),
              )),
        ]),
      ),
    );
  }
}
