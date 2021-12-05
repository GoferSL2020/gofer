
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:toggle_switch/toggle_switch.dart';


class ComponenteFormal extends StatefulWidget {
  @override
  _ComponenteFormal createState() => _ComponenteFormal();
  final Entrenador _entrenador;
  ComponenteFormal(this._entrenador);
}

class _ComponenteFormal extends State<ComponenteFormal> {
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
                    padding: EdgeInsets.all(5.0),
                    child: Texto(
                        Colors.white,
                        "Componente FORMAL".toUpperCase(),
                        12,
                        Colors.black,
                        false)),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Ocupación racional del espacio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(105),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.ocupacionRacionalEspacio, 0, 3),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(105),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.ocupacionRacionalEspacio, 3,6),
                        ),

                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Asentamiento defensivo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.asentamientoDefensivo, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.asentamientoDefensivo, 1,2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.planteamientoTacticoGeneral,  2,3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Asentamiento ofensivo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.asentamientoOfensivo, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.asentamientoOfensivo, 1,2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.planteamientoTacticoGeneral,  2,3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Asentamiento espacio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(105),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.asentamientoEspacion, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(105),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.asentamientoEspacion, 1,2),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Espacios de intervención",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(130),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.estructuracionJuegoColectivo, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(120),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.estructuracionJuegoColectivo, 1,2),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5),
                  child:Text("Dinámica posicional",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(105),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.dinamicaPosicional, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(105),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.dinamicaPosicional, 1,2),
                        ),
                      ],)
                ),
                Container(
                  height: 100,
                ),
              ])),
    );
  }

  List<TableRow> ponerFila1col() {
    List<String> caract;
    caract = Entrenador.estructuralHabitual;
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
          value: false,
          onChanged: (newValue){
            setState(() {
              Entrenador.poneElValor(doc, newValue, widget._entrenador);
            });
          },
          activeTrackColor: Colors.blue.shade900,
          activeColor:Colors.blue.shade900,
        ),
      ]));
    }
    return rows;
  }

  List<TableRow> ponerFila2col(List<String> caract,int primero, int ultimo) {
    List<TableRow> rows = new List<TableRow>();
    for (int i=primero;i<ultimo;i++) {
      print("CARR:${caract[i]}");
      rows.add(TableRow(children: [
        new Text(caract[i],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
            )),
        Switch(
          value: Entrenador.dameElValor(caract[i],  widget._entrenador),
          onChanged: (newValue){
            setState(() {
              Entrenador.poneElValor(caract[i], newValue, widget._entrenador);
            });
          },
          activeTrackColor: Colors.blue.shade900,
          activeColor:Colors.blue.shade900,
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






