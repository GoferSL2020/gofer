import 'package:flutter/cupertino.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/categoriaDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/view/caracteristicas/cualidadesPsicologia.dart';
import 'package:iadvancedscout/view/caracteristicas/defensivas.dart';
import 'package:iadvancedscout/view/caracteristicas/ofensivas.dart';
import 'package:iadvancedscout/view/categorias.dart';

import 'package:iadvancedscout/view/categoriasList.dart';

import 'package:iadvancedscout/view/editJugador.dart';

import 'package:iadvancedscout/view/paises.dart';


import 'package:iadvancedscout/model/categoria.dart';

import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/pais.dart';

import 'package:iadvancedscout/my_flutter_app_icons.dart';

import 'nivel.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import 'package:flutter/material.dart';

import '../../wigdet/observaciones.dart';
import 'capacidadesFisico.dart';

class TabNivel extends StatefulWidget {
  @override
  TabNivelState createState() =>
      TabNivelState();
  final Jugador _jugador;
  TabNivel(this._jugador);
}

class TabNivelState extends State<TabNivel> {
  int _selectedIndex = 0;
  GlobalKey<TabNivelState> _myTabNivelKey = GlobalKey();

  void ponerValue(String value) {
    setState(() {
      widget._jugador.nivel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                title:
             TabBar(
                labelStyle: TextStyle(fontSize: 14.0), //For Selected tab
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                labelColor: Colors.black,

              tabs: [
                new Tab(
                     text: 'Ciclo 1'),
                new Tab(
                    text: 'Ciclo 2'),
                new Tab(
                    text: 'Ciclo 3'),
                new Tab(
                    text: 'Ciclo 4'),
              ]),
            ),
          body   :TabBarView(

            children: [
            Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children:[
            Container(padding: EdgeInsets.only(left:15.0, right: 15),
            child:
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel == "Superlativo"
                            ? Color.fromRGBO(0, 176, 80, 1)
                            : Colors.grey,
                        child: Text(
                          "Superlativo",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel == "Superlativo"
                            ? Color.fromRGBO(0, 176, 80, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Superlativo";

                          });
                        },
                      )),
                  Container(
                    width: 2,
                  ),
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel == "Superior"
                            ? Color.fromRGBO(172, 243, 13, 1)
                            : Colors.grey,
                        child: Text(
                          "Superior",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel == "Superior"
                            ? Color.fromRGBO(172, 243, 13, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Superior";
                          });

                        },
                      )),

