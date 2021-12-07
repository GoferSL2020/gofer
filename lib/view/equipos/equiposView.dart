import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/entredadorDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
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


  getMigrarEntrenador()  async {
    print("getMigrarEntrenador");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    EntrenadorDao dao=new EntrenadorDao();
    for(var doc in equipo) {
      print("${doc.equipo},${doc.categoria},${doc.temporada}");
      List<Entrenador> list2 =await dao.getEntrenadoresSolo(widget.categoria, doc);
      for (var i = 0; i < list2.length; i++) {
        print("${i}:${list2[i].entrenador},${list2[i].equipo},${list2[i]
            .categoria},${doc.id}");

    //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
     print("/temporadas/${widget.temporada.id}/"
         "paises/${widget.pais.id}/"
         "categorias/${widget.categoria.id}/"
         "equipos/${doc.id}/entrenadores");
        await _db.collection(""
            "/temporadas/${widget.temporada.id}/"
            "paises/${widget.pais.id}/"
            "categorias/${widget.categoria.id}/"
            "equipos/${doc.id}/entrenadores")
            .add(list2[i].toMap());
      }
    }
  }

  getMigrarJORNADAS()  async {
    print("getMigrarJORNADAS");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    EntrenadorDao dao=new EntrenadorDao();
    List<Partido> jornadas =await dao.getTodosJORNADAS(widget.categoria);
    for (var i = 0; i < jornadas.length; i++) {
      print("${i}:${jornadas[i].jornada},${jornadas[i].fecha},${jornadas[i].equipoCASA},${jornadas[i].equipoFUERA},${equipo[0].equipo}");
      print("/temporadas/${widget.temporada.id}/"
          "paises/${widget.pais.id}/"
          "categorias/${widget.categoria.id}/jornadas");
      //ponemos las jornadas
      var result  =await _db.collection(""
          "/temporadas/${widget.temporada.id}/"
          "paises/${widget.pais.id}/"
          "categorias/${widget.categoria.id}/jornadas")
          .add(jornadas[i].toMapJornada());
      List<Partido> partidos =await dao.getTodosPartidosJORNADAS(widget.categoria, jornadas[i].jornada);
      for (var i = 0; i < partidos.length; i++) {
        await _db.collection(""
            "/temporadas/${widget.temporada.id}/"
            "paises/${widget.pais.id}/"
            "categorias/${widget.categoria.id}/jornadas").doc(result.id).collection("partidos")
            .add(partidos[i].toMapPartido());
        }

      }
  }

  @override
  Widget build(BuildContext context) {
    //getMigrarEntrenador();
    //getJugaodes();
    //getMigrarJORNADAS();
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
        title: Text("IAScout -Equipos",
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
