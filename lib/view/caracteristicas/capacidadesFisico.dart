
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CapacidadesFisico extends StatefulWidget {
  CapacidadesFisico(this._jugador);
  final Jugador _jugador;
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
                padding: EdgeInsets.all(1.0),
                child: Texto(
                    Colors.white,
                    "Características generales Fisico".toUpperCase(),
                    10,
                    Colors.black,
                    false)),
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                      labels: ['Baja', 'Media', 'Alta'],
                      onToggle: (index) {
                        widget._jugador.fis_envergadura =
                        Config.envergaduraFisica[index];
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
      caract = Jugador.porteroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("LATERAL"))
      caract = Jugador.lateralFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("CARRILERO"))
      caract = Jugador.carrileroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("DEFENSA"))
      caract = Jugador.centralFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("CENTRAL"))
      caract = Jugador.centralFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("MEDIO"))
      caract = Jugador.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("INTERIOR"))
      caract = Jugador.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract = Jugador.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("PIVOTE"))
      caract = Jugador.medioFisico;
    else  if(widget._jugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Jugador.medioFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("DELANTERO"))
      caract = Jugador.delanteroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("PUNTA"))
      caract = Jugador.delanteroFisico;
    else if (widget._jugador.posicion.toUpperCase().contains("EXTREMO"))
      caract = Jugador.extremoFisico;
    else
      caract = Jugador.todosFisico;
    List<TableRow> rows = new List<TableRow>();
    for (String doc in caract) {
      print("CARR:${doc}");
      rows.add(TableRow(children: [
        new Text(doc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
        Switch(
          value: Jugador.dameElValor(doc, widget._jugador),
          onChanged: (newValue) {
            setState(() {
              Jugador.poneElValor(doc, newValue, widget._jugador);
            });
          },
          activeTrackColor: Colors.blue[900],
          activeColor: Colors.blue[900],
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
