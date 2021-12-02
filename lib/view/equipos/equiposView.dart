import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';

import 'package:iadvancedscout/view/equipos/equipoCardAux.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:provider/provider.dart';

class EquiposView extends StatefulWidget {
  final Temporada temporada;
  final Pais pais;
  final Categoria categoria;

  EquiposView({@required this.pais, @required this.temporada,@required this.categoria});
  @override
  _EquiposViewState createState() => new _EquiposViewState();
}

class _EquiposViewState extends State<EquiposView> {
  List<Equipo> equipo;
  
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
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
                icon:
                new Image.network(
                  Config.escudoCategoria(widget.categoria.categoria),height: 25,
                ),
                onPressed: () {
                  //var a = singOut();
                  //if (a != null) {

                  //}
                },
              )),
        ],
        backgroundColor: Colors.black,
        title: Text("IAClub - Equipos",
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
            child: StreamBuilder(
            stream: productProvider.getDataCollectionEquipos(widget.temporada,widget.pais,widget.categoria),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                equipo = snapshot.data.docs
                    .map((doc) => Equipo.fromMap(doc.data(), doc.id))
                    .toList();

                return ListView.builder(
                  itemCount: equipo.length,
                  itemBuilder: (buildContext, index) =>
                      EquipoCardAux(temporada: widget.temporada, equipoDetails: equipo[index],categoria: widget.categoria,pais:widget.pais),
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
