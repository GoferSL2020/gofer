import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


class Ofensivas extends StatefulWidget {
   Ofensivas( this._jugador);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Ofensivas();
  }

  final Jugador _jugador;

}

class _Ofensivas extends State<Ofensivas> {

  int letrasAux=Config.letrasPalabra;

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
              padding: EdgeInsets.all(1.0),
              child: Texto(Colors.white,"Características generales ofensivas".toUpperCase()
                  ,10, Colors.black, false)),

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
      caract=Jugador.porteroOfensivas;
     else  if(widget._jugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Jugador.lateralOfensivas;
    else  if(widget._jugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Jugador.carrileroOfensivas;
     else if(widget._jugador.posicion.toUpperCase().contains("DEFENSA"))
       caract=Jugador.centralOfensivas;
     else if(widget._jugador.posicion.toUpperCase().contains("CENTRAL"))
       caract=Jugador.centralOfensivas;
     else  if(widget._jugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Jugador.medioOfensivas;
    else  if(widget._jugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Jugador.medioOfensivas;
    else  if(widget._jugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Jugador.medioOfensivas;
     else  if(widget._jugador.posicion.toUpperCase().contains("PIVOTE"))
       caract=Jugador.medioOfensivas;
     else  if(widget._jugador.posicion.toUpperCase().contains("VOLANTE"))
       caract=Jugador.medioOfensivas;
     else  if(widget._jugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Jugador.delanteroOfensivas;
    else  if(widget._jugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Jugador.delanteroOfensivas;
     else  if(widget._jugador.posicion.toUpperCase().contains("EXTREMO"))
      caract=Jugador.extremoOfensivas;
    else
     caract=Jugador.todosOfensivas;
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
          value: Jugador.dameElValor(doc, widget._jugador),
          onChanged: (newValue) {
          setState(() {
          Jugador.poneElValor(doc, newValue,  widget._jugador);
          });
          },
          activeTrackColor: Colors.blue[900],
          activeColor: Colors.blue[900],
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

