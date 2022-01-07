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
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child:
                  new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 110,
                      height: 30, // match_parent
                      child:
                      RaisedButton.icon(
                        onPressed: () {
                          CRUDPartido dao = new CRUDPartido();
                          for(var d in _jugadoresFUERA){
                            setState(() {
                              d.accion="SIM";
                              d.puntuacion="SIM";
                            });
                          }
                          for(var d in _jugadoresCASA){
                            setState(() {
                              d.accion="SIM";
                              d.puntuacion="SIM";
                            });
                          }
                          setState(() {
                            _controller.index==0?_controller.index=1:_controller.index=0;
                            _controller.index==0?_controller.index=1:_controller.index=0;
                          });

                          try {
                            CRUDJugador dao = new CRUDJugador();
                            dao.updateJugadorPuntuacionesMigrar(
                                widget.temporada,widget.pais,widget.categoria,widget.jornada,
                                widget.partido,_jugadoresCASA,_jugadoresFUERA);
                             Fluttertoast.showToast(
                                msg: "Se ha grabado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green.shade900,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: "No se ha grabado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red.shade900,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        },
                        label: Text(
                          "Sin video",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        icon: Icon(
                          Icons.videocam_off,
                          size: 20,
                          color: Colors.white,
                        ),
                        textColor: Colors.black,
                        splashColor: Colors.black,
                        color: Colors.grey.shade900,
                      ),),
                    SizedBox(
                      width: 115,
                      height: 30, // match_parent
                      child:
                      RaisedButton.icon(
                        onPressed: () {
                          setState(() {
                          for(var d in _jugadoresFUERA){
                              d.accion="SV";
                              d.puntuacion="SV";
                          }
                          });
                          setState(() {
                            for(var d in _jugadoresCASA){
                              d.accion="SV";
                              d.puntuacion="SV";
                          }
                          });
                          setState(() {
                            _controller.index==0?_controller.index=1:_controller.index=0;
                            _controller.index==0?_controller.index=1:_controller.index=0;
                          });

                          try {
                            CRUDJugador dao = new CRUDJugador();
                            dao.updateJugadorPuntuacionesMigrar(
                                widget.temporada,widget.pais,widget.categoria,widget.jornada,
                                widget.partido,_jugadoresCASA,_jugadoresFUERA);
                             Fluttertoast.showToast(
                                msg: "Se ha grabado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green.shade900,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: "No se ha grabado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red.shade900,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
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
                    SizedBox(
                      width: 110,
                      height: 30, // match_parent
                      child:
                      RaisedButton.icon(
                        onPressed: () {
                          for(var d in _jugadoresFUERA){
                            setState(() {
                              d.accion="A";
                              d.puntuacion="A";
                            });
                          }
                          for(var d in _jugadoresCASA){
                            setState(() {
                              d.accion="A";
                              d.puntuacion="A";
                            });
                          }
                          setState(() {
                            _controller.index==0?_controller.index=1:_controller.index=0;
                            _controller.index==0?_controller.index=1:_controller.index=0;
                          });

                          try {
                            CRUDJugador dao = new CRUDJugador();
                            dao.updateJugadorPuntuacionesMigrar(
                                widget.temporada,widget.pais,widget.categoria,widget.jornada,
                                widget.partido,_jugadoresCASA,_jugadoresFUERA);
                             Fluttertoast.showToast(
                                msg: "Se ha grabado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green.shade900,
                                textColor: Colors.white,
                                fontSize: 12.0);

                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: "No se ha grabado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red.shade900,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
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
                        color: Colors.red.shade900,
                      ),),

                  ],
                ),),
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
                PuntacionesPartido(partido: widget.partido, jugadores:  _jugadoresCASA,),
                PuntacionesPartido(partido: widget.partido,jugadores:  _jugadoresFUERA,),
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
                 con.updateJugadorPuntuacionesMigrar(
                    widget.temporada,widget.pais,widget.categoria,widget.jornada,
                    widget.partido,_jugadoresCASA,_jugadoresFUERA);

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


}
