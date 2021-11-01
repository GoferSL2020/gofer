import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/categoriaDao.dart';
import 'package:iadvancedscout/dao/equipoDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/categorias.dart';

import 'package:iadvancedscout/view/equipos.dart';
import 'package:iadvancedscout/view/equiposList.dart';
import 'package:iadvancedscout/view/jugadores.dart';
import 'package:iadvancedscout/view/paises.dart';
import 'package:iadvancedscout/view/tabPuntacionesJornadas.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import 'equiposList.dart';

class EquiposPage extends StatefulWidget {
  const EquiposPage(this._categoria);

  @override
  _EquiposPageState createState() => _EquiposPageState();
  final Categoria _categoria;
}

class _EquiposPageState extends State<EquiposPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "jugadores";
  List<Equipo> equiposList = <Equipo>[];


  getEquipo() {
    equiposList.clear();
    _database.reference()
        .child('temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._categoria.pais}/categorias/${widget._categoria.categoria}/equipos')
        .once()
        .then((DataSnapshot snapshotResult) {
      if (snapshotResult == null || snapshotResult.value == null) return;
      Map<dynamic, dynamic> paisesMap = snapshotResult.value;
      paisesMap.forEach((key, value) {
        //print("EQUIPOS:${value}");
        //print("KEY:${key}");

        equiposList.add(Equipo.fromJson(key, value));
      });
    });
  }



  @override
  void initState() {
    nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises/${widget._categoria.pais}/categorias/${widget._categoria.categoria}/equipos";
    //print(nodeName);
   /* setState(() {
      getEquipo();

    });*/
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
 //   _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
 //   _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(actions: <Widget>[
        IconButton(
          icon: new Image.asset(Config.icono),onPressed: () {
          //var a = singOut();
          //if (a != null) {

          Navigator.of(context).pop();

          Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => TemporadasPage(),
          ));

          //}
        },
        )
      ],
        backgroundColor:Colors.black,
        title: Text("IAScout - Equipos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: equiposList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Container(color:Colors.black,
                padding: EdgeInsets.all(1.0),
                child: Texto(Colors.white,"${widget._categoria.categoria}".toUpperCase()
                    ,14, Colors.black, false)),
            Container(color:Colors.black,
                padding: EdgeInsets.all(1.0),
                child: Texto(Colors.red,"${BBDDService().getUserScout().temporada}".toUpperCase()
                    ,14, Colors.black, false)),

            dataBody2(),
            //dataBody(),
          ],
        ),
      ),
    /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) =>AddEquipo()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        tooltip: "add a post",
      ),*/
    );
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(headingRowHeight:0,dataRowHeight: 55,
        columns: [
          DataColumn(label: Text('')),
          //DataColumn(label: Text('Action')),
        ],
        rows:
        equiposList // Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(
                Container(
                  padding: EdgeInsets.all(2.0),
                  child: new RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      onPressed: ()  async {

                       /* Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => CategoriasPage(element),
                        ));*/

                      },
                      child: Column(children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: new Text(
                                element.equipo.toString(),
                                style: TextStyle(

                                  // fontWeight: FontWeight.bold,
                                    fontSize: 15.0),textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(),
                            new Image.asset('${element.equipo}', height: 25.0, width: 25.0),
                          ],
                        ),
                      ]),
                      textColor: Colors.black,
                      color: Colors.white),
                ),
              )],
          )),
        )
            .toList(),
      ),
    );
  }

  Visibility dataBody2(){
    return  Visibility(
      visible: equiposList.isNotEmpty,
      child: Flexible(
          child: FirebaseAnimatedList(
              query: _database.reference().child(nodeName),
              itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                //print("${snap}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: new RaisedButton(
                        elevation: 0.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        onPressed: ()  async {
                          Equipo equipo=new Equipo(equiposList[index].equipo,widget._categoria.categoria, widget._categoria.pais,null);
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => JugadoresPage(equipo),
                          ));


                        },
                        child: Column(children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //e%CC%81 é
                              //o%CC%81 é
                              //a%CC%81 a
                              //u%CC%81 u
                              //o%CC%81 o
                             // https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2FA%CC%81guilas.png?alt=media&token=f87a8a15-7a85-489f-9d34-fa8ee9edcb94
                              //https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2FCornella%CC%80.png?alt=media&token=ab162f7d-c191-4aeb-9fde-89274adf0ffc
                              // https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2FUD%20Logron%CC%83e%CC%81s.png?alt=media
                              new Image.network(Config.escudo(snap.value['equipo']),
                                  height:25),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: new Text(
                                  "${snap.value['equipo']}",
                                  style: TextStyle(

                                    // fontWeight: FontWeight.bold,
                                      fontSize: 15.0),textAlign: TextAlign.center,
                                ),),
                              Spacer(),
                              FlatButton(
                                onPressed: ()  {
                                  setState(() {
                                    Equipo equipo=new Equipo(equiposList[index].equipo,widget._categoria.categoria, widget._categoria.pais,null);
                                    Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) => TabPuntacionesJornadas(equipo),
                                    ));
                                  });
                                },
                                padding: EdgeInsets.all(10.0),
                                child: Row( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(Icons.app_registration,
                                      color: Colors.blue[900],),
                                  ],
                                ),
                              ),],
                          ),
                        ]),
                        textColor: Colors.black,
                        color: Colors.white),
                  ),
                );
              })),
    );
  }
  _childAdded(Event event) {
    setState(() {
      equiposList.add(Equipo.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    //print("_childRemoves");
    var deletedPost = equiposList.singleWhere((post){
      return post.pais == event.snapshot.key;
    });

    setState(() {
      equiposList.removeAt(equiposList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = equiposList.singleWhere((post){
      return post.pais == event.snapshot.key;
    });

    setState(() {
      equiposList[equiposList.indexOf(changedPost)] =Equipo.fromSnapshot(event.snapshot);
    });
  }
}
