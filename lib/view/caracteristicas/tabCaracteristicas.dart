import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/view/caracteristicas/cualidadesPsicologia.dart';
import 'package:iadvancedscout/view/caracteristicas/defensivas.dart';
import 'package:iadvancedscout/view/caracteristicas/ofensivas.dart';
import 'package:iadvancedscout/view/categorias.dart';

import '../../wigdet/observaciones.dart';
import 'capacidadesFisico.dart';
import 'nivel.dart';

class TabCaracteristicas extends StatefulWidget {
  @override
  TabCaracteristicasState createState() =>
      TabCaracteristicasState();
  final Jugador _jugador;
  TabCaracteristicas(this._jugador);
}

class TabCaracteristicasState extends State<TabCaracteristicas> {
  int _selectedIndex = 0;
  GlobalKey<TabCaracteristicasState> _myTabCaracteristicasKey = GlobalKey();

  void ponerValue (String value){
    setState(() {
      widget._jugador.nivel=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 5,
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
              title: Column(
                children: [
                  Text("${widget._jugador.jugador.toUpperCase()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white,
                      )),
                  Text("${widget._jugador.posicion}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red,
                      )),
                ],
              ),
              elevation: 0,
              bottom: TabBar(
                  labelStyle: TextStyle(fontSize: 12.0), //For Selected tab

                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Config.colorAPP,
                  labelColor: Config.tabColor,
                  tabs: [
                    new Tab(
                        icon: new Icon(
                          CustomIcon.levantamiento_de_pesas,
                        ),
                        text: 'Físico'),
                    new Tab(
                        icon: new Icon(CustomIcon.futbolista_2, size:25), text: 'Defensivas'),
                    new Tab(
                        icon: new Icon(CustomIcon.futbolista_4, size:25),
                        text: 'Ofensivas '),
                    new Tab(
                        icon: new Icon(CustomIcon.head_side_virus),
                        text: 'Psicologicas'),
                    new Tab(
                        icon: new Icon(CustomIcon.star),
                        text: 'Nivel'),
                  ]),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              //backgroundColor: widget._jugador.getColor(),
              backgroundColor: Colors.blue[900],
              child: const Icon(CustomIcon.soccer_ball),
              onPressed: () {

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
                      Pais pais = Pais(widget._jugador.pais, null);
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => CategoriasPage(pais),
                      ));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Observaciones(widget._jugador),
                      ));
                    },
                  ),
                ],
              ),
            ),

            /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:
            BottomNavigationBar(backgroundColor: Colors.black,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Menú',
                ),BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Observaciones',
                ),

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white ,
              unselectedItemColor: Colors.white60,
              onTap: _onItemTapped,
            ),*/
            body: TabBarView(
              children: [
                CapacidadesFisico(widget._jugador),
                Defensivas(widget._jugador),
                Ofensivas(widget._jugador),
                CualidadesPsicologia(widget._jugador),
                Nivel(widget._jugador),
              ],
            ),
          )),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (_selectedIndex == 0) {
      Pais pais = Pais(widget._jugador.pais, null);
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => CategoriasPage(pais),
      ));
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => Observaciones(widget._jugador),
      ));
    }
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
                  '¿Quieres grabar las caracteristicas de\n${widget._jugador.jugador.toUpperCase()}?'),
              Container(
                height: 10,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',
                  style: TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {
                Navigator.pop(context, true);
                JugadorDao con = new JugadorDao();
                con.updateJugador(widget._jugador);
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

/*  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, Jugador jugador) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('ATENCIÓN', style: TextStyle(
            fontSize: 18, decoration: TextDecoration.underline,)),
          content:
          Column(children: [
            Container(height: 10,),
            Text('¿Quieres $action el jugador\n${jugador.apodo}?'),
            Container(height: 10,),
            Text('Eliminar los datos del jugador', style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              decoration: TextDecoration.underline,)),
            Container(height: 10,),
          ],),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',
                  style: TextStyle(fontSize: 16, color: Colors.green[900])),
              onPressed: () {
                Navigator.pop(context, true);
                return true; // showDialog() returns true
              },
            ),
            FlatButton(
              child: Text('Cancelar',
                style: TextStyle(fontSize: 16, color: Config.colorAPP),),
              onPressed: () {
                Navigator.pop(context, false);
                return false; // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }*/

  Future _showAlert(BuildContext context, Key _key) async {
     await showDialog<String>(
        context: context,
        builder: (context) {
       return StatefulBuilder(
           builder: (context, setState) {
         return CupertinoAlertDialog(
           content:
           Column(children: [
             Container( width: 400,
                    padding: EdgeInsets.all(5),
                    child: Text("NIVEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,

                        )),
                  ),

                  Row(children: [
                    SizedBox(
                        width: 105, // specific value
                        child: RaisedButton(
                          color: widget._jugador.nivel == "Superlativo"
                              ? Colors.green[900]
                              : Colors.grey,
                          child: Text(
                            "Superlativo",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.nivel == "Superlativo"
                              ? Colors.green[900]
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
                              ? Colors.green
                              : Colors.grey,
                          child: Text(
                            "Superior",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.nivel == "Superior"
                              ? Colors.green
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              widget._jugador.nivel = "Superior";
                            });
                            
                          },
                        )),

                  ]),
             Row(children: [
               SizedBox(
                 width: 105, // specific value
                 child: RaisedButton(
                   color: widget._jugador.nivel == "Destacado"
                       ? Colors.blue
                       : Colors.grey,
                   child: Text(
                     "Destacado",
                     style: TextStyle(color: Colors.black, fontSize: 12),
                   ),
                   textColor: Colors.black,
                   splashColor: widget._jugador.nivel == "Destacado"
                       ? Colors.blue
                       : Colors.grey,
                   onPressed: () {
                     setState(() {
                       widget._jugador.nivel = "Destacado";
                     });

                   },
                 ),
               ),
               Container(
                 width: 2,
               ),
               SizedBox(
                   width: 105, // specific value
                   child: RaisedButton(
                     color: widget._jugador.nivel == "Intermedio"
                         ? Colors.yellow
                         : Colors.grey,
                     child: Text(
                       "Intermedio",
                       style: TextStyle(color: Colors.black, fontSize: 12),
                     ),
                     textColor: Colors.black,
                     splashColor: widget._jugador.nivel == "Intermedio"
                         ? Colors.yellow
                         : Colors.grey,
                     onPressed: () {
                       setState(() {
                         widget._jugador.nivel = "Intermedio";
                       });

                     },
                   )),

             ]),
                  Row(children: [

                    SizedBox(
                        width: 105, // specific value
                        child: RaisedButton(
                          color: widget._jugador.nivel == "Dudoso"
                              ? Colors.orange
                              : Colors.grey,
                          child: Text(
                            "Dudoso",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.nivel == "Dudoso"
                              ? Colors.orange
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
                              ? Colors.red[900]
                              : Colors.grey,
                          child: Text(
                            "Bajo",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.nivel == "Bajo"
                              ? Colors.red[900]
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              widget._jugador.nivel = "Bajo";
                            });
                            
                          },
                        )),
                  ]),
                  Container( width: 400,
                    padding: EdgeInsets.all(5),
                    child: Text("TIPO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,

                        )),
                  ),

                  Row(children: [
                    SizedBox(
                        width: 50, // specific value
                        child: RaisedButton(
                          color: widget._jugador.tipo == "A"
                              ? Colors.green
                              : Colors.grey,
                          child: Text(
                            "A",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.tipo == "A"
                              ? Colors.green
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              widget._jugador.tipo = "A";
                            });
                            
                          },
                        )),

                      Container(
                      width: 2,
                    ),
                    SizedBox(
                        width: 50, // specific value
                        child: RaisedButton(
                          color: widget._jugador.tipo == "B"
                              ? Colors.green
                              : Colors.grey,
                          child: Text(
                            "B",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.tipo == "B"
                              ? Colors.green
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              widget._jugador.tipo = "B";
                            });
                            
                          },
                        )),
                    Container(
                      width: 2,
                    ),
                    SizedBox(
                        width: 50, // specific value
                        child: RaisedButton(
                          color
                              : Colors.grey,
                          child: Text(
                            "C",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          textColor: Colors.black,
                          splashColor: widget._jugador.tipo == "C"
                              ? Colors.green
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              widget._jugador.tipo = "C";
                            });
                            
                          },
                        )),
             ]),
             Row(children: [
               SizedBox(
                   width: 50, // specific value
                   child: RaisedButton(
                     color: widget._jugador.tipo == "D"
                         ? Colors.green
                         : Colors.grey,
                     child: Text(
                       "D",
                       style: TextStyle(color: Colors.black, fontSize: 12),
                     ),
                     textColor: Colors.black,
                     splashColor: widget._jugador.tipo == "D"
                         ? Colors.green
                         : Colors.grey,
                     onPressed: () {
                       setState(() {
                         widget._jugador.tipo = "D";
                       });

                     },
                   )),
               Container(
                 width: 2,
               ),
               SizedBox(
                   width: 50, // specific value
                   child: RaisedButton(
                     color: widget._jugador.tipo == "F"
                         ? Colors.green
                         : Colors.grey,
                     child: Text(
                       "F",
                       style: TextStyle(color: Colors.black, fontSize: 12),
                     ),
                     textColor: Colors.black,
                     splashColor: widget._jugador.tipo == "F"
                         ? Colors.green
                         : Colors.grey,
                     onPressed: () {
                       setState(() {
                         widget._jugador.tipo = "F";
                       });
                     },
                   )),
               Container(
                 width: 2,
               ),
               SizedBox(
                   width: 50, // specific value
                   child: RaisedButton(
                     color: widget._jugador.tipo == "E"
                         ? Colors.green
                         : Colors.grey,
                     child: Text(
                       "E",
                       style: TextStyle(color: Colors.black, fontSize: 12),
                     ),
                     textColor: Colors.black,
                     splashColor: widget._jugador.tipo == "E"
                         ? Colors.green
                         : Colors.grey,
                     onPressed: () {
                       setState(() {
                         widget._jugador.tipo = "E";
                       });
                     },
                   )),
                ]),
            ]),
           actions: <Widget>[
             FlatButton(
               child:  Text('Aceptar',style:TextStyle(fontSize: 16, color: Colors.green[900])),
               onPressed: () {
                 setState(() {
                 });
                 Navigator.of(context).pop(widget._jugador.nivel);
             }
             ),
           ],
         );
           },
       );
        },
     );

  }

}
