import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/partidos/addPartido.dart';
import 'package:iadvancedscout/view/partidos/partidoCard.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:provider/provider.dart';

class PartidosView extends StatefulWidget {
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Jornada jornada;
  final Partido partido;

  PartidosView({
    @required this.temporada,
    @required this.pais,
    @required this.categoria,
    @required this.jornada,
    @required this.partido});
  @override
  _PartidosViewState createState() => new _PartidosViewState();
}

class _PartidosViewState extends State<PartidosView> {
  List<Partido> partido;
  
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDPartido();
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      color:Config.colorAPP,
                    ),
                    onPressed: () {
                      Partido partido=new Partido();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPartido(
                              partido: partido,
                              categoria: widget.categoria,
                              pais: widget.pais,
                              jornada: widget.jornada,
                              temporada: widget.temporada)));
                    },
                  ),
                ),
                Container(
                    width: 50,
                    child: IconButton(
                      icon:
                      new Image.asset(Config.icono),

                      onPressed: () {
                        //var a = singOut();
                        //if (a != null) {

                        //}
                      },
                    ))]
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAClub - Partidos",
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
                child:Text('${widget.categoria.categoria} Jornada: ${widget.jornada.jornada} - ${widget.jornada.fecha}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorAPP,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
              Expanded(
            child: StreamBuilder(
            stream: productProvider.getDataCollectionPartidos(widget.temporada, widget.pais,widget.categoria,widget.jornada),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                partido = snapshot.data.docs
                    .map((doc) => Partido.fromMap(doc.data(), doc.id))
                    .toList();
                return ListView.builder(
                  itemCount: partido.length,
                  itemBuilder: (buildContext, index) =>
                      PartidoCard(
                          categoria: widget.categoria,
                        pais: widget.pais,
                        temporada: widget.temporada,
                        jornada: widget.jornada,
                        partido: partido[index]),
                );
              } else {
                return Text('fetching');
              }
            }),
          )
        ]
         ),
      ),
    );
  }
}
