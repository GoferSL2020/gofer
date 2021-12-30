import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/pdf/pdfPartido.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/imagen.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import '../custom_icon_icons.dart';

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

                        ]))
            ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          RaisedButton.icon(
              onPressed: () async {
                Fluttertoast.showToast(
                    msg: "Por favor, espere...",

                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 20,
                    backgroundColor: Colors.green.shade900,
                    textColor: Colors.white,
                    fontSize: 14.0);
                PDFPartido pdf= PDFPartido(jugadores: jugadoresList);
                String file=await pdf.generateInvoice();
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Imagen(file,"Los mejores","${widget._categoria} - Jornada: ${widget._jornada}")));

              },
              label: Text(
                "Archivos",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              icon: Icon(
                CustomIcon.file,
                size: 20,
                color: Colors.white,
              ),
              textColor: Colors.white,
              splashColor: Colors.black,
              color: Colors.blue),
            ]),
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
