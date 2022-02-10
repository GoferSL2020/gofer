
import 'package:flutter/material.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/view/entrenadores/scouting/tabEntrenadores.dart';
import 'package:iadvancedscout/wigdet/texto.dart';



class ComponenteConceptual extends StatefulWidget {
  ComponenteConceptual(this._entrenador,this._padre);


  final TabEntrenadores _padre;
  final Entrenador _entrenador;
  @override
  _ComponenteConceptual createState() => _ComponenteConceptual();
}

class _ComponenteConceptual extends State<ComponenteConceptual> {
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
                    "Componente CONCEPTUAL".toUpperCase(),
                    12,
                    Colors.black,
                    false)),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5),
                  child:Text("Estructural Habitual",
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
                    children: ponerFila2col(Entrenador.estructuralHabitual, 0, 4),
                  ),
                  new Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(65),
                      1: FixedColumnWidth(55),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: ponerFila2col(Entrenador.estructuralHabitual, 4,7),
                  ),
                    new Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(65),
                        1: FixedColumnWidth(55),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: ponerFila2col(Entrenador.estructuralHabitual,  7,10),
                    ),
                ],)
            ),
                Container(
                  width: double.infinity,
                  color:Colors.grey.shade800,
                  padding: EdgeInsets.all(5),
                  child:Text("Planteamiento Táctico General",
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
                          children: ponerFila2col(Entrenador.planteamientoTacticoGeneral, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(65),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.planteamientoTacticoGeneral, 1,2),
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
                  padding: EdgeInsets.all(5),
                  child:Text("Estructuración Juego Colectivo",
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
                  child:Text("Adaptabilidad Juego Colectivo",
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
                            0: FixedColumnWidth(130),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.adaptabilidadJuegoColectivo, 0, 1),
                        ),
                        new Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(120),
                            1: FixedColumnWidth(55),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: ponerFila2col(Entrenador.adaptabilidadJuegoColectivo, 1,2),
                        ),
                      ],)
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
              widget._padre.cambio=true;
            });
          },
          activeTrackColor: Colors.blue,
          activeColor:Colors.blue,
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
              fontSize: 11,
            )),
        Switch(
          value: Entrenador.dameElValor(caract[i],  widget._entrenador),
          onChanged: (newValue){
            setState(() {
              Entrenador.poneElValor(caract[i], newValue, widget._entrenador);
              widget._padre.cambio=true;
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
