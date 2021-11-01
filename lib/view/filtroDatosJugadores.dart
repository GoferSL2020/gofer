import 'package:iadvancedscout/dao/jugadorDao.dart';

import 'package:iadvancedscout/model/jugador.dart';

import 'package:iadvancedscout/conf/config.dart';

import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'dart:async';
import 'package:iadvancedscout/service/LogoService.dart';

import 'package:flutter/services.dart';

import 'package:toggle_switch/toggle_switch.dart';

class FiltroDatosJugadores extends StatefulWidget {
  FiltroDatosJugadores(this._filtroJugador);
  final Jugador _filtroJugador;
  @override
  _FiltroDatosJugadores createState() => _FiltroDatosJugadores();
}

class _FiltroDatosJugadores extends State<FiltroDatosJugadores> {
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
           /* Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: new Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(220),
                  1: FixedColumnWidth(70),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: ponerFisico(),
              ),
            ),
                Texto(
                    Colors.white,
                    "Características generales Defensivas".toUpperCase(),
                    10,
                    Colors.black,
                    false),
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: new Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(220),
                      1: FixedColumnWidth(70),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: ponerDefensivo(),
                  ),
                ),
                Texto(
                    Colors.white,
                    "Características generales Ofensivas".toUpperCase(),
                    10,
                    Colors.black,
                    false),
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: new Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(220),
                      1: FixedColumnWidth(70),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: ponerOfensivos(),
                  ),
                ),
                Texto(
                    Colors.white,
                    "Características generales Psicologia".toUpperCase(),
                    10,
                    Colors.black,
                    false),
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: new Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(220),
                      1: FixedColumnWidth(70),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: ponerOfensivos(),
                  ),
                ),*/
          ])),
    );
  }

  List<TableRow> ponerFisico() {
    List<String> caract;
    if (widget._filtroJugador.posicion.toUpperCase().contains("PORTERO"))
      caract = Jugador.porteroFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("LATERAL"))
      caract = Jugador.lateralFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("CARRILERO"))
      caract = Jugador.carrileroFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("DEFENSA"))
      caract = Jugador.centralFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("CENTRAL"))
      caract = Jugador.centralFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("MEDIO"))
      caract = Jugador.medioFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("INTERIOR"))
      caract = Jugador.medioFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("VOLANTE"))
      caract = Jugador.medioFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract = Jugador.medioFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("PIVOTE"))
      caract = Jugador.medioFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("DELANTERO"))
      caract = Jugador.delanteroFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("PUNTA"))
      caract = Jugador.delanteroFisico;
    else if (widget._filtroJugador.posicion.toUpperCase().contains("EXTREMO"))
      caract = Jugador.extremoFisico;
    else
      caract = Jugador.todosFisico;
    List<TableRow> rows = new List<TableRow>();
    for (String doc in caract) {

      rows.add(TableRow(children: [
        new Text(doc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
        Switch(
          value: Jugador.dameElValor(doc, widget._filtroJugador),
          onChanged: (newValue) {
            setState(() {
              Jugador.poneElValor(doc, newValue, widget._filtroJugador);
            });
          },
          activeTrackColor: Colors.blue[900],
          activeColor: Colors.blue[900],
        ),
      ]));
    }
    return rows;
  }
  List<TableRow> ponerDefensivo() {
    List<String> caract;
    if(widget._filtroJugador.posicion.toUpperCase().contains("PORTERO"))
      caract=Jugador.porteroDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Jugador.lateralDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Jugador.carrileroDefensa;
    else if(widget._filtroJugador.posicion.toUpperCase().contains("DEFENSA"))
      caract=Jugador.centralDefensa;
    else if(widget._filtroJugador.posicion.toUpperCase().contains("CENTRAL"))
      caract=Jugador.centralDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Jugador.medioDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Jugador.medioDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Jugador.medioDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Jugador.medioDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("PIVOTE"))
      caract=Jugador.medioDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Jugador.delanteroDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Jugador.delanteroDefensa;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("EXTREMO"))
      caract=Jugador.extremoDefensa;
    else
      caract=Jugador.todosDefensa;
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
              value: Jugador.dameElValor(doc, widget._filtroJugador),
              onChanged: (newValue) {
                setState(() {
                  Jugador.poneElValor(doc, newValue,  widget._filtroJugador);
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

  List<TableRow> ponerOfensivos() {
    List<String> caract;
    if(widget._filtroJugador.posicion.toUpperCase().contains("PORTERO"))
      caract=Jugador.porteroOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Jugador.lateralOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Jugador.carrileroOfensivas;
    else if(widget._filtroJugador.posicion.toUpperCase().contains("DEFENSA"))
      caract=Jugador.centralOfensivas;
    else if(widget._filtroJugador.posicion.toUpperCase().contains("CENTRAL"))
      caract=Jugador.centralOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Jugador.medioOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Jugador.medioOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Jugador.medioOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Jugador.medioOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("PIVOTE"))
      caract=Jugador.medioOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Jugador.delanteroOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Jugador.delanteroOfensivas;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("EXTREMO"))
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
              value: Jugador.dameElValor(doc, widget._filtroJugador),
              onChanged: (newValue) {
                setState(() {
                  Jugador.poneElValor(doc, newValue,  widget._filtroJugador);
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

  List<TableRow> ponerPsicologia() {
    List<String> caract;
    if(widget._filtroJugador.posicion.toUpperCase().contains("PORTERO"))
      caract=Jugador.porteroPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Jugador.lateralPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Jugador.carrileroPsicologia;
    else if(widget._filtroJugador.posicion.toUpperCase().contains("DEFENSA"))
      caract=Jugador.centralPsicologia;
    else if(widget._filtroJugador.posicion.toUpperCase().contains("CENTRAL"))
      caract=Jugador.centralPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Jugador.medioPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Jugador.medioPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Jugador.medioPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Jugador.medioPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("PIVOTE"))
      caract=Jugador.medioPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Jugador.delanteroPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Jugador.delanteroPsicologia;
    else  if(widget._filtroJugador.posicion.toUpperCase().contains("EXTREMO"))
      caract=Jugador.extremoPsicologia;
    else
      caract=Jugador.todosPsicologia;
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
              value: Jugador.dameElValor(doc, widget._filtroJugador),
              onChanged: (newValue) {
                setState(() {
                  Jugador.poneElValor(doc, newValue,  widget._filtroJugador);
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
