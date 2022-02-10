import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/view/partidos/partidosJornadaView.dart';
import 'package:iadvancedscout/view/partidos/partidosView.dart';
import 'package:iadvancedscout/view/partidos/puntacionesPartido.dart';


class TabPuntuaciones extends StatefulWidget {
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Jornada jornada;
  final Partido partido;
  @override
  TabPuntuacionesState createState() =>
      TabPuntuacionesState();
  TabPuntuaciones(this.temporada, this.categoria, this.pais, this.partido,this.jornada
     );
  bool cambio=false;
  cambiar(){
    cambio=true;
  }
}

class TabPuntuacionesState extends State<TabPuntuaciones> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  GlobalKey<TabPuntuacionesState> _myTabCaracteristicasKey = GlobalKey();

  void ponerValue (String value){
    setState(() {

    });
  }
  CRUDJugador dao=CRUDJugador();
  TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cogerLosJugadores();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      //print(_controller.index);
    });
  }

  //cogerLosJugadores:BuJNv17ghCPGnq37P2ev:QqjzloEo6PI7sHfsffk2:JsHvDmVZuWbAi0Z1zRuj:2DvtLnNubpkJkuE66mWE:AD Ceuta
  //cogerLosJugadores:BuJNv17ghCPGnq37P2ev:QqjzloEo6PI7sHfsffk2:JsHvDmVZuWbAi0Z1zRuj:2DvtLnNubpkJkuE66mWE:Villanovense
  List<Player> _jugadoresCASA;
  List<Player> _jugadoresFUERA;
  cogerLosJugadores() async{
    List<Player> jugadoresCASAAUX;
    List<Player> jugadoresFUERAAUX;
     jugadoresCASAAUX=await dao.fetchJugadores(widget.temporada, widget.pais, widget.categoria,widget.partido.equipoCASA);
    jugadoresFUERAAUX=await dao.fetchJugadores(widget.temporada, widget.pais, widget.categoria,widget.partido.equipoFUERA);
    /*try {
      await dao.fetchJugadoresPuntuaciones(
          "jugadoresCASA",
          jugadoresCASAAUX,
          widget.temporada,
          widget.pais,
          widget.categoria,
          widget.jornada,
          widget.partido);

      await dao.fetchJugadoresPuntuaciones(
          "jugadoresFUERA",
          jugadoresFUERAAUX,
          widget.temporada,
          widget.pais,
          widget.categoria,
          widget.jornada,
          widget.partido);

    }catch(e){
      //print(e.toString());
    }*/
    setState(() {
      _jugadoresCASA=jugadoresCASAAUX;
      _jugadoresFUERA=jugadoresFUERAAUX;
    });

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                  onPressed: () {
                    if (widget.cambio) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Atención'),
                            content: Text('¿Has grabado los datos?'),
                            actions: [
                              FlatButton(
                                  child: Text('Salir'),
                                  onPressed: ()  async {
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                    Navigator
                                        .push(
                                      context,
                                      new MaterialPageRoute(builder: (context) =>
                                      new PartidosView(jornada: widget.jornada,
                                          temporada: widget.temporada,
                                          categoria: widget.categoria, pais: widget.pais)),
                                    );
                                  }
                              ),
                              FlatButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context, true);

                                  }
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else{
                      Navigator.pop(context, true);
                      Navigator
                          .push(
                        context,
                        new MaterialPageRoute(builder: (context) =>
                        new PartidosView(jornada: widget.jornada, temporada: widget.temporada,
                            categoria: widget.categoria, pais: widget.pais)));
                    }
                  }
              ),
              actions: <Widget>[
                Container(
                  width: 80,
                  child: IconButton(
                      icon:new
                      Icon(Icons.save_outlined,size: 30, color: Colors.blue,),
                      onPressed: () async {
                        _showGrabar(context);
                      }
                  ),
                )
              ],
                  backgroundColor: Colors.black,
                  title: Text("IAScout - Puntuaciones",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    )),
                elevation: 0,
                centerTitle: true,
              bottom:
              TabBar(
                  onTap: (index) {
                    _controller.index=index;

                  },
                  labelStyle: TextStyle(fontSize: 12.0), //For Selected tab
                  controller: _controller,

                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Config.colorMenu,
                  labelColor: Config.tabColor,
                  tabs: [

                     Tab(
                      child: Column(children: [
                        new Image.network(Config.escudoClubes(widget.partido.equipoCASA),height: 40,
                          ),
                        ],
                      ),),
                    new Tab(
                      child: Column(children: [
                        new Image.network(Config.escudoClubes(widget.partido.equipoFUERA),height: 40,
                        ),
                      ],
                      ),),
                  ]),
            ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                //shape: CircularNotchedRectangle(),
                notchMargin: 10.0,
                child:
                Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child:
                      new Column(children: [
                        Container(height: 2),
                  new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 30, // match_parent
                      child:
                      RaisedButton.icon(
                        onPressed: () {
                          CRUDPartido dao = new CRUDPartido();
                          for(var d in _jugadoresFUERA){
                            setState(() {
                              puntuacionJornadaPoner(widget.partido, d, "");
                              estadoJornadaPoner(widget.partido, d, "SIM");

                              d.estado="SIM";
                              d.puntuacion="";
                              widget.cambio=true;
                            });
                          }
                          for(var d in _jugadoresCASA){
                            setState(() {
                              puntuacionJornadaPoner(widget.partido, d, "");
                              estadoJornadaPoner(widget.partido, d, "SIM");

                              d.estado="SIM";
                              d.puntuacion="";
                              widget.cambio=true;
                            });
                          }
                          setState(() {
                          });


                        },
                        label: Text(
                          "Sin imág.",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        icon: Icon(
                          Icons.videocam_off,
                          size: 20,
                          color: Colors.white,
                        ),
                        textColor: Colors.black,
                        splashColor: Colors.black,
                        color: Colors.grey.shade600,
                      ),),Container(width: 2),
                    SizedBox(
                      width: 120,
                      height: 30, // match_parent
                      child:
                      RaisedButton.icon(
                        onPressed: () {
                          setState(() {
                          for(var d in _jugadoresFUERA){
                            puntuacionJornadaPoner(widget.partido, d, "");
                            estadoJornadaPoner(widget.partido, d, "SV");

                            d.estado="SV";
                              d.puntuacion="";
                            widget.cambio=true;
                          }
                          });
                          setState(() {
                            for(var d in _jugadoresCASA){
                              puntuacionJornadaPoner(widget.partido, d, "");
                              estadoJornadaPoner(widget.partido, d, "SV");

                              d.estado="SV";
                              d.puntuacion="";
                              widget.cambio=true;
                          }
                          });
                          setState(() {
                          });


                        },
                        label: Text(
                          "Sin visualizar",
                          style: TextStyle(color: Colors.white, fontSize: 9),
                        ),
                        icon: Icon(
                          MyFlutterApp.eye_slash,
                          size: 15,
                          color: Colors.white,
                        ),
                        textColor: Colors.white,
                        splashColor: Colors.black,
                        color: Colors.purple,
                      ),),


                  ],),Container(height: 2),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 120,
                              height: 30, // match_parent
                              child:
                              RaisedButton.icon(
                                onPressed: () {
                                  for(var d in _jugadoresFUERA){
                                    setState(() {
                                      puntuacionJornadaPoner(widget.partido, d, "");
                                      estadoJornadaPoner(widget.partido, d, "A");
                                      d.estado="A";
                                      d.puntuacion="";
                                      widget.cambio=true;
                                    });
                                  }
                                  for(var d in _jugadoresCASA){
                                    setState(() {
                                      puntuacionJornadaPoner(widget.partido, d, "");
                                      estadoJornadaPoner(widget.partido, d, "A");
                                      d.estado="A";
                                      d.puntuacion="";
                                      widget.cambio=true;
                                    });
                                  }
                                  setState(() {
                                  });


                                },
                                label: Text(
                                  "Aplazado",
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                textColor: Colors.white,
                                splashColor: Colors.black,
                                color: Colors.blue.shade900,
                              ),),Container(width: 2),
                            SizedBox(
                              width: 120,
                              height: 30, // match_parent
                              child:
                              RaisedButton.icon(
                                onPressed: () {
                                  for(var d in _jugadoresFUERA){
                                    setState(() {
                                      puntuacionJornadaPoner(widget.partido, d, "");
                                      estadoJornadaPoner(widget.partido, d, "");
                                      d.estado="";
                                      d.puntuacion="";
                                      widget.cambio=true;
                                    });
                                  }
                                  for(var d in _jugadoresCASA){
                                    setState(() {
                                      puntuacionJornadaPoner(widget.partido, d, "");
                                      estadoJornadaPoner(widget.partido, d, "");
                                      d.estado="";
                                      d.puntuacion="";
                                      widget.cambio=true;
                                    });
                                  }
                                  setState(() {

                                  });


                                },
                                label: Text(
                                  "Limpiar",
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                                icon: Icon(
                                  CustomIcon.eraser,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                textColor: Colors.black,
                                splashColor: Colors.black,
                                color: Colors.grey.shade200,
                              ),),
                          ],),
                  ]),
                  ),
              ),
            body:
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: new Table(
                      columnWidths: {
                        0: FlexColumnWidth(9),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(9),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Text(
                              "${widget.partido.equipoCASA}",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center),
                          Text(
                              "${widget.partido.golesCASA}",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.center),
                          Text(
                              "-",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.center),
                          Text(
                              "${widget.partido.golesFUERA}",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.center),
                          Text(
                              "${widget.partido.equipoFUERA}",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center),
                        ]),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.only(right: 25,bottom: 5),
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(CustomIcon.star, size: 15,color: Colors.yellowAccent,),
                    Container(width:5,),
                    Text(
                        "Destacado",
                        style: TextStyle(fontSize: 11, color: Colors.yellowAccent),
                        textAlign: TextAlign.center),
                  ],)
                ),
            Expanded(child:
            TabBarView(
              controller: _controller,
              children: [
                PuntacionesPartido(partido: widget.partido, jugadores:  _jugadoresCASA,padre: widget),
                PuntacionesPartido(partido: widget.partido,jugadores:  _jugadoresFUERA,padre: widget),
              ],
            ),),
        ])
          )),
    );
  }

  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    //JugadorDao con = new JugadorDao();
    //con.updateJugador(widget.jugador);
    super.dispose();
  }

  Future<bool> _showGrabar(BuildContext context)  {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return  CupertinoAlertDialog(
          title: Text('ATENCIÓN',
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
              )),
          content: Column(
            children: [
              Container(
                height: 10,
              ),
              Text(
                  '¿Quieres grabar las puntuaciones del partido?'),
              Container(
                height: 10,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',
                  style: TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () async {
                Navigator.pop(context, true);
                CRUDJugador con = new CRUDJugador();
                 con.updateJugadorPuntuacionesPartido(
                    widget.temporada,widget.pais,widget.categoria,widget.jornada,
                    widget.partido,_jugadoresCASA,_jugadoresFUERA);
                widget.cambio=false;
                return true; // showDialog() returns true
              },
            ),
            FlatButton(
              child: Text('Cancelar',
                  style: TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {
                Navigator.pop(context, false);
                return false; // showDialog() returns true
              },
            )
          ],
        );
      },
    );

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

}