                  Container(
                    width: 2,
                  ),
                  SizedBox(
                    width: 105, // specific value
                    child: RaisedButton(
                      color: widget._jugador.nivel == "Destacado"
                          ? Color.fromRGBO(245, 234, 11, 1)
                          : Colors.grey,
                      child: Text(
                        "Destacado",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      textColor: Colors.black,
                      splashColor: widget._jugador.nivel == "Destacado"
                          ? Color.fromRGBO(245, 234, 11, 1)
                          : Colors.grey,
                      onPressed: () {
                        setState(() {
                          widget._jugador.nivel = "Destacado";
                        });

                      },
                    ),
                  ),

                ]),

          ),
          Container(padding: EdgeInsets.only(left:15.0, right: 15),
            child:
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel == "Intermedio"
                            ? Color.fromRGBO(246, 128, 10, 1)
                            : Colors.grey,
                        child: Text(
                          "Intermedio",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel == "Intermedio"
                            ? Color.fromRGBO(246, 128, 10, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Intermedio";
                          });

                        },
                      )),
                  Container(
                    width: 2,
                  ),
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel == "Dudoso"
                            ? Color.fromRGBO(248, 25, 8, 1)
                            : Colors.grey,
                        child: Text(
                          "Dudoso",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel == "Dudoso"
                            ? Color.fromRGBO(248, 25, 8, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Dudoso";
                          });
                        },
                      )),
                  Container(
                    width: 2,
                  ),
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel == "Bajo"
                            ? Color.fromRGBO(193, 20, 7, 1)
                            : Colors.grey,
                        child: Text(
                          "Bajo",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel == "Bajo"
                            ? Color.fromRGBO(193, 20, 7, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Bajo";
                          });

                        },
                      )),
                ]),),
              Container(padding: EdgeInsets.only(left:15.0, right: 15),
                child:
                Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                    children: [
                      Container(

                      ), Container(

                      ),
                      SizedBox(
                          width: 105, // specific value
                          child: RaisedButton(
                            color: widget._jugador.nivel == "N/A"
                                ? Color.fromRGBO(189, 243, 249, 1)
                                : Colors.grey,
                            child: Text(
                              "N/A",
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            textColor: Colors.black,
                            splashColor: widget._jugador.nivel == "N/A"
                                ? Color.fromRGBO(189, 243, 249, 1)
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                widget._jugador.nivel = "N/A";
                              });
                            },
                          )),
                      Container(

                      ),
                      Container(

                      ),

                    ]),

              ),
          ]),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children:[
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "Superlativo"
                                      ? Color.fromRGBO(0, 176, 80, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Superlativo",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Superlativo"
                                      ? Color.fromRGBO(0, 176, 80, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Superlativo";

                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "Superior"
                                      ? Color.fromRGBO(172, 243, 13, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Superior",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Superior"
                                      ? Color.fromRGBO(172, 243, 13, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Superior";
                                    });

                                  },
                                )),

                            Container(
                              width: 2,
                            ),
                            SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel2 == "Destacado"
                                    ? Color.fromRGBO(245, 234, 11, 1)
                                    : Colors.grey,
                                child: Text(
                                  "Destacado",
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                textColor: Colors.black,
                                splashColor: widget._jugador.nivel2 == "Destacado"
                                    ? Color.fromRGBO(245, 234, 11, 1)
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 = "Destacado";
                                  });

                                },
                              ),
                            ),

                          ]),
                    ),
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "Intermedio"
                                      ? Color.fromRGBO(246, 128, 10, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Intermedio",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Intermedio"
                                      ? Color.fromRGBO(246, 128, 10, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Intermedio";
                                    });

                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "Dudoso"
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Dudoso"
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Dudoso";
                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "Bajo"
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Bajo"
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Bajo";
                                    });

                                  },
                                )),
                          ]),),
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            Container(

                            ), Container(

                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "N/A"
                                      ? Color.fromRGBO(189, 243, 249, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "N/A",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "N/A"
                                      ? Color.fromRGBO(189, 243, 249, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "N/A";
                                    });
                                  },
                                )),
                            Container(

                            ),
                            Container(

                            ),

                          ]),

                    ),
                  ]),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children:[
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "Superlativo"
                                      ? Color.fromRGBO(0, 176, 80, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Superlativo",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3 == "Superlativo"
                                      ? Color.fromRGBO(0, 176, 80, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Superlativo";

                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "Superior"
                                      ? Color.fromRGBO(172, 243, 13, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Superior",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3 == "Superior"
                                      ? Color.fromRGBO(172, 243, 13, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Superior";
                                    });

                                  },
                                )),

                            Container(
                              width: 2,
                            ),
                            SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel3 == "Destacado"
                                    ? Color.fromRGBO(245, 234, 11, 1)
                                    : Colors.grey,
                                child: Text(
                                  "Destacado",
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                textColor: Colors.black,
                                splashColor: widget._jugador.nivel3 == "Destacado"
                                    ? Color.fromRGBO(245, 234, 11, 1)
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel3 = "Destacado";
                                  });

                                },
                              ),
                            ),

                          ]),
                    ),
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "Intermedio"
                                      ? Color.fromRGBO(246, 128, 10, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Intermedio",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3 == "Intermedio"
                                      ? Color.fromRGBO(246, 128, 10, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Intermedio";
                                    });

                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "Dudoso"
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3== "Dudoso"
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3= "Dudoso";
                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "Bajo"
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3== "Bajo"
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Bajo";
                                    });

                                  },
                                )),
                          ]),),
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            Container(

                            ), Container(

                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "N/A"
                                      ? Color.fromRGBO(189, 243, 249, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "N/A",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3 == "N/A"
                                      ? Color.fromRGBO(189, 243, 249, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "N/A";
                                    });
                                  },
                                )),
                            Container(

                            ),
                            Container(

                            ),

                          ]),

                    ),
                  ]),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children:[
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "Superlativo"
                                      ? Color.fromRGBO(0, 176, 80, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Superlativo",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Superlativo"
                                      ? Color.fromRGBO(0, 176, 80, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Superlativo";

                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "Superior"
                                      ? Color.fromRGBO(172, 243, 13, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Superior",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Superior"
                                      ? Color.fromRGBO(172, 243, 13, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Superior";
                                    });

                                  },
                                )),

                            Container(
                              width: 2,
                            ),
                            SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel4 == "Destacado"
                                    ? Color.fromRGBO(245, 234, 11, 1)
                                    : Colors.grey,
                                child: Text(
                                  "Destacado",
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                textColor: Colors.black,
                                splashColor: widget._jugador.nivel4 == "Destacado"
                                    ? Color.fromRGBO(245, 234, 11, 1)
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel4 = "Destacado";
                                  });

                                },
                              ),
                            ),

                          ]),
                    ),
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "Intermedio"
                                      ? Color.fromRGBO(246, 128, 10, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Intermedio",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Intermedio"
                                      ? Color.fromRGBO(246, 128, 10, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Intermedio";
                                    });

                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "Dudoso"
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Dudoso"
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Dudoso";
                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "Bajo"
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Bajo"
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Bajo";
                                    });

                                  },
                                )),
                          ]),),
                    Container(padding: EdgeInsets.only(left:15.0, right: 15),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            Container(

                            ), Container(

                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "N/A"
                                      ? Color.fromRGBO(189, 243, 249, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "N/A",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "N/A"
                                      ? Color.fromRGBO(189, 243, 249, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "N/A";
                                    });
                                  },
                                )),
                            Container(

                            ),
                            Container(

                            ),

                          ]),

                    ),
                  ]),

        ],
      ),
        ),
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
      //con.updateJugador(widget._jugador);
      super.dispose();
    }
  }

