import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/equipos/equiposView.dart';
import 'package:iadvancedscout/view/jornada/JornadaView.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';

class EquiposOpcionesViewAux extends StatefulWidget {
  final Temporada temporada;
  final Pais pais;
  final Categoria categoria;
  final Equipo equipo;
  EquiposOpcionesViewAux(
      {@required this.temporada,
      @required this.pais,
      @required this.categoria,
      @required this.equipo});
  @override
  _EquiposOpcionesViewAuxState createState() =>
      new _EquiposOpcionesViewAuxState();
}

class _EquiposOpcionesViewAuxState extends State<EquiposOpcionesViewAux> {
  List<Equipo> equipo;

  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDEquipo();
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            Container(
                width: 50,
                child: IconButton(
                  icon: new Image.network(
                    Config.escudoCategoria(widget.categoria.categoria),
                    height: 25,
                  ),
                  onPressed: () {
                    //var a = singOut();
                    //if (a != null) {

                    //}
                  },
                )),
          ],
          backgroundColor: Colors.black,
          title: Text("IAScout - Categoría",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Abajo(
          temporada: widget.temporada,
        ),
        body: Container(
            child: Column(children: <Widget>[
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text(
                  widget.temporada.temporada,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorAPP,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text(
                  widget.categoria.categoria,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorAPP,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EquiposView(
                                    temporada: widget.temporada,
                                    pais: widget.pais,
                                    categoria: widget.categoria,
                                  )));
                    },
                    title: Card(
                      shadowColor: Colors.black,
                      color: Config.colorCard,
                      elevation: 5,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: new Icon(
                                        CustomIcon.camiseta,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      "EQUIPOS",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>
                        JornadasView(temporada: widget.temporada, pais: widget.pais,categoria: widget.categoria,)));
                  },
                  title: Card(
                    shadowColor: Colors.black,
                    color: Config.colorCard,
                    elevation: 5,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 20),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        CustomIcon.futbolista_4,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => JornadasView(
                                                      temporada:
                                                          widget.temporada,
                                                      pais: widget.pais,
                                                      categoria:
                                                          widget.categoria,
                                                    )));
                                      }),
                                  Text(
                                    "PARTIDOS",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                /*  ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                EquipoContrarioView(temporada: widget.temporada, equipo: widget.equipo,)));

          },
          title: Card(shadowColor:   Colors.black,
            color: Config.colorCard,
            elevation: 5,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20,bottom: 20),
                      child:
                      Row(
                        children: [
                          IconButton(
                            icon: new Icon(
                              CustomIcon.futbolista_4,size: 25,color: Colors.black,
                            ),onPressed:() {},
                          ),
                          Text("CONTRARIOS",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],)
                  ),
                ],
              ),
            ),
          )),*/
              ],
            ),
          )
        ])));
  }
}
