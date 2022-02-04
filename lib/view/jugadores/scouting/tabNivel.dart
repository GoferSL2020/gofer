import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
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
                            ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                            : Colors.grey,
                        child: Text(
                          "Superlativo".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Superlativo".toUpperCase()
                            ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
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
                            ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                            : Colors.grey,
                        child: Text(
                          "Superior".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Superior".toUpperCase()
                            ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
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
                          ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                          : Colors.grey,
                      child: Text(
                        "Destacado".toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      textColor: Colors.black,
                      splashColor: widget._jugador.nivel.toUpperCase()  == "Destacado".toUpperCase()
                          ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
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
                            ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                            : Colors.grey,
                        child: Text(
                          "Intermedio".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Intermedio".toUpperCase()
                            ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
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
                            ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
                            : Colors.grey,
                        child: Text(
                          "Dudoso".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Dudoso".toUpperCase()
                            ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            widget._jugador.nivel = "Dudoso".toUpperCase();
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
                            ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
                            : Colors.grey,
                        child: Text(
                          "Bajo".toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        textColor: Colors.black,
                        splashColor: widget._jugador.nivel.toUpperCase()  == "Bajo".toUpperCase()
                            ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
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
                                ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                : Colors.grey,
                            child: Text(
                              "N/A",
                              style: TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            textColor: Colors.black,
                            splashColor: widget._jugador.nivel.toUpperCase()  == "N/A"
                                ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                widget._jugador.nivel = "N/A";
                              });
                            },
                          )),
                      SizedBox(
                          width: 105, // specific value
                          child: RaisedButton.icon(
                            color: Colors.white,
                            icon: Icon(CustomIcon.eraser, color: Colors.black,size: 15),
                              label: Text(
                              "limpiar".toUpperCase(),
                              style: TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            textColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                widget._jugador.nivel = "";

                              });
                            },
                          )),
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
                                  color: widget._jugador.nivel2.toUpperCase() == "Superlativo".toUpperCase()
                                      ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Superlativo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2.toUpperCase() == "Superlativo".toUpperCase()
                                      ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Superlativo".toUpperCase();

                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2.toUpperCase() == "Superior".toUpperCase()
                                      ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Superior".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2.toUpperCase() == "Superior".toUpperCase()
                                      ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Superior".toUpperCase();
                                    });

                                  },
                                )),

                            Container(
                              width: 2,
                            ),
                            SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel2.toUpperCase() == "Destacado".toUpperCase()
                                    ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor: widget._jugador.nivel2.toUpperCase() == "Destacado".toUpperCase()
                                    ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel2 = "Destacado".toUpperCase();
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
                                  color: widget._jugador.nivel2.toUpperCase() == "Intermedio".toUpperCase()
                                      ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Intermedio".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2.toUpperCase() == "Intermedio".toUpperCase()
                                      ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "Intermedio".toUpperCase();
                                    });

                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel2.toUpperCase() == "Dudoso".toUpperCase()
                                      ?  Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2.toUpperCase() == "Dudoso".toUpperCase()
                                      ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
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
                                  color: widget._jugador.nivel2.toUpperCase() == "Bajo".toUpperCase()
                                      ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2.toUpperCase() == "Bajo".toUpperCase()
                                      ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
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
                                      ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "N/A",
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel2 == "N/A"
                                      ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "N/A";
                                    });
                                  },
                                )),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton.icon(
                                  color: Colors.white,
                                  icon: Icon(CustomIcon.eraser, color: Colors.black,size: 15),
                                  label: Text(
                                    "limpiar".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel2 = "";

                                    });
                                  },
                                )),
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
                                  color: widget._jugador.nivel3.toUpperCase() == "Superlativo".toUpperCase()
                                      ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Superlativo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3.toUpperCase() == "Superlativo".toUpperCase()
                                      ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Superlativo".toUpperCase();

                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3.toUpperCase() == "Superior".toUpperCase()
                                      ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Superior".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3.toUpperCase() == "Superior".toUpperCase()
                                      ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Superior".toUpperCase();
                                    });

                                  },
                                )),

                            Container(
                              width: 2,
                            ),
                            SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel3.toUpperCase() == "Destacado".toUpperCase()
                                    ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor: widget._jugador.nivel3.toUpperCase() == "Destacado".toUpperCase()
                                    ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel3 = "Destacado".toUpperCase();
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
                                  color: widget._jugador.nivel3.toUpperCase() == "Intermedio".toUpperCase()
                                      ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Intermedio".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3.toUpperCase() == "Intermedio".toUpperCase()
                                      ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "Intermedio".toUpperCase();
                                    });

                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel3.toUpperCase() == "Dudoso".toUpperCase()
                                      ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3.toUpperCase()== "Dudoso".toUpperCase()
                                      ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
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
                                  color: widget._jugador.nivel3.toUpperCase() == "Bajo".toUpperCase()
                                      ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3.toUpperCase()== "Bajo".toUpperCase()
                                      ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
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
                                      ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "N/A",
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel3 == "N/A"
                                      ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "N/A";
                                    });
                                  },
                                )),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton.icon(
                                  color: Colors.white,
                                  icon: Icon(CustomIcon.eraser, color: Colors.black,size: 15),
                                  label: Text(
                                    "limpiar".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel3 = "";

                                    });
                                  },
                                )),
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
                                  color: widget._jugador.nivel4.toUpperCase() == "Superlativo".toUpperCase()
                                      ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Superlativo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4.toUpperCase() == "Superlativo".toUpperCase()
                                      ? Player.nivelColorSuperlativo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Superlativo".toUpperCase();

                                    });
                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4.toUpperCase() == "Superior".toUpperCase()
                                      ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Superior".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4.toUpperCase() == "Superior".toUpperCase()
                                      ? Player.nivelColorSuperior(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Superior".toUpperCase();
                                    });

                                  },
                                )),

                            Container(
                              width: 2,
                            ),
                            SizedBox(
                              width: 105, // specific value
                              child: RaisedButton(
                                color: widget._jugador.nivel4.toUpperCase() == "Destacado".toUpperCase()
                                    ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                child: Text(
                                  "Destacado".toUpperCase(),
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                                textColor: Colors.black,
                                splashColor: widget._jugador.nivel4.toUpperCase() == "Destacado".toUpperCase()
                                    ? Player.nivelColorDestacado(widget._jugador.nivel.toUpperCase())
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    widget._jugador.nivel4 = "Destacado".toUpperCase();
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
                                  color: widget._jugador.nivel4.toUpperCase() == "Intermedio".toUpperCase()
                                      ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Intermedio".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4.toUpperCase() == "Intermedio".toUpperCase()
                                      ? Player.nivelColorIntermedio(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "Intermedio".toUpperCase();
                                    });

                                  },
                                )),
                            Container(
                              width: 2,
                            ),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton(
                                  color: widget._jugador.nivel4.toUpperCase() == "Dudoso".toUpperCase()
                                      ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Dudoso".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4.toUpperCase() == "Dudoso".toUpperCase()
                                      ? Player.nivelColorDudoso(widget._jugador.nivel.toUpperCase())
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
                                  color: widget._jugador.nivel4.toUpperCase() == "Bajo".toUpperCase()
                                      ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "Bajo".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4.toUpperCase() == "Bajo".toUpperCase()
                                      ? Player.nivelColorBajo(widget._jugador.nivel.toUpperCase())
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
                                      ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  child: Text(
                                    "N/A",
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: widget._jugador.nivel4 == "N/A"
                                      ? Player.nivelColorNA(widget._jugador.nivel.toUpperCase())
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "N/A";
                                    });
                                  },
                                )),
                            SizedBox(
                                width: 105, // specific value
                                child: RaisedButton.icon(
                                  color: Colors.white,
                                  icon: Icon(CustomIcon.eraser, color: Colors.black,size: 15),
                                  label: Text(
                                    "limpiar".toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                  textColor: Colors.black,
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      widget._jugador.nivel4 = "";

                                    });
                                  },
                                )),
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

