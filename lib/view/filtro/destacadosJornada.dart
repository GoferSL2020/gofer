import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/pdf/pdfDestacados.dart';
import 'package:iadvancedscout/view/temporada/temporadaView.dart';
import 'package:iadvancedscout/wigdet/imagen.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


class DestacadosJornada extends StatefulWidget {
  const DestacadosJornada(this._categoria, this._jornada, this._temporada,this._pais);

  @override
  _DestacadosJornadaState createState() => _DestacadosJornadaState();
  final Categoria _categoria;
  final Pais _pais;
  final Jornada _jornada;
  final Temporada _temporada;
}

class _DestacadosJornadaState extends State<DestacadosJornada> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "";


  List<Player> jugadoresList=new List<Player>();

// no need of the file extension, the name will do fine.

  @override
  void initState() {
    setState(() {
      _cogerJugadores();
    });

    //  _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    // _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  _cogerJugadores() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Player> datos = await CRUDJugador().fetchJugadoresdescatados(widget._temporada,widget._pais,widget._categoria,widget._jornada);
    setState(() {
      //print(datos[0].id);
      jugadoresList=datos;
    });
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
                builder: (BuildContext context) => TemporadaView()),
              );
              },
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout - Jugadores destacados" ,
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
                          Texto(Colors.white, "${widget._categoria.categoria} - Jornada: ${widget._jornada.jornada} (${jugadoresList.length})",
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
                    timeInSecForIosWeb: 40,
                    backgroundColor: Colors.green.shade900,
                    textColor: Colors.white,
                    fontSize: 14.0);
                PDFDestacados pdf= PDFDestacados(jugadores: jugadoresList, categoria:widget._categoria,jornada:widget._jornada);
                pdf.generateInvoice();

                /*String file=await pdf.generateInvoice();
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Imagen(file,"Los mejores","${widget._categoria.categoria} - Jornada: ${widget._jornada.jornada}")));
                  */
              },
              label: Text(
                "PDF",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              icon: Icon(
                CustomIcon.file_pdf,
                size: 20,
                color: Colors.white,
              ),
              textColor: Colors.white,
              splashColor: Colors.black,
              color: Colors.red.shade800),
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
