import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugadorJornada.dart';
import 'package:iadvancedscout/model/jugadorJornadaColumna.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';

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
  String estado;

  bool estrella;
  @override
  void initState() {
    print("entro");
    setState(() {
      puntuaciones =  puntuacionJornada(widget.partido,widget.jugador);
      estado =  estadoJornada(widget.partido,widget.jugador);
      estrella =  estrellaJornada(widget.partido,widget.jugador);

    });
  }

 /* @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }*/

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

  String estadoJornada(Partido p, Player jug) {
    String s="";
    if(p.jornada==1) s=jug.estado_jornada_1;
    if(p.jornada==2) s=jug.estado_jornada_2;
    if(p.jornada==3) s=jug.estado_jornada_3;
    if(p.jornada==4) s=jug.estado_jornada_4;
    if(p.jornada==5) s=jug.estado_jornada_5;
    if(p.jornada==6) s=jug.estado_jornada_6;
    if(p.jornada==7) s=jug.estado_jornada_7;
    if(p.jornada==8) s=jug.estado_jornada_8;
    if(p.jornada==9) s=jug.estado_jornada_9;
    if(p.jornada==10) s=jug.estado_jornada_10;
    if(p.jornada==11) s=jug.estado_jornada_11;
    if(p.jornada==12) s=jug.estado_jornada_12;
    if(p.jornada==13) s=jug.estado_jornada_13;
    if(p.jornada==14) s=jug.estado_jornada_14;
    if(p.jornada==15) s=jug.estado_jornada_15;
    if(p.jornada==16) s=jug.estado_jornada_16;
    if(p.jornada==17) s=jug.estado_jornada_17;
    if(p.jornada==18) s=jug.estado_jornada_18;
    if(p.jornada==19) s=jug.estado_jornada_19;
    if(p.jornada==20) s=jug.estado_jornada_20;
    if(p.jornada==21) s=jug.estado_jornada_21;
    if(p.jornada==22) s=jug.estado_jornada_22;
    if(p.jornada==23) s=jug.estado_jornada_23;
    if(p.jornada==24) s=jug.estado_jornada_24;
    if(p.jornada==25) s=jug.estado_jornada_25;
    if(p.jornada==26) s=jug.estado_jornada_26;
    if(p.jornada==27) s=jug.estado_jornada_27;
    if(p.jornada==28) s=jug.estado_jornada_28;
    if(p.jornada==29) s=jug.estado_jornada_29;
    if(p.jornada==30) s=jug.estado_jornada_30;
    if(p.jornada==31) s=jug.estado_jornada_31;
    if(p.jornada==32) s=jug.estado_jornada_32;
    if(p.jornada==33) s=jug.estado_jornada_33;
    if(p.jornada==34) s=jug.estado_jornada_34;
    if(p.jornada==35) s=jug.estado_jornada_35;
    if(p.jornada==36) s=jug.estado_jornada_36;
    if(p.jornada==37) s=jug.estado_jornada_37;
    if(p.jornada==38) s=jug.estado_jornada_38;
    if(p.jornada==39) s=jug.estado_jornada_39;
    if(p.jornada==40) s=jug.estado_jornada_40;
    if(p.jornada==41) s=jug.estado_jornada_41;
    if(p.jornada==42) s=jug.estado_jornada_42;
    if(p.jornada==43) s=jug.estado_jornada_43;
    if(p.jornada==44) s=jug.estado_jornada_44;
    if(p.jornada==45) s=jug.estado_jornada_45;
    if(p.jornada==46) s=jug.estado_jornada_46;
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
            padding: EdgeInsets.only(left:0,bottom: 5,top:0),
            child:Text("${widget.jugador.posicion.toUpperCase()}",
              style: TextStyle(fontSize: 12,color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              botonPuntos("A", Colors.blue),
              botonPuntos("SV", Colors.purple),
              botonPuntos("SIM", Colors.grey),
              botonPuntos("NA", Colors.yellow),
              botonPuntos("T", Colors.green),
              botonPuntos("S", Colors.orange),
             // botonPuntos("SCT", Colors.green),
             // botonPuntos("SCS", Colors.orange),
              botonPuntos("EX", Colors.red),
              Container(
                width: 20,
              ),
              SizedBox(
                width: 90,
                height: 25, // match_parent
                child:
                RaisedButton.icon(
                  onPressed: () {
                    setState(() {
                      puntuaciones="";
                      widget.jugador.puntaciones="";
                      estado="";
                      widget.jugador.estado="";
                      widget.jugador.estrella=false;
                      estrella=false;
                    });
                  },
                  label: Text(
                    "Limpiar",
                    style: TextStyle(color: Colors.black, fontSize: 9),
                  ),
                  icon: Icon(
                    MyFlutterApp.eraser_1,
                    size: 15,
                    color: Colors.black,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.black,
                  color: Colors.white,
                ),),
            ]),
              Container(
                height:10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    botonPuntosNumeros("SC", Colors.white),
                    botonPuntosNumeros("4", Colors.white),
                    botonPuntosNumeros("4,5", Colors.white),
                    botonPuntosNumeros("5", Colors.white),
                    botonPuntosNumeros("5,5", Colors.white),
                    botonPuntosNumeros("6", Colors.white),
                    botonPuntosNumeros("6,5", Colors.white),
                    botonPuntosNumeros("7", Colors.white),
                    botonPuntosNumeros("7,5", Colors.white),
                    botonPuntosNumeros("8", Colors.white),
                    botonPuntosNumeros("8,5", Colors.white),
                    botonPuntosNumeros("9", Colors.white),
                    botonPuntosNumeros("9,5", Colors.white),
                    botonPuntosNumeros("10", Colors.white),
                  ]),

          ]));
  }

  SizedBox botonPuntos(String est, Color color) {
    return SizedBox(
              width: 30,
              height: 25, // match_parent
              child:
              RaisedButton(
                color: estado != est ? color : Colors.black,
                padding: EdgeInsets.only(left: 0),
                onPressed: () {
                  setState(() {
                    estado=est;
                    widget.jugador.estado=est;
                  });
                },
                child: Text(
                  est,
                  style: TextStyle( color: estado != est ? Colors.black : Colors.white, fontSize: 10),
                ),
              ),
            );
  }

  SizedBox botonPuntosNumeros(String puntu, Color color) {
    return SizedBox(
      width: 22,
      height: 25, // match_parent
      child:
      RaisedButton(
        color: puntuaciones != puntu ? color : Colors.black,
        padding: EdgeInsets.only(left: 0),
        textColor: Colors.black,
        splashColor: Colors.black,
        onPressed: () {
          setState(() {
            puntuaciones=puntu;
            widget.jugador.puntaciones=puntu;
          });
        },
        child: Text(
          puntu,
          style: TextStyle( color: puntuaciones != puntu ? Colors.black : Colors.white, fontSize: 11),
        ),
      ),
    );
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
