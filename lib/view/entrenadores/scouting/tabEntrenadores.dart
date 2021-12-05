import 'package:flutter/cupertino.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDEntrenador.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';

import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/entrenadores/scouting/componenteConceptual.dart';
import 'package:iadvancedscout/view/entrenadores/scouting/componenteFormal.dart';
import 'package:iadvancedscout/view/entrenadores/scouting/componenteFuncional.dart';

import 'package:iadvancedscout/view/equipos/equiposView.dart';
import 'package:iadvancedscout/view/jugadores/scouting/cualidadesPsicologia.dart';
import 'package:iadvancedscout/view/jugadores/scouting/defensivas.dart';
import 'package:iadvancedscout/view/jugadores/scouting/nivel.dart';
import 'package:iadvancedscout/view/jugadores/scouting/ofensivas.dart';


import 'package:iadvancedscout/modelo/categoria.dart';

import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/view/jugadores/scouting/observaciones.dart';

import 'package:flutter/material.dart';


class TabEntrenadores extends StatefulWidget {
  final Equipo equipo;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Entrenador entrenador;
  @override
  TabEntrenadoresState createState() =>
      TabEntrenadoresState();
  TabEntrenadores(this.equipo, this.temporada, this.categoria, this.pais, this.entrenador
     );
}

class TabEntrenadoresState extends State<TabEntrenadores> {
  int _selectedIndex = 0;
  GlobalKey<TabEntrenadoresState> _myTabEntrenadoresKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
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
                  Text("${widget.entrenador.entrenador.toUpperCase()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white,
                      )),
                  Text("${widget.categoria.categoria}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red,
                      )),
                  Text("${widget.equipo.categoria}",
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
                        text: 'Conceptual'),
                    new Tab(
                        icon: new Icon(CustomIcon.futbolista_2, size:25), text: 'Formal'),
                    new Tab(
                        icon: new Icon(CustomIcon.futbolista_4, size:25),
                        text: 'Funcional '),
                  ]),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              //backgroundColor: widget.jugador.getColor(),
              backgroundColor: Colors.blue[900],
              child: const Icon(CustomIcon.soccer_ball),
              onPressed: () {

                /*setState(() {
                  _showAlert(context,_myTabEntrenadoresKey);
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
                        builder: (BuildContext context) => EquiposView(pais: widget.pais, temporada: widget.temporada, categoria: widget.categoria),
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
                ComponenteConceptual(widget.entrenador),
                ComponenteFormal(widget.entrenador),
                ComponenteFuncional(widget.entrenador),
              ],
            ),
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
                  '¿Quieres grabar las caracteristicas de\n${widget.entrenador.entrenador.toUpperCase()}?'),
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
                CRUDEntrenador con = new CRUDEntrenador();
                con.updateEntrenadorDatos
                  (widget.temporada,widget.pais,widget.categoria,widget.equipo,widget.entrenador);
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
