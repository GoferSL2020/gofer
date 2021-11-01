
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:flutter/material.dart';

class JugadoresList extends StatefulWidget {
  @override
  _JugadoresListState createState() => new _JugadoresListState();
  final List<Jugador> _listJugadores;
  JugadoresList(this._listJugadores){
    //print("JUAGORES:${_listJugadores}");
  }
}

class _JugadoresListState extends State<JugadoresList> {

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void pageJugador(BuildContext context, Jugador jugador) {
   /* if (jugador.posicion.toUpperCase().contains("CENTRAL")){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicasCentral(jugador),
      ));
    }else if(jugador.posicion.toUpperCase().contains("LATERAL")){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicasLateral(jugador),
      ));
    }else if(jugador.posicion.toUpperCase().contains("EXTREMO")){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicasExtremo(jugador),
      ));
    }else if(jugador.posicion.toUpperCase().contains("INTERIOR")){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicasInterior(jugador),
      ));
    }else if(jugador.posicion.toUpperCase().contains("PIVOTE")){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TabCaracteristicasPivote(jugador),
      ));
    }*/

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("IAScout - Jugadores",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
      ),
      key: scaffoldKey,
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Container(color:Colors.blue[900],
              padding: EdgeInsets.all(10.0),

              child: Texto(Colors.white, widget._listJugadores.isNotEmpty?
                      widget._listJugadores[0].equipo.toString().toUpperCase():
                      "Jugadores"
                  ,20, Colors.blue[900], false)),

          Expanded(
            child : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text('JUGADOR')),
                  DataColumn(label: Text('POSICIÓN')),
                ],
                rows:
                widget._listJugadores // Loops through dataColumnText, each iteration assigning the value to element
                    .map(
                  ((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                            Container(
                                width: 150, //SET width
                                child: Text(element.jugador,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )))),
                        DataCell(
                            Container(
                                width: 150, //SET width
                                child: Text(element.posicion,style: TextStyle(
                                  fontSize: 12,
                                )))),

                      ],
                      onSelectChanged: (newValue)  async {
                        pageJugador(context, element);
                      }
                  )),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
