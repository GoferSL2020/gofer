import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/model/jugadorJornadaColumna.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';

class NotaPuntuacionJornada extends StatefulWidget {
  final Player jugador;
  final Partido partido;

  NotaPuntuacionJornada({ this.partido, this.jugador});
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
  String puntuaciones;

  bool estrella;
  @override
  void initState() {
    setState(() {
        puntuaciones =  puntuacionJornada(widget.partido,widget.jugador);
        estrella =  estrellaJornada(widget.partido,widget.jugador);
        widget.jugador.estrella=estrella;
        widget.jugador.puntuacion=puntuaciones;

    });
  }

  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }

  String puntuacionJornada(Partido p, Player jug) {
    String s="";
    if(p.jornada==1) s=jug.puntaciones_jornada_1;
    if(p.jornada==2) s=jug.puntaciones_jornada_2;
    if(p.jornada==3) s=jug.puntaciones_jornada_3;
    if(p.jornada==4) s=jug.puntaciones_jornada_4;
    if(p.jornada==5) s=jug.puntaciones_jornada_5;
    if(p.jornada==6) s=jug.puntaciones_jornada_6;
    if(p.jornada==7) s=jug.puntaciones_jornada_7;
    if(p.jornada==8) s=jug.puntaciones_jornada_8;
    if(p.jornada==9) s=jug.puntaciones_jornada_9;
    if(p.jornada==10) s=jug.puntaciones_jornada_10;
    if(p.jornada==11) s=jug.puntaciones_jornada_11;
    if(p.jornada==12) s=jug.puntaciones_jornada_12;
    if(p.jornada==13) s=jug.puntaciones_jornada_13;
    if(p.jornada==14) s=jug.puntaciones_jornada_14;
    if(p.jornada==15) s=jug.puntaciones_jornada_15;
    if(p.jornada==16) s=jug.puntaciones_jornada_16;
    if(p.jornada==17) s=jug.puntaciones_jornada_17;
    if(p.jornada==18) s=jug.puntaciones_jornada_18;
    if(p.jornada==19) s=jug.puntaciones_jornada_19;
    if(p.jornada==20) s=jug.puntaciones_jornada_20;
    if(p.jornada==21) s=jug.puntaciones_jornada_21;
    if(p.jornada==22) s=jug.puntaciones_jornada_22;
    if(p.jornada==23) s=jug.puntaciones_jornada_23;
    if(p.jornada==24) s=jug.puntaciones_jornada_24;
    if(p.jornada==25) s=jug.puntaciones_jornada_25;
    if(p.jornada==26) s=jug.puntaciones_jornada_26;
    if(p.jornada==27) s=jug.puntaciones_jornada_27;
    if(p.jornada==28) s=jug.puntaciones_jornada_28;
    if(p.jornada==29) s=jug.puntaciones_jornada_29;
    if(p.jornada==30) s=jug.puntaciones_jornada_30;
    if(p.jornada==31) s=jug.puntaciones_jornada_31;
    if(p.jornada==32) s=jug.puntaciones_jornada_32;
    if(p.jornada==33) s=jug.puntaciones_jornada_33;
    if(p.jornada==34) s=jug.puntaciones_jornada_34;
    if(p.jornada==35) s=jug.puntaciones_jornada_35;
    if(p.jornada==36) s=jug.puntaciones_jornada_36;
    if(p.jornada==37) s=jug.puntaciones_jornada_37;
    if(p.jornada==38) s=jug.puntaciones_jornada_38;
    if(p.jornada==39) s=jug.puntaciones_jornada_39;
    if(p.jornada==40) s=jug.puntaciones_jornada_40;
    if(p.jornada==41) s=jug.puntaciones_jornada_41;
    if(p.jornada==42) s=jug.puntaciones_jornada_42;
    if(p.jornada==43) s=jug.puntaciones_jornada_43;
    if(p.jornada==44) s=jug.puntaciones_jornada_44;
    if(p.jornada==45) s=jug.puntaciones_jornada_45;
    if(p.jornada==46) s=jug.puntaciones_jornada_46;
    if(s==null)s="";
    print(s);
    return s;
  }

  bool estrellaJornada(Partido p, Player jug) {
    bool s=false;
    if(p.jornada==1) s=jug.estrella_jornada_1;
    if(p.jornada==2) s=jug.estrella_jornada_2;
    if(p.jornada==3) s=jug.estrella_jornada_3;
    if(p.jornada==4) s=jug.estrella_jornada_4;
    if(p.jornada==5) s=jug.estrella_jornada_5;
    if(p.jornada==6) s=jug.estrella_jornada_6;
    if(p.jornada==7) s=jug.estrella_jornada_7;
    if(p.jornada==8) s=jug.estrella_jornada_8;
    if(p.jornada==9) s=jug.estrella_jornada_9;
    if(p.jornada==10) s=jug.estrella_jornada_10;
    if(p.jornada==11) s=jug.estrella_jornada_11;
    if(p.jornada==12) s=jug.estrella_jornada_12;
    if(p.jornada==13) s=jug.estrella_jornada_13;
    if(p.jornada==14) s=jug.estrella_jornada_14;
    if(p.jornada==15) s=jug.estrella_jornada_15;
    if(p.jornada==16) s=jug.estrella_jornada_16;
    if(p.jornada==17) s=jug.estrella_jornada_17;
    if(p.jornada==18) s=jug.estrella_jornada_18;
    if(p.jornada==19) s=jug.estrella_jornada_19;
    if(p.jornada==20) s=jug.estrella_jornada_20;
    if(p.jornada==21) s=jug.estrella_jornada_21;
    if(p.jornada==22) s=jug.estrella_jornada_22;
    if(p.jornada==23) s=jug.estrella_jornada_23;
    if(p.jornada==24) s=jug.estrella_jornada_24;
    if(p.jornada==25) s=jug.estrella_jornada_25;
    if(p.jornada==26) s=jug.estrella_jornada_26;
    if(p.jornada==27) s=jug.estrella_jornada_27;
    if(p.jornada==28) s=jug.estrella_jornada_28;
    if(p.jornada==29) s=jug.estrella_jornada_29;
    if(p.jornada==30) s=jug.estrella_jornada_30;
    if(p.jornada==31) s=jug.estrella_jornada_31;
    if(p.jornada==32) s=jug.estrella_jornada_32;
    if(p.jornada==33) s=jug.estrella_jornada_33;
    if(p.jornada==34) s=jug.estrella_jornada_34;
    if(p.jornada==35) s=jug.estrella_jornada_35;
    if(p.jornada==36) s=jug.estrella_jornada_36;
    if(p.jornada==37) s=jug.estrella_jornada_37;
    if(p.jornada==38) s=jug.estrella_jornada_38;
    if(p.jornada==39) s=jug.estrella_jornada_39;
    if(p.jornada==40) s=jug.estrella_jornada_40;
    if(p.jornada==41) s=jug.estrella_jornada_41;
    if(p.jornada==42) s=jug.estrella_jornada_42;
    if(p.jornada==43) s=jug.estrella_jornada_43;
    if(p.jornada==44) s=jug.estrella_jornada_44;
    if(p.jornada==45) s=jug.estrella_jornada_45;
    if(p.jornada==46) s=jug.estrella_jornada_46;
    if(s==null)s=false;
    print(s);
    return s;
  }



  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.jugador.dorsal == -2 ? "*" : widget.jugador.dorsal}. ${widget.jugador.jugador} (${Config.edad( widget.jugador.fechaNacimiento)})",
                style: new TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold),
              ),

              Text(
                  "${Config.edadSubSolo( widget.jugador.fechaNacimiento)}",
                  style: new TextStyle(color:Config.edadColorSub(
                      Config.edadSubSolo(widget.jugador.fechaNacimiento)),
                  fontSize: 11, fontWeight: FontWeight.bold),
                  ),
              Switch(
                value: estrella,
                onChanged: (newValue) {
                  estrella=newValue;
                  setState(() {
                    widget.jugador.estrella=newValue;
                    //widget.jugador.estrella = newValue;
                    //ponerLosPuntosFireBaseEstrella(estrella);
                    // ponerLosPuntosExcel(puntuaciones, jugadorJornada, jugadorJornadaColumna, estrella);
                  });
                },
                activeTrackColor: Colors.yellow[500],
                activeColor: Colors.yellow[500],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left:20,bottom: 5,top:0),
            child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.jugador.posicion.toUpperCase()}",
                style: TextStyle(fontSize: 8,color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ),

          Container(
            height: 10,
          ),
          CupertinoSegmentedControl(
              padding: EdgeInsets.all(0),
              borderColor: Colors.black,
              pressedColor: Colors.blue,
              selectedColor: Colors.black,
              unselectedColor: Colors.white,
              groupValue: puntuaciones,
              children: <String, Widget>{
                "": Container(),
                "A": Container(
                    color: puntuaciones != "A" ? Colors.red : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("A",
                        style: TextStyle(
                            color: puntuaciones != "A" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "SV": Container(
                    color: puntuaciones != "SV" ? Colors.purpleAccent : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("SV",
                        style: TextStyle(
                            color: puntuaciones != "SV" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "SIM": Container(
                    color: puntuaciones != "SIM" ? Colors.grey : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("SIM",
                        style: TextStyle(
                            color: puntuaciones != "SIM" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "NA": Container(
                    color: puntuaciones != "NA" ? Colors.yellow : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("NA",
                        style: TextStyle(
                            color: puntuaciones != "NA" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "T": Container(
                    color: puntuaciones != "T" ? Colors.green : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("T",
                        style: TextStyle(
                            color: puntuaciones != "T" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "S": Container(
                    color: puntuaciones != "S" ? Colors.orangeAccent : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("S",
                        style: TextStyle(
                            color: puntuaciones != "S" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "SC": Container(
                    color: puntuaciones != "SC" ? Colors.blue : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("SC",
                        style: TextStyle(
                            color: puntuaciones != "SC" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),
                "EX": Container(
                    color: puntuaciones != "EX" ? Colors.white : Colors.black,
                    padding: EdgeInsets.all(2.0),
                    width: 50,
                    height: 30,
                    child: Center(child:Text("EX",
                        style: TextStyle(
                            color: puntuaciones != "EX" ? Colors.black : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)))),

                "0": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "SC",
                      style: TextStyle(fontSize: 8),
                    )),
                "4": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 8),
                    )),
                "4,5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "4.5",
                      style: TextStyle(fontSize: 8),
                    )),
                "5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 8),
                    )),
                "5,5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "5.5",
                      style: TextStyle(fontSize: 8),
                    )),
                "6": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 8),
                    )),
                "6,5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "6.5",
                      style: TextStyle(fontSize: 8),
                    )),
                "7": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 8),
                    )),
                "7,5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "7.5",
                      style: TextStyle(fontSize: 8),
                    )),
                "8": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 8),
                    )),
                "8,5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "8.5",
                      style: TextStyle(fontSize: 8),
                    )),
                "9": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 8),
                    )),
                "9,5": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "9.5",
                      style: TextStyle(fontSize: 8),
                    )),
                "10": Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "10",
                      style: TextStyle(fontSize: 8),
                    )),
              },
              onValueChanged: (value) {
                puntuaciones  = value;
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
