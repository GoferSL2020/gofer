import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/dao/categoriaDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/view/categorias.dart';


import 'package:iadvancedscout/view/categoriasList.dart';
import 'package:iadvancedscout/view/jugadores.dart';
import 'package:iadvancedscout/view/jugadoresJornada.dart';
import 'package:iadvancedscout/view/notaPuntosJornada.dart';

import 'package:iadvancedscout/view/paises.dart';

import 'package:iadvancedscout/model/categoria.dart';

import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/pais.dart';

import 'package:iadvancedscout/my_flutter_app_icons.dart';
import 'package:iadvancedscout/view/partidos/notaPuntuacionJornada.dart';
import 'package:iadvancedscout/view/temporadas.dart';

import 'package:iadvancedscout/wigdet/observaciones.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import 'package:flutter/material.dart';


class PuntacionesPartido extends StatefulWidget {
  final List<Player> jugadores;

  PuntacionesPartido({@required this.jugadores});
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PuntacionesPartidoState();
  }


}



class _PuntacionesPartidoState extends State<PuntacionesPartido> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CRUDJugador dao=CRUDJugador();
    return Scaffold(
                  body:
                    widget.jugadores!=null?
                    ListView.builder(
                      itemCount: widget.jugadores.length,
                      itemBuilder: (context, index)
                        {
                          print(widget.jugadores[index].jugador);
                          return
                            ListTile(
                              title: NotaPuntuacionJornada(jugador: widget.jugadores[index])
                            );
                        }
                    ):Container(
                      child:Center(
                        child:Text("Espera....",style: TextStyle(fontSize: 20,color: Colors.red),))
                    ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}