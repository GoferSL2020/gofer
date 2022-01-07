
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:toggle_switch/toggle_switch.dart';



class CapacidadesFisico extends StatefulWidget {
  CapacidadesFisico(this._jugador);
  final Player _jugador;
  @override
  _CapacidadesFisico createState() => _CapacidadesFisico();
}

class _CapacidadesFisico extends State<CapacidadesFisico> {
  @override
  double _crossAxisSpacing = 8, _mainAxisSpacing = 2, _aspectRatio = 4;
  int _crossAxisCount = 2;
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [

            Container(
                color: Colors.black,
                padding: EdgeInsets.all(15.0),
                child: Texto(
                    Colors.white,
                    "Características generales Fisico".toUpperCase(),
                    12,
                    Colors.black,
                    false)),
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10,top:5),
                    child: Texto(Colors.blue[900], "Envergadura".toUpperCase(), 12,
                        Colors.white, false)),
                Container(
                    padding: EdgeInsets.all(0.0),
                    child: ToggleSwitch(
                      minWidth: 350,
                      initialLabelIndex:
                      Config.getValue(widget._jugador.fis_envergadura),
                      activeBgColor: Colors.blue[900],
                      inactiveBgColor: Colors.grey[300],
                      inactiveFgColor: Colors.black,
                      fontSize: 10,
                      labels: ['Bajo', 'Media', 'Alta'],
                      onToggle: (index) {

                        setState(() {
                          widget._jugador.fis_envergadura =
                          Config.envergaduraFisica[index];
                        });
                      },
                    )),

            Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: new Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(220),
                  1: FixedColumnWidth(70),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: ponerFila2col(),
              ),
            ),
          ])),
    );
  }

  List<TableRow> ponerFila2col() {
    List<String> caract;
    if (widget._jugador.posicion.toUpperCase().contains("PORTERO"))
      caract = Player.porteroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("LATERAL"))
      caract = Player.lateralFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("CARRILERO"))
      caract = Player.carrileroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("DEFENSA"))
      caract = Player.centralFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("CENTRAL"))
      caract = Player.centralFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("MEDIO"))
      caract = Player.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("INTERIOR"))
      caract = Player.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("VOLANTE"))
      caract = Player.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract = Player.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("PIVOTE"))
      caract = Player.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("DELANTERO"))
      caract = Player.delanteroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("PUNTA"))
      caract = Player.delanteroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("EXTREMO"))
      caract = Player.extremoFisico;
    else
      caract = Player.todosFisico;
    List<TableRow> rows = new List<TableRow>();
    for (String doc in caract) {
      rows.add(TableRow(children: [
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
            });
          },
          activeTrackColor: Colors.blue[900],
          activeColor:Colors.blue[900],
        ),
      ]));
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
