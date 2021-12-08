
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:toggle_switch/toggle_switch.dart';
class ComponenteFuncional extends StatefulWidget {
   ComponenteFuncional(this._entrenador);

  @override
  _ComponenteFuncional createState() => _ComponenteFuncional();
  final Entrenador _entrenador;
}

class _ComponenteFuncional extends State<ComponenteFuncional> {
  @override
  double _crossAxisSpacing = 8, _mainAxisSpacing = 2, _aspectRatio = 4;
  int _crossAxisCount = 2;
  int letrasAux=Config.letrasPalabra;


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
                        "Componente FUNCIONAL".toUpperCase(),
                        12,
                        Colors.black,
                        false)),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Ofensivo (Inicio del juego)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.inicioDeJuego, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.inicioDeJuego, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.inicioDeJuego, 2, 3),
                        ),

                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Ofensivo Progresión/finalización del juego",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.progresionFinalizacioJuego, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(85),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.progresionFinalizacioJuego, 1, 2),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Transiciones defensivas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.transicionesDefensivas, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.transicionesDefensivas, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.transicionesDefensivas, 2, 3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Juego defensivo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.juegoDefensivo, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.juegoDefensivo, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.juegoDefensivo, 2, 3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5.0),
                  child:Text("Transiciones ofensivas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                            0: FixedColumnWidth(60),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.transicionesOfensivas, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(75),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.transicionesOfensivas, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.transicionesOfensivas, 2, 3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5),
                  child:Text("Ritmos de juego",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.ritmosDeJuego, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.ritmosDeJuego, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(70),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.ritmosDeJuego, 2, 3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5),
                  child:Text("Grados de libertad",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.gradosDeLibertad, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.gradosDeLibertad, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.gradosDeLibertad, 2, 3),
                        ),
                      ],)
                ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5),
                  child:Text("Variabilidad Estratégica (Local / Visitante)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          children: ponerFila2col(Entrenador.variabilidadEstrategeciaLocalVisitante, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.variabilidadEstrategeciaLocalVisitante, 1, 2),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.variabilidadEstrategeciaLocalVisitante, 2, 3),
                        ),
                      ],)
                ),
                Container(
                  height: 100,
                ),
              ])),
    );
  }


  List<TableRow> ponerFila2col(List<String> caract,int primero, int ultimo) {
    List<TableRow> rows = new List<TableRow>();
    for (int i=primero;i<ultimo;i++) {
      print("CARR:${caract[i]}");
      rows.add(TableRow(children: [
        new Text(caract[i],
            style: TextStyle(
              fontSize: 11,
            )),
        Switch(
          value: Entrenador.dameElValor(caract[i],  widget._entrenador),
          onChanged: (newValue){
            setState(() {
              Entrenador.poneElValor(caract[i], newValue, widget._entrenador);
            });
          },
          activeTrackColor: Colors.blue,
          activeColor:Colors.blue,
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
