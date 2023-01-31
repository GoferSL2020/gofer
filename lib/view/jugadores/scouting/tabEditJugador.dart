import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/dao/CRUDJugador.dart';
import 'package:iafootfeel/futbol_mio_icons.dart';
import 'package:iafootfeel/icon_mio_icons.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/view/jugadores/jugadoresView.dart';

import 'package:iafootfeel/view/jugadores/scouting/procesoJugador.dart';

import 'package:iafootfeel/view/jugadores/scouting/procesoCaptacion.dart';
import 'package:iafootfeel/view/jugadores/scouting/procesoDireccion.dart';
import 'package:iafootfeel/view/jugadores/scouting/tabNivelFoot.dart';

class TabEditJugador extends StatefulWidget {
  final bool puntuaciones;
  Player jugador;
  Pais pais;
  final FiltroJugadores filtro;
  @override
  TabEditJugadorState createState() => TabEditJugadorState();
  TabEditJugador(this.jugador, this.puntuaciones, this.filtro, this.pais);

  bool cambio = false;
  cambiar() {
    cambio = true;
  }
}

class TabEditJugadorState extends State<TabEditJugador> {
  int _selectedIndex = 0;
  GlobalKey<TabEditJugadorState> _myTabCaracteristicasKey = GlobalKey();
  bool insertar = false;
  void ponerValue(String value) {
    setState(() {
      widget.jugador.nivel = value;
    });
  }

  @override
  void initState() {
    insertar = widget.jugador.jugador == "" ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: BBDDService().getUserScout().puesto == "Marketing" ? 2 : 3,
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
                                    onPressed: () async {
                                      if (widget.puntuaciones == true) {
                                        Navigator.pop(context, true);
                                        Navigator.pop(context, true);
                                      } else {
                                        Navigator.pop(context, true);
                                        Navigator.pop(context, true);
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new JugadoresView(
                                                      widget.filtro,
                                                      widget.pais)),
                                        );
                                      }
                                    }),
                                FlatButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    }),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new JugadoresView(
                                  widget.filtro, widget.pais)),
                        );
                      }
                    }),
                actions: <Widget>[
                  Container(
                      width: 50,
                      child: IconButton(
                        icon: new Image.asset(Config.icono),
                        onPressed: () {},
                      )),
                ],
                backgroundColor: Colors.black,
                title: Column(
                  children: [
                    Container(padding: EdgeInsets.only(bottom: 5),
                        child: Text("FootFeel -Jugador",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Config.colorFootFeel,
                            ))),
                    Text("${widget.jugador.jugador}",
                        style: TextStyle(
                          fontSize: 18,

                          color: Colors.white,
                        )),
                    Container(height: 5,

                    ),
                    Container(height: 1,

                      color: Config.colorFootFeel,
                       ),
                  ],
                ),
                elevation: 0,
                bottom: BBDDService().getUserScout().puesto == "Marketing"
                    ? TabBar(
                        labelStyle:
                            TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), //For Selected tab
                        unselectedLabelColor: Colors.grey,
                    indicatorColor: Config.colorFootFeel,
                    labelColor: Config.colorFootFeel,
                        tabs: [
                            new Tab(
                                icon:
                                    new Icon(CustomIcon.futbolista_4, size: 25),
                                text: 'Datos Jugador'),
                            new Tab(
                                icon: new Icon(Icons.account_box_outlined),
                                text: 'Proc. Dirección'),
                            /*new Tab(
                        icon: new Icon(CustomIcon.hand_point_up),
                        text: 'Puntos'),*/
                          ])
                    : TabBar(
                        labelStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), //Flected tab
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Config.colorFootFeel,
                        labelColor: Config.colorFootFeel,
                        tabs: [
                            new Tab(
                                icon:
                                    new Icon(CustomIcon.futbolista_4, size: 25),
                                text: 'Datos Jugador'),
                            new Tab(
                                icon: new Icon(FutbolMio.entrenador_2),
                                text: 'Proc. Captación'),
                            new Tab(
                                icon: new Icon(Icons.account_box_outlined),
                                text: 'Proc. Dirección'),
                          ]),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                //backgroundColor: widget.jugador.getColor(),
                backgroundColor: Colors.blue[900],
                child: const Icon(CustomIcon.save),
                onPressed: () {
                  if (validacion() == true)
                    _showGrabar(context);
                  else
                    _showValidacion(context);
                  /*setState(() {
                  _showAlert(context,_myTabCaracteristicasKey);
                });*/
                },
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                shape: CircularNotchedRectangle(),
                notchMargin: 4.0,
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              JugadoresView(widget.filtro, widget.pais),
                        ));
                      },
                    ),
                  ],
                ),
              ),
              body: BBDDService().getUserScout().puesto == "Marketing"
                  ? TabBarView(
                      children: [
                        ProcesoJugador(
                            jugador: widget.jugador, pais: widget.pais),
                        ProcesoDireccion(widget.jugador, widget),
                        //PuntuacionesPartidos(widget.equipo, widget.temporada, widget.categoria, widget.pais, widget.jugador)
                      ],
                    )
                  : TabBarView(
                      children: [
                        ProcesoJugador(
                            jugador: widget.jugador, pais: widget.pais),
                        ProcesoCaptacion(widget.jugador, widget),
                        ProcesoDireccion(widget.jugador, widget),
                        //PuntuacionesPartidos(widget.equipo, widget.temporada, widget.categoria, widget.pais, widget.jugador)
                      ],
                    ))),
    );
  }

  validacion() {
    print(widget.jugador.jugador);
    print(widget.jugador.pais);
    print(widget.jugador.equipo);
    print(widget.jugador.categoria);
    print(widget.jugador.competecion);
    if (widget.jugador.jugador.replaceAll(" ", "") == "") return false;
    if (widget.jugador.pais == "") return false;
    if (widget.jugador.equipo == "") return false;
    if (widget.jugador.categoria == "") return false;
    if (widget.jugador.competecion == "") return false;
    return true;
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

  Future<bool> _showGrabar(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
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
                '¿Quieres grabar las caracteristicas de\n${widget.jugador.jugador.toUpperCase()}?',
              ),
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
                CRUDJugador con = CRUDJugador();
                //widget.jugador.firmado=true;
                if (insertar) {
                  await con.addJugadorDatos(widget.jugador);
                  insertar = false;
                  //await con.addJugadorDatosDATABIG(widget.jugador);
                } else {
                  await con.updateJugadorDatos(widget.jugador);
                }
                //con.updateJugadorDATABIG(widget.temporada,widget.pais,widget.categoria,widget.equipo,widget.jugador);
                widget.cambio = false;
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

  Future<bool> _showValidacion(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
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
                  "No estas los datos de jugador:\n"
                  " Nombre\nEquipo\nCompeteción\nCategoría)",
                  style: TextStyle(fontSize: 14, color: Colors.red)),
              Container(
                height: 10,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar', style: TextStyle(fontSize: 16)),
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
