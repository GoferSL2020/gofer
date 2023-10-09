import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gls/conf/config.dart';
import 'package:gls/dao/CRUDCategoria.dart';
import 'package:gls/modelo/categoria.dart';

import 'package:gls/view/categoria/categoriaCard.dart';
import 'package:gls/wigdet/abajo.dart';

class CategoriasView extends StatefulWidget {
  final bool subir;
  final String sitio;
  CategoriasView(this.subir,this.sitio);

  @override
  _CategoriasViewState createState() => new _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  List<Categoria> categorias = <Categoria>[];
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
    datos = await CRUDCategoria().fetchCategoriasTodas();
    setState(() {
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
        backgroundColor: Config.fondo,
        title: Text("GLS - Categorias",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Config.letras)),
        elevation: 0,
        centerTitle: true,

      ),
      bottomNavigationBar: Abajo(),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            height: 30,
            color: Config.fondo,
            child: Text(
              "${widget.sitio}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Config.letras,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            color:Config.fondo,
            child: Text(
              "Lista de las categorias",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Config.letras,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),

          Visibility(
              visible: categorias.isNotEmpty,
              child: Flexible(
                child: ListView.builder(
                    itemCount: categorias.length,
                    itemBuilder: (buildContext, index) {
                      return CategoriaCard(widget.subir,
                          categorias[index],widget.sitio);
                    }),
              )),
        ]),
      ),
    );
  }
}
