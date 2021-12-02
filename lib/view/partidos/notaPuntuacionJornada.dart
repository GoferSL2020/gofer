import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/locale/app_localization.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/model/jugadorJornadaColumna.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/gsheetsSCOUT.dart';
import 'package:iadvancedscout/view/jugadoresJornada.dart';

import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotaPuntuacionJornada extends StatefulWidget {
  final Player jugador;

  NotaPuntuacionJornada({@required this.jugador});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotaPuntuacionJornada();
  }
}

class _NotaPuntuacionJornada extends State<NotaPuntuacionJornada> {
  int puntoAux = 1;
  String nodeName = "jornadas";
  FirebaseDatabase _database = FirebaseDatabase.instance;
  double puntuaciones;
  String acciones;
  bool estrella;
  @override
  void initState() {
    setState(() {
      if (widget.jugador.accion != "") acciones = widget.jugador.accion;
      if (widget.jugador.puntuacion != 0)
        puntuaciones = widget.jugador.puntuacion;
    });
  }

  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(0),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texto(
                  Config.edadColorSub(
                      Config.edadSub(widget.jugador.fechaNacimiento)),
                  "${widget.jugador.dorsal == -2 ? "*" : widget.jugador.dorsal}. ${widget.jugador.jugador} (${Config.edad(widget.jugador.fechaNacimiento)})",
                  10,
                  Colors.white,
                  false),
              Texto(
                  Colors.blue[900],
                  "${widget.jugador.posicion.toUpperCase()}",
                  9,
                  Colors.white,
                  false),
              Switch(
                value: widget.jugador.estrella,
                onChanged: (newValue) {
                  setState(() {
                    widget.jugador.estrella = newValue;
                    //ponerLosPuntosFireBaseEstrella(estrella);
                    // ponerLosPuntosExcel(puntuaciones, jugadorJornada, jugadorJornadaColumna, estrella);
                  });
                },
                activeTrackColor: Colors.yellow[500],
                activeColor: Colors.yellow[500],
              ),
            ],
          ),
          CupertinoSegmentedControl(
              borderColor: Colors.black,
              pressedColor: Colors.blue,
              selectedColor: Colors.black,
              unselectedColor: Colors.white,
              groupValue: acciones,
              children: <String, Widget>{
                "A": Container(
                    color: acciones != "A" ? Colors.red : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("A",
                        style: TextStyle(
                            color: acciones != "A" ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),
                "SV": Container(
                    color: acciones != "SV" ? Colors.purple : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("SV",
                        style: TextStyle(
                            color: acciones != "SV" ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),
                "SIM": Container(
                    color: acciones != "SIM" ? Colors.grey : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("SIM",
                        style: TextStyle(
                            color: acciones != "SIM" ? Colors.black : Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)))),
                "NA": Container(
                    color: acciones != "NA" ? Colors.yellow : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("NA",
                        style: TextStyle(
                            color: acciones != "NA" ? Colors.black : Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)))),
                "T": Container(
                    color: acciones != "T" ? Colors.green : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("T",
                        style: TextStyle(
                            color: acciones != "T" ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),
                "S": Container(
                    color: acciones != "S" ? Colors.orangeAccent : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("S",
                        style: TextStyle(
                            color: acciones != "S" ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),
                "SC": Container(
                    color: acciones != "SC" ? Colors.blue : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("SC",
                        style: TextStyle(
                            color: acciones != "SC" ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),
                "EX": Container(
                    color: acciones != "EX" ? Colors.white : Colors.black,
                    padding: EdgeInsets.all(4.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("EX",
                        style: TextStyle(
                            color: acciones != "EX" ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),

              },
              onValueChanged: (value) {
                acciones = value;
                setState(() {
                  widget.jugador.accion = value;
                });

                //ponerAccionesFireBase(value);
                // ponerLosPuntosExcel(value, jugadorJornada, jugadorJornadaColumna, estrella);
              }),
          Container(
            height: 10,
          ),
          CupertinoSegmentedControl(
              borderColor: Colors.black,
              pressedColor: Colors.blue,
              selectedColor: Colors.black,
              unselectedColor: Colors.white,
              groupValue: puntuaciones,
              children: <double, Widget>{
                0: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 10),
                    )),
                4: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 10),
                    )),
                4.5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "4.5",
                      style: TextStyle(fontSize: 10),
                    )),
                5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 10),
                    )),
                5.5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "5.5",
                      style: TextStyle(fontSize: 10),
                    )),
                6: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 10),
                    )),
                6.5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "6.5",
                      style: TextStyle(fontSize: 10),
                    )),
                7: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 10),
                    )),
                7.5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "7.5",
                      style: TextStyle(fontSize: 10),
                    )),
                8: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 10),
                    )),
                8.5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "8.5",
                      style: TextStyle(fontSize: 10),
                    )),
                9: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 10),
                    )),
                9.5: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "9.5",
                      style: TextStyle(fontSize: 10),
                    )),
                10: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "10",
                      style: TextStyle(fontSize: 10),
                    )),
              },
              onValueChanged: (value) {
                puntuaciones = value;
                setState(() {
                  widget.jugador.puntuacion = value;
                });

                //ponerLosPuntosFireBase(value);
                //ponerLosPuntosExcel(value, jugadorJornada, jugadorJornadaColumna, estrella);
              }),
        ]));
  }

  ponerLosPuntosFireBaseEstrella(int value) async {}
  ponerLosPuntosFireBase(double value) async {}

  ponerAccionesFireBase(String value) async {}

  ponerLosPuntosExcel(int value, JugadorJornada jugadorJornada,
      JugadorJornadaColumna jugadorJornadaColumna, int estrella) async {
    /* await  ProductManager().insertJugadorHojaJornadaEquipo(jugadorJornada);
        await  ProductManagerEXCELSCOUT().insertJugadorHojaJornadaEquipo(jugadorJornada);
        int fila=0;
        await ProductManager().filaById(jugadorJornadaColumna.id).then((value) {
          fila=value;
        });
        await ProductManagerEXCELSCOUT().filaById(jugadorJornadaColumna.id).then((value) {
          fila=value;
        });
        await ProductManager().insertJugadorHojaPuntuacionesJornada(jugadorJornadaColumna,fila);
        await ProductManagerEXCELSCOUT().insertJugadorHojaPuntuacionesJornada(jugadorJornadaColumna,fila);
  */
  }

  _showAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctxt) => new AlertDialog(
              title: Text(
                "No hay la fecha o el Equipo",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                RaisedButton.icon(
                  color: Config.colorAPP,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    "Aceptar",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  icon: Icon(
                    Icons.loop_outlined,
                    color: Config.botones,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
