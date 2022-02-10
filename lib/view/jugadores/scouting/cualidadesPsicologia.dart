
import 'package:flutter/material.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/view/jugadores/scouting/tabCaracteristicas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


class CualidadesPsicologia extends StatefulWidget {
  @override
  _CualidadesPsicologia createState() => _CualidadesPsicologia();
  CualidadesPsicologia(this._jugador,this._padre);

  final Player _jugador;
  final TabCaracteristicas _padre;
}

class _CualidadesPsicologia extends State<CualidadesPsicologia> {
  @override
  double _crossAxisSpacing = 8, _mainAxisSpacing = 2, _aspectRatio = 4;
  int _crossAxisCount = 2;
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:new SingleChildScrollView(

          child:Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,

              children:[
                // NotaPuntos("Resolución ante paredes rivales", 2),
                Container(color:Colors.black,
                    padding: EdgeInsets.all(15.0),
                    child: Texto(Colors.white,"Características generales Psicologia".toUpperCase()
                        ,12 , Colors.black, false)),

                Container(padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: new Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(220),
                      1: FixedColumnWidth(70),
                    },
                    defaultVerticalAlignment:
                    TableCellVerticalAlignment.middle,
                    children:
                    ponerFila2col(),
                  ),
                ),
              ])
      ),
    );
  }

  List<TableRow> ponerFila2col() {
    List<String> caract;
    if(widget._jugador.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroPsicologia;
    else if(widget._jugador.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralPsicologia;
    else if(widget._jugador.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroPsicologia;
    else  if(widget._jugador.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoPsicologia;
    else
      caract=Player.todosPsicologia;
    List<TableRow> rows =new List<TableRow>();
    for (String doc in caract) {
      rows.add(
          TableRow(children: [
            new Text(doc,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,

                )),
            Switch(

              value: Player.dameElValor(doc, widget._jugador),

              onChanged: (newValue){
                setState(() {
                  Player.poneElValor(doc, newValue, widget._jugador);
                  widget._padre.cambio=true;
                });
              },
              activeTrackColor: Colors.blue[900],
              activeColor:Colors.blue[900],
            ),
          ])
      );
    }
    return rows;
  }

  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }

}



/*
Nivel técnico
Salida de balón
Pase largo/medio
Cambios de orientación
Bate líneas con pase interior
Conducción para dividir
Primer pase tras recuperación
Interviene en ABP´s
Finalización
 */




