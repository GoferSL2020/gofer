import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/modelo/player.dart';

class TabNivel extends StatefulWidget {
  @override
  TabNivelState createState() =>
      TabNivelState();
  final Player _jugador;
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
                        color: widget._jugador.nivel.toUpperCase() == "Superlativo".toUpperCase()
                            ? Color.fromRGBO(0, 176, 80, 1)
                            : Colors.grey,
                        child: Text(
                          "Superlativo".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Superlativo".toUpperCase()
                            ? Color.fromRGBO(0, 176, 80, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Superlativo".toUpperCase();

                          });
                        },
                      )),
                  Container(
                    width: 2,
                  ),
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel.toUpperCase()  == "Superior".toUpperCase()
                            ? Color.fromRGBO(172, 243, 13, 1)
                            : Colors.grey,
                        child: Text(
                          "Superior".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Superior".toUpperCase()
                            ? Color.fromRGBO(172, 243, 13, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Superior".toUpperCase();
                          });

                        },
                      )),

                  Container(
                    width: 2,
                  ),
                  SizedBox(
                    width: 105, // specific value
                    child: RaisedButton(
                      color: widget._jugador.nivel.toUpperCase()  == "Destacado".toUpperCase()
                          ? Color.fromRGBO(245, 234, 11, 1)
                          : Colors.grey,
                      child: Text(
                        "Destacado".toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      textColor: Colors.black,
                      splashColor: widget._jugador.nivel.toUpperCase()  == "Destacado".toUpperCase()
                          ? Color.fromRGBO(245, 234, 11, 1)
                          : Colors.grey,
                      onPressed: () {
                        setState(() {
                          widget._jugador.nivel = "Destacado".toUpperCase();
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
                        color: widget._jugador.nivel.toUpperCase()  == "Intermedio".toUpperCase()
                            ? Color.fromRGBO(246, 128, 10, 1)
                            : Colors.grey,
                        child: Text(
                          "Intermedio".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Intermedio".toUpperCase()
                            ? Color.fromRGBO(246, 128, 10, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Intermedio".toUpperCase();
                          });

                        },
                      )),
                  Container(
                    width: 2,
                  ),
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel.toUpperCase()  == "Dudoso".toUpperCase()
                            ? Color.fromRGBO(248, 25, 8, 1)
                            : Colors.grey,
                        child: Text(
                          "Dudoso".toUpperCase().toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Dudoso".toUpperCase().toUpperCase()
                            ? Color.fromRGBO(248, 25, 8, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Dudoso".toUpperCase().toUpperCase();
                          });
                        },
                      )),
                  Container(
                    width: 2,
                  ),
                  SizedBox(
                      width: 105, // specific value
                      child: RaisedButton(
                        color: widget._jugador.nivel.toUpperCase()  == "Bajo".toUpperCase()
                            ? Color.fromRGBO(193, 20, 7, 1)
                            : Colors.grey,
                        child: Text(
                          "Bajo".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Bajo".toUpperCase()
                            ? Color.fromRGBO(193, 20, 7, 1)
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Bajo".toUpperCase();
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
                            color: widget._jugador.nivel.toUpperCase()  == "N/A"
                                ? Color.fromRGBO(189, 243, 249, 1)
                                : Colors.grey,
                            child: Text(
                              "N/A",
                              style: TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            textColor: Colors.black,
                            splashColor: widget._jugador.nivel.toUpperCase()  == "N/A"
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                  style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                  color: widget._jugador.nivel2 == "Dudoso".toUpperCase()
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Dudoso".toUpperCase()
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Dudoso".toUpperCase();
                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2 == "Bajo".toUpperCase()
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "Bajo".toUpperCase()
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Bajo".toUpperCase();
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                  style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                  color: widget._jugador.nivel3 == "Dudoso".toUpperCase()
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3== "Dudoso".toUpperCase()
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3= "Dudoso".toUpperCase();
                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3 == "Bajo".toUpperCase()
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3== "Bajo".toUpperCase()
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Bajo".toUpperCase();
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                  style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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
                                  color: widget._jugador.nivel4 == "Dudoso".toUpperCase()
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Dudoso".toUpperCase()
                                      ? Color.fromRGBO(248, 25, 8, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Dudoso".toUpperCase();
                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4 == "Bajo".toUpperCase()
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "Bajo".toUpperCase()
                                      ? Color.fromRGBO(193, 20, 7, 1)
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Bajo".toUpperCase();
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
                                    style: TextStyle(color: Colors.black, fontSize: 10),
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

