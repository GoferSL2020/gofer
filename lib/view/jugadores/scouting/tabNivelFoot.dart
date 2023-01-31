import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:iafootfeel/view/jugadores/scouting/tabEditJugador.dart';

class TabNivelFoot extends StatefulWidget {
  @override
  TabNivelFootState createState() => TabNivelFootState();

  TabNivelFoot(this._jugador,this._padre);
  final TabEditJugador _padre;
  final Player _jugador;
  
}

class TabNivelFootState extends State<TabNivelFoot> {
  int _selectedIndex = 0;
  GlobalKey<TabNivelFootState> _myTabNivelKey = GlobalKey();

  void ponerValue(String value) {
    setState(() {
      
      widget._jugador.nivel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: TabBar(
              labelStyle: TextStyle(fontSize: 14.0), //For Selected tab
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                new Tab(text: 'Período 1'),
                new Tab(text: 'Período 2'),
              ]),
        ),
        body: TabBarView(
          children: [
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel.toUpperCase() ==
                                        "Top".toUpperCase()
                                    ? Player.nivelColorSuperlativo(
                                        widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Top".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel.toUpperCase() ==
                                            "Top".toUpperCase()
                                        ? Player.nivelColorSuperlativo(
                                            widget._jugador.nivel.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel =
                                        "Top".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel.toUpperCase() ==
                                        "Destacado".toUpperCase()
                                    ? Player.nivelColorSuperior(
                                        widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel.toUpperCase() ==
                                            "Destacado".toUpperCase()
                                        ? Player.nivelColorSuperior(
                                            widget._jugador.nivel.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel =
                                        "Destacado".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                            width: 105, // specific value
                            child: RaisedButton(
                              color: widget._jugador.nivel.toUpperCase() ==
                                      "Acorde a la categoría".toUpperCase()
                                  ? Player.nivelColorDestacado(
                                      widget._jugador.nivel.toUpperCase())
                                  : Colors.grey,
                              child: Text(
                                "Acorde a la categoría".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              textColor: Colors.black,
                              splashColor:
                                  widget._jugador.nivel.toUpperCase() ==
                                          "Acorde a la categoría".toUpperCase()
                                      ? Player.nivelColorDestacado(
                                          widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  
                                  widget._jugador.nivel =
                                      "Acorde a la categoría".toUpperCase();
                                });
                              },
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel.toUpperCase() ==
                                        "Discreto".toUpperCase()
                                    ? Player.nivelColorIntermedio(
                                        widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Discreto".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel.toUpperCase() ==
                                            "Discreto".toUpperCase()
                                        ? Player.nivelColorIntermedio(
                                            widget._jugador.nivel.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel =
                                        "Discreto".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel.toUpperCase() ==
                                        "No ha jugado".toUpperCase()
                                    ? Player.nivelColorDudoso(
                                        widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "No ha jugado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel.toUpperCase() ==
                                            "No ha jugado".toUpperCase()
                                        ? Player.nivelColorDudoso(
                                            widget._jugador.nivel.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel =
                                        "No ha jugado".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton.icon(
                                color: Colors.white,
                                icon: Icon(CustomIcon.eraser,
                                    color: Colors.black, size: 15),
                                label: Text(
                                  "limpiar".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel = "";
                                  });
                                },
                              )),
                        ]),
                  ),
                ]),
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel2.toUpperCase() ==
                                        "Top".toUpperCase()
                                    ? Player.nivelColorSuperlativo(
                                        widget._jugador.nivel2.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Top".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel2.toUpperCase() ==
                                            "Top".toUpperCase()
                                        ? Player.nivelColorSuperlativo(
                                            widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel2 =
                                        "Top".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel2.toUpperCase() ==
                                        "Destacado".toUpperCase()
                                    ? Player.nivelColorSuperior(
                                        widget._jugador.nivel2.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel2.toUpperCase() ==
                                            "Destacado".toUpperCase()
                                        ? Player.nivelColorSuperior(
                                            widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel2 =
                                        "Destacado".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                            width: 105, // specific value
                            child: RaisedButton(
                              color: widget._jugador.nivel2.toUpperCase() ==
                                      "Acorde a la categoría".toUpperCase()
                                  ? Player.nivelColorDestacado(
                                      widget._jugador.nivel2.toUpperCase())
                                  : Colors.grey,
                              child: Text(
                                "Acorde a la categoría".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(

                                    color: Colors.black, fontSize: 10),
                              ),
                              textColor: Colors.black,
                              splashColor:
                                  widget._jugador.nivel2.toUpperCase() ==
                                          "Acorde a la categoría".toUpperCase()
                                      ? Player.nivelColorDestacado(
                                          widget._jugador.nivel2.toUpperCase())
                                      : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  
                                  widget._jugador.nivel2 =
                                      "Acorde a la categoría".toUpperCase();
                                });
                              },
                            ),
                          ),
                          
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel2.toUpperCase() ==
                                        "Discreto".toUpperCase()
                                    ? Player.nivelColorIntermedio(
                                        widget._jugador.nivel2.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Discreto".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel2.toUpperCase() ==
                                            "Discreto".toUpperCase()
                                        ? Player.nivelColorIntermedio(
                                            widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel2 =
                                        "Discreto".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel2.toUpperCase() ==
                                        "Dudoso".toUpperCase()
                                    ? Player.nivelColorDudoso(
                                        widget._jugador.nivel2.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "No ha jugado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor:
                                    widget._jugador.nivel2.toUpperCase() ==
                                            "No ha jugado".toUpperCase()
                                        ? Player.nivelColorDudoso(
                                            widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    
                                    widget._jugador.nivel2 =
                                        "No ha jugado".toUpperCase();
                                  });
                                },
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: RaisedButton.icon(
                                color: Colors.white,
                                icon: Icon(CustomIcon.eraser,
                                    color: Colors.black, size: 15),
                                label: Text(
                                  "limpiar".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor: Colors.white,
                                onPressed: () {
                                  setState(() {

                                    widget._jugador.nivel2 = "";
                                  });
                                },
                              )),
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
