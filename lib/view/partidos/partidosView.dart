import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/partidos/addPartido.dart';
import 'package:iadvancedscout/view/partidos/partidoCard.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';

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
        title: Text("IAScout -Partidos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: widget.jugador.getColor(),
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
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        tooltip: "Añadir un jugador",
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => Abajo(),
                ));
              },
            ),
          ],
        ),
      ),
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
