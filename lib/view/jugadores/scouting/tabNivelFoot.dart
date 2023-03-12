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
                              child: TextButton(
                                  child: Text(
                                    "Top".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                  onPressed: () {
                                    setState(() {

                                      widget._jugador.nivel =
                                          "Top".toUpperCase();
                                    });
                                  },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                 widget._jugador.nivel.toUpperCase() ==
                                        "Top".toUpperCase()
                                    ? Player.nivelColorSuperlativo(
                                        widget._jugador.nivel.toUpperCase())
                                    : Colors.grey),
                                  foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel =
                                        "Destacado".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel.toUpperCase() ==
                                        "Destacado".toUpperCase()
                                        ? Player.nivelColorSuperior(
                                        widget._jugador.nivel.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "Acorde a la categoría".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel =
                                        "Acorde a la categoría".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel.toUpperCase() ==
                                        "Acorde a la categoría".toUpperCase()
                                        ? Player.nivelColorDestacado(
                                        widget._jugador.nivel.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "Discreto".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel =
                                        "Discreto".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel.toUpperCase() ==
                                        "Discreto".toUpperCase()
                                        ? Player.nivelColorIntermedio(
                                        widget._jugador.nivel.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "No ha jugado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel =
                                        "DisNo ha jugadocreto".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel.toUpperCase() ==
                                        "No ha jugado".toUpperCase()
                                        ? Player.nivelColorDudoso(
                                        widget._jugador.nivel.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),

                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton.icon(
                                label: Text(
                                  "limpiar".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                icon: Icon(CustomIcon.eraser,
                                    color: Colors.black, size: 15),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel =
                                        "limpiar".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
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
                              child: TextButton(
                                child: Text(
                                  "Top".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {

                                    widget._jugador.nivel2 =
                                        "Top".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel2.toUpperCase() ==
                                        "Top".toUpperCase()
                                        ? Player.nivelColorSuperlativo(
                                        widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 =
                                        "Destacado".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel2.toUpperCase() ==
                                        "Destacado".toUpperCase()
                                        ? Player.nivelColorSuperior(
                                        widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "Acorde a la categoría".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 =
                                        "Acorde a la categoría".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel2.toUpperCase() ==
                                        "Acorde a la categoría".toUpperCase()
                                        ? Player.nivelColorDestacado(
                                        widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "Discreto".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 =
                                        "Discreto".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel2.toUpperCase() ==
                                        "Discreto".toUpperCase()
                                        ? Player.nivelColorIntermedio(
                                        widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),
                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton(
                                child: Text(
                                  "No ha jugado".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 =
                                        "No ha jugado".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                                    widget._jugador.nivel2.toUpperCase() ==
                                        "No ha jugado".toUpperCase()
                                        ? Player.nivelColorDudoso(
                                        widget._jugador.nivel2.toUpperCase())
                                        : Colors.grey),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
                              )),

                          Container(
                            width: 2,
                          ),
                          SizedBox(
                              width: 105, // specific value
                              child: TextButton.icon(
                                label: Text(
                                  "limpiar".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                icon: Icon(CustomIcon.eraser,
                                    color: Colors.black, size: 15),
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 =
                                        "limpiar".toUpperCase();
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black) ),
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
