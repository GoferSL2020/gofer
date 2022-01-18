import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/view/partidos/notaPuntuacionJornada.dart';


class PuntacionesPartido extends StatefulWidget {
  final List<Player> jugadores;
  final Partido partido;

  PuntacionesPartido({@required this.jugadores, this.partido});
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PuntacionesPartidoState();
  }


}



class _PuntacionesPartidoState extends State<PuntacionesPartido> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CRUDJugador dao=CRUDJugador();
    return Scaffold(
                  body:
                    widget.jugadores!=null?
                    ListView.builder(
                      itemCount: widget.jugadores.length,
                      itemBuilder: (context, index)
                        {
                          return
                            ListTile(
                              title:
                              Container(
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
                                              "${widget.jugadores[index].dorsal == -2 ? "*" : widget.jugadores[index].dorsal}. ${widget.jugadores[index].jugador} (${Config.edad( widget.jugadores[index].fechaNacimiento)})",
                                              style: new TextStyle(
                                                  fontSize: 11, fontWeight: FontWeight.bold),
                                            ),

                                            Text(
                                              "${Config.edadSubSolo( widget.jugadores[index].fechaNacimiento)}",
                                              style: new TextStyle(color:Config.edadColorSub(
                                                  Config.edadSubSolo(widget.jugadores[index].fechaNacimiento)),
                                                  fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                            Switch(
                                              value: estrellaJornada(widget.partido,widget.jugadores[index]),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  estrellaJornadaPoner(widget.partido,widget.jugadores[index],newValue);
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
                                          child:Text("${widget.jugadores[index].posicion.toUpperCase()}",
                                            style: TextStyle(fontSize: 12,color: Colors.blue, fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              botonPuntos("A", Colors.blue,widget.jugadores[index]),
                                              botonPuntos("SV", Colors.purple,widget.jugadores[index]),
                                              botonPuntos("SIM", Colors.grey,widget.jugadores[index]),
                                              botonPuntos("NA", Colors.yellow,widget.jugadores[index]),
                                              botonPuntos("T", Colors.green,widget.jugadores[index]),
                                              botonPuntos("S", Colors.orange,widget.jugadores[index]),
                                              // botonPuntos("SCT", Colors.green),
                                              // botonPuntos("SCS", Colors.orange),
                                              botonPuntos("EX", Colors.red,widget.jugadores[index]),
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
                                                      puntuacionJornadaPoner(widget.partido,widget.jugadores[index],"");
                                                      estadoJornadaPoner(widget.partido,widget.jugadores[index],"");
                                                      estrellaJornadaPoner(widget.partido,widget.jugadores[index],false);
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
                                              botonPuntosNumeros("SC", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("4", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("4,5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("5,5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("6", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("6,5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("7", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("7,5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("8", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("8,5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("9", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("9,5", Colors.white,widget.jugadores[index]),
                                              botonPuntosNumeros("10", Colors.white,widget.jugadores[index]),
                                            ]),

                                      ])),


                              //NotaPuntuacionJornada(partido:widget.partido,jugador: widget.jugadores[index])
                            );
                        }
                    ):Container(
                      child:Center(
                        child:Text("Espera....",style: TextStyle(fontSize: 20,color: Colors.red),))
                    ),
    );
  }

  SizedBox botonPuntos(String est, Color color,Player jugador) {
    return SizedBox(
      width: 30,
      height: 25, // match_parent
      child:
      RaisedButton(
        color: estadoJornada(widget.partido,jugador) != est ? color : Colors.black,
        padding: EdgeInsets.only(left: 0),
        onPressed: () {
          setState(() {
            estadoJornadaPoner(widget.partido,jugador,est);
          });
        },
        child: Text(
          est,
          style: TextStyle( color: estadoJornada(widget.partido,jugador) != est ? Colors.black : Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  SizedBox botonPuntosNumeros(String puntu, Color color,Player jugador) {
    return SizedBox(
      width: 22,
      height: 25, // match_parent
      child:
      RaisedButton(
        color: puntuacionJornada(widget.partido,jugador) != puntu ? color : Colors.black,
        padding: EdgeInsets.only(left: 0),
        textColor: Colors.black,
        splashColor: Colors.black,
        onPressed: () {
          setState(() {
            puntuacionJornadaPoner(widget.partido,jugador,puntu);
          });
        },
        child: Text(
          puntu,
          style: TextStyle( color: puntuacionJornada(widget.partido,jugador) != puntu ? Colors.black : Colors.white, fontSize: 11),
        ),
      ),
    );
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
    return s;
  }


   puntuacionJornadaPoner(Partido p, Player jug, String valor) {
    String s="";
    if(p.jornada==1) jug.puntaciones_jornada_1=valor;
    if(p.jornada==2) jug.puntaciones_jornada_2=valor;
    if(p.jornada==3) jug.puntaciones_jornada_3=valor;
    if(p.jornada==4) jug.puntaciones_jornada_4=valor;
    if(p.jornada==5) jug.puntaciones_jornada_5=valor;
    if(p.jornada==6) jug.puntaciones_jornada_6=valor;
    if(p.jornada==7) jug.puntaciones_jornada_7=valor;
    if(p.jornada==8) jug.puntaciones_jornada_8=valor;
    if(p.jornada==9) jug.puntaciones_jornada_9=valor;
    if(p.jornada==10) jug.puntaciones_jornada_10=valor;
    if(p.jornada==11) jug.puntaciones_jornada_11=valor;
    if(p.jornada==12) jug.puntaciones_jornada_12=valor;
    if(p.jornada==13) jug.puntaciones_jornada_13=valor;
    if(p.jornada==14) jug.puntaciones_jornada_14=valor;
    if(p.jornada==15) jug.puntaciones_jornada_15=valor;
    if(p.jornada==16) jug.puntaciones_jornada_16=valor;
    if(p.jornada==17) jug.puntaciones_jornada_17=valor;
    if(p.jornada==18) jug.puntaciones_jornada_18=valor;
    if(p.jornada==19) jug.puntaciones_jornada_19=valor;
    if(p.jornada==20) jug.puntaciones_jornada_20=valor;
    if(p.jornada==21) jug.puntaciones_jornada_21=valor;
    if(p.jornada==22) jug.puntaciones_jornada_22=valor;
    if(p.jornada==23) jug.puntaciones_jornada_23=valor;
    if(p.jornada==24) jug.puntaciones_jornada_24=valor;
    if(p.jornada==25) jug.puntaciones_jornada_25=valor;
    if(p.jornada==26) jug.puntaciones_jornada_26=valor;
    if(p.jornada==27) jug.puntaciones_jornada_27=valor;
    if(p.jornada==28) jug.puntaciones_jornada_28=valor;
    if(p.jornada==29) jug.puntaciones_jornada_29=valor;
    if(p.jornada==30) jug.puntaciones_jornada_30=valor;
    if(p.jornada==31) jug.puntaciones_jornada_31=valor;
    if(p.jornada==32) jug.puntaciones_jornada_32=valor;
    if(p.jornada==33) jug.puntaciones_jornada_33=valor;
    if(p.jornada==34) jug.puntaciones_jornada_34=valor;
    if(p.jornada==35) jug.puntaciones_jornada_35=valor;
    if(p.jornada==36) jug.puntaciones_jornada_36=valor;
    if(p.jornada==37) jug.puntaciones_jornada_37=valor;
    if(p.jornada==38) jug.puntaciones_jornada_38=valor;
    if(p.jornada==39) jug.puntaciones_jornada_39=valor;
    if(p.jornada==40) jug.puntaciones_jornada_40=valor;
    if(p.jornada==41) jug.puntaciones_jornada_41=valor;
    if(p.jornada==42) jug.puntaciones_jornada_42=valor;
    if(p.jornada==43) jug.puntaciones_jornada_43=valor;
    if(p.jornada==44) jug.puntaciones_jornada_44=valor;
    if(p.jornada==45) jug.puntaciones_jornada_45=valor;
    if(p.jornada==46) jug.puntaciones_jornada_46=valor;
    jug.puntaciones=valor;

  }


  estadoJornadaPoner(Partido p, Player jug, String valor) {
    String s="";
    if(p.jornada==1) jug.estado_jornada_1=valor;
    if(p.jornada==2) jug.estado_jornada_2=valor;
    if(p.jornada==3) jug.estado_jornada_3=valor;
    if(p.jornada==4) jug.estado_jornada_4=valor;
    if(p.jornada==5) jug.estado_jornada_5=valor;
    if(p.jornada==6) jug.estado_jornada_6=valor;
    if(p.jornada==7) jug.estado_jornada_7=valor;
    if(p.jornada==8) jug.estado_jornada_8=valor;
    if(p.jornada==9) jug.estado_jornada_9=valor;
    if(p.jornada==10) jug.estado_jornada_10=valor;
    if(p.jornada==11) jug.estado_jornada_11=valor;
    if(p.jornada==12) jug.estado_jornada_12=valor;
    if(p.jornada==13) jug.estado_jornada_13=valor;
    if(p.jornada==14) jug.estado_jornada_14=valor;
    if(p.jornada==15) jug.estado_jornada_15=valor;
    if(p.jornada==16) jug.estado_jornada_16=valor;
    if(p.jornada==17) jug.estado_jornada_17=valor;
    if(p.jornada==18) jug.estado_jornada_18=valor;
    if(p.jornada==19) jug.estado_jornada_19=valor;
    if(p.jornada==20) jug.estado_jornada_20=valor;
    if(p.jornada==21) jug.estado_jornada_21=valor;
    if(p.jornada==22) jug.estado_jornada_22=valor;
    if(p.jornada==23) jug.estado_jornada_23=valor;
    if(p.jornada==24) jug.estado_jornada_24=valor;
    if(p.jornada==25) jug.estado_jornada_25=valor;
    if(p.jornada==26) jug.estado_jornada_26=valor;
    if(p.jornada==27) jug.estado_jornada_27=valor;
    if(p.jornada==28) jug.estado_jornada_28=valor;
    if(p.jornada==29) jug.estado_jornada_29=valor;
    if(p.jornada==30) jug.estado_jornada_30=valor;
    if(p.jornada==31) jug.estado_jornada_31=valor;
    if(p.jornada==32) jug.estado_jornada_32=valor;
    if(p.jornada==33) jug.estado_jornada_33=valor;
    if(p.jornada==34) jug.estado_jornada_34=valor;
    if(p.jornada==35) jug.estado_jornada_35=valor;
    if(p.jornada==36) jug.estado_jornada_36=valor;
    if(p.jornada==37) jug.estado_jornada_37=valor;
    if(p.jornada==38) jug.estado_jornada_38=valor;
    if(p.jornada==39) jug.estado_jornada_39=valor;
    if(p.jornada==40) jug.estado_jornada_40=valor;
    if(p.jornada==41) jug.estado_jornada_41=valor;
    if(p.jornada==42) jug.estado_jornada_42=valor;
    if(p.jornada==43) jug.estado_jornada_43=valor;
    if(p.jornada==44) jug.estado_jornada_44=valor;
    if(p.jornada==45) jug.estado_jornada_45=valor;
    if(p.jornada==46) jug.estado_jornada_46=valor;
    jug.estado=valor;

  }

  estrellaJornadaPoner(Partido p, Player jug, bool valor) {
    String s="";
    if(p.jornada==1) jug.estrella_jornada_1=valor;
    if(p.jornada==2) jug.estrella_jornada_2=valor;
    if(p.jornada==3) jug.estrella_jornada_3=valor;
    if(p.jornada==4) jug.estrella_jornada_4=valor;
    if(p.jornada==5) jug.estrella_jornada_5=valor;
    if(p.jornada==6) jug.estrella_jornada_6=valor;
    if(p.jornada==7) jug.estrella_jornada_7=valor;
    if(p.jornada==8) jug.estrella_jornada_8=valor;
    if(p.jornada==9) jug.estrella_jornada_9=valor;
    if(p.jornada==10) jug.estrella_jornada_10=valor;
    if(p.jornada==11) jug.estrella_jornada_11=valor;
    if(p.jornada==12) jug.estrella_jornada_12=valor;
    if(p.jornada==13) jug.estrella_jornada_13=valor;
    if(p.jornada==14) jug.estrella_jornada_14=valor;
    if(p.jornada==15) jug.estrella_jornada_15=valor;
    if(p.jornada==16) jug.estrella_jornada_16=valor;
    if(p.jornada==17) jug.estrella_jornada_17=valor;
    if(p.jornada==18) jug.estrella_jornada_18=valor;
    if(p.jornada==19) jug.estrella_jornada_19=valor;
    if(p.jornada==20) jug.estrella_jornada_20=valor;
    if(p.jornada==21) jug.estrella_jornada_21=valor;
    if(p.jornada==22) jug.estrella_jornada_22=valor;
    if(p.jornada==23) jug.estrella_jornada_23=valor;
    if(p.jornada==24) jug.estrella_jornada_24=valor;
    if(p.jornada==25) jug.estrella_jornada_25=valor;
    if(p.jornada==26) jug.estrella_jornada_26=valor;
    if(p.jornada==27) jug.estrella_jornada_27=valor;
    if(p.jornada==28) jug.estrella_jornada_28=valor;
    if(p.jornada==29) jug.estrella_jornada_29=valor;
    if(p.jornada==30) jug.estrella_jornada_30=valor;
    if(p.jornada==31) jug.estrella_jornada_31=valor;
    if(p.jornada==32) jug.estrella_jornada_32=valor;
    if(p.jornada==33) jug.estrella_jornada_33=valor;
    if(p.jornada==34) jug.estrella_jornada_34=valor;
    if(p.jornada==35) jug.estrella_jornada_35=valor;
    if(p.jornada==36) jug.estrella_jornada_36=valor;
    if(p.jornada==37) jug.estrella_jornada_37=valor;
    if(p.jornada==38) jug.estrella_jornada_38=valor;
    if(p.jornada==39) jug.estrella_jornada_39=valor;
    if(p.jornada==40) jug.estrella_jornada_40=valor;
    if(p.jornada==41) jug.estrella_jornada_41=valor;
    if(p.jornada==42) jug.estrella_jornada_42=valor;
    if(p.jornada==43) jug.estrella_jornada_43=valor;
    if(p.jornada==44) jug.estrella_jornada_44=valor;
    if(p.jornada==45) jug.estrella_jornada_45=valor;
    if(p.jornada==46) jug.estrella_jornada_46=valor;
    jug.estrella=valor;

  }

  @override
  void dispose() {

    super.dispose();
  }
}