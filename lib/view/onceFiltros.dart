import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/categoriaDao.dart';
import 'package:iadvancedscout/dao/equipoDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/pdf/PdfPreviewScreen.dart';
import 'package:iadvancedscout/pdf/pdfJugadorDatos.dart';
import 'package:iadvancedscout/pdf/pdfPartido.dart';

import 'package:iadvancedscout/view/addJugador.dart';
import 'package:iadvancedscout/view/caracteristicas/tabCaracteristicas.dart';

import 'package:iadvancedscout/view/editJugador.dart';

import 'package:iadvancedscout/view/paises.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import 'jugadoresList.dart';

class OnceFiltroPage extends StatefulWidget {
  const OnceFiltroPage(this._categoria, this._jornada, this._temporada);

  @override
  _OnceFiltroPageState createState() => _OnceFiltroPageState();
  final String _categoria;
  final String _jornada;
  final String _temporada;
}

class _OnceFiltroPageState extends State<OnceFiltroPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "";
  List<JugadorJornada> jugadoresList=new List<JugadorJornada>();

// no need of the file extension, the name will do fine.



    @override
  void initState() {
    //print(widget._jornada);
    //print(widget._categoria);
      jugadoresList.clear();
    nodeName = "jornadas/${widget._temporada}";
   /* setState(() {
   //   getJugador();

    });*/
     //getJugadores();
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    // _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  /*getJugadores() async {
    List<JugadorJornada> jugadoresListAux = new List<JugadorJornada>();

    FirebaseDatabase _database = FirebaseDatabase.instance;
    String nodeName = "jornadas/2021-2022";
     _database.reference()
        .child('jornadas/2021-2022')
        .once()
        .then((DataSnapshot snapshotResult) {
     // print("DSDDDD:${snapshotResult.value}");
      if (snapshotResult == null || snapshotResult.value == null) return;
      Map<dynamic, dynamic> auxMap = snapshotResult.value;
      //print("MAP:${auxMap}");
      //print("MAPKEY:${auxMap.keys}");
      auxMap.forEach((key, value) async {
        _database.reference()
            .child('jornadas/2021-2022/${key}')
            .once()
            .then((DataSnapshot snapshotResult2) {
          //print("aaaaaDD:${snapshotResult2.value}");
          if (snapshotResult2 == null || snapshotResult2.value == null) return;
          Map<dynamic, dynamic> auxMap2 = snapshotResult2.value;
          //print("MAPKEY:${auxMap2.keys}");
         // print("MAP222:${auxMap2}");
          auxMap2.forEach((key, value) {
            Map<dynamic, dynamic>  auxMap3 = value[1];
            //print("VALUE2${auxMap3}");
            jugadoresListAux.add(JugadorJornada.fromJson(key, auxMap3));
            //print(jugadoresListAux.length);
          });
        });
        //rootRef.child('users').orderByChild('email').equalTo('alice@email.com')
      });
    });
    setState(() {
      jugadoresList=jugadoresListAux;
      print(jugadoresListAux.length);
      //print(jugadoresList.length);
    });

  }*/

    @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),
            onPressed: () {
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
        backgroundColor: Colors.black,
        title: Text("IAScout - Jugadores",
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
            /*Visibility(
              visible: jugadoresList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),*/
            Container(
                alignment: Alignment.center,
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child:Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Texto(Colors.white, "${widget._categoria==null?"":widget._categoria} - Jornada: ${widget._jornada==null?"":widget._jornada} (${jugadoresList.length})",
                              14, Colors.black, false),
                          IconButton(
                              icon: new Icon(MyFlutterApp.file_pdf,size: 20,),
                              color: Colors.red[900],
                              onPressed: ()
                              async {

                                await pdfJugador(context);

                              }),
                        ]))
            ),


            Visibility(
              visible: jugadoresList.isNotEmpty,
              child: Flexible(
                  child:
                       ListView.builder(
                      itemCount: jugadoresList.length,
                      itemBuilder: (context, index) {
                        return
                          ListTile(
                            onTap: () {
                            },
                            title: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                children: [
                                  //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                  Text(
                                    "${jugadoresList[index].jugador}"
                                    ,
                                    style: TextStyle(
                                        color:Config.edadColorSub(Config.edadSub(jugadoresList[index].fechaNacimiento)),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  Text(
                                    jugadoresList[index]
                                        .equipo
                                    ,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),


                                ]),
                            subtitle:
                              Column(
                              children: <Widget>[
                                Container(height: 5),
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                    children: [
                                      Text(
                                        jugadoresList[index].posicion,
                                        style: TextStyle(
                                            fontSize: 10.0, color: Colors.blue[900]),
                                      ),

                                  ],),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.end ,
                                  children: [
                                    Text(
                                      Config.edadSub( jugadoresList[index].fechaNacimiento),
                                      style: TextStyle(
                                          color:Config.edadColorSub(Config.edadSub(jugadoresList[index].fechaNacimiento)),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],),
                                Container(height: 5),
                                Container(height: 1, color: Colors.grey),
                                Container(height: 5),
                                ]
                              ),

                          );
                      },
                       )),
            )
            //dataBody(),
          ],
        ),
      ),
    );
  }




  void pdfJugador(BuildContext context) {
      PDFPartido pdf= PDFPartido(jugadores: jugadoresList);
      pdf.generateInvoice();
  }

  _childAdded(Event event) {
    List<JugadorJornada> jugadoresListAux = new List<JugadorJornada>();
    setState(() {
            Map<dynamic, dynamic> auxMap2 = event.snapshot.value;
            auxMap2.forEach((key, value) {
                List<dynamic>  auxMap3 = value;
               // print("ESTRELLA:${value2["estrella"]}");
                  if (auxMap3.elementAt(1)["estrella"] != null) {
                    print(widget._jornada);
                    print(widget._categoria);
                    print(auxMap3.elementAt(1)["jugador"]);
                    if (
                    (auxMap3.elementAt(1)["estrella"] == 1) &&
                        (auxMap3.elementAt(1)["categoria"] ==
                            widget._categoria) &&
                        (auxMap3.elementAt(1)["jornada"].toString() ==
                            widget._jornada) &&
                        (auxMap3.elementAt(1)["jugador"] != null)
                    ) {
                      //jugadoresListAux.add(JugadorJornada.fromJson(key, auxMap3));
                      jugadoresList.add(JugadorJornada.fromJson(key, auxMap3.elementAt(1)));
                    }
                  }
              });
            });
    jugadoresList.sort((a, b) => b.posicion.compareTo(a.posicion));
          }



 /* _childAdded(Event event) {
    List<JugadorJornada> jugadoresListAux = new List<JugadorJornada>();
    setState(() {
      Map<dynamic, dynamic> auxMap2 = event.snapshot.value;
      print(widget._jornada);
      print( widget._categoria);
      print( widget._temporada);
      print("map22:${auxMap2}");
      auxMap2.forEach((key, value) {
        print("SSSSSSSS:${value}");
        List<dynamic>  auxMap3 = value;
        print("map2:${auxMap3}");
        //   print("VALUE2${value}");
        // print(auxMap3.keys);
        auxMap3.forEach((key2, value2) {
          // print("map3:${key2}");
          // print("VALUE3${value2}");

          // print("ESTRELLA:${value2["estrella"]}");
          if (value2["estrella"] != null){
            print(widget._jornada);
            print( widget._categoria);
            print( value2["jugador"]);
            if (
            (value2["estrella"] == 1) &&
                (value2["categoria"] == widget._categoria) &&
                (value2["jornada"].toString() == widget._jornada) &&
                (value2["jugador"] != null)
            ) {
              //jugadoresListAux.add(JugadorJornada.fromJson(key, auxMap3));
              jugadoresList.add(JugadorJornada.fromJson(key2, value2));
            }
          }
        });
      });
    });
    jugadoresList.sort((a, b) => b.posicion.compareTo(a.posicion));

  }*/


  @override
  void dispose() {
    super.dispose();
  }
}
