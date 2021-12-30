import 'package:flutter/material.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/view/partidos/notaPuntuacionJornada.dart';


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