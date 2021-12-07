import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDJornada.dart';
import 'package:iadvancedscout/modelo/categoria.dart';

import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/jornada/editJornada.dart';
import 'package:iadvancedscout/view/jornada/jornadaCard.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';

class JornadasView extends StatefulWidget {
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;


  JornadasView({@required this.categoria,@required this.temporada,@required this.pais});
  @override
  _JornadasViewState createState() => new _JornadasViewState();
}

class _JornadasViewState extends State<JornadasView> {
  List<Jornada> jornadas;
  
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dao = new CRUDJornada();
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
                      Jornada jornada= new Jornada(0,"");
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditJornada(
                              temporada: widget.temporada,
                              pais: widget.pais,
                              categoria: widget.categoria,
                              jornada: jornada,
                          )));

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
        title: Text("IAScout -Jornada",
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
            stream: dao.getDataCollectionJornadas(widget.temporada, widget.pais,widget.categoria),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                jornadas = snapshot.data.docs
                    .map((doc) => Jornada.fromMap(doc.data(), doc.id))
                    .toList();
                return ListView.builder(
                  itemCount: jornadas.length,
                  itemBuilder: (buildContext, index) =>
                      JornadaCard(temporada: widget.temporada,pais: widget.pais,categoria: widget.categoria,jornada: jornadas[index],),
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
