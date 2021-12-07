import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/entredadorDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';

import 'package:iadvancedscout/view/equipos/equipoCardAux.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:provider/provider.dart';

class PuntuacionesPartidos extends StatefulWidget {
  final Equipo equipo;
  final Temporada temporada;
  final Categoria categoria;
  final Pais pais;
  final Player jugador;
  PuntuacionesPartidos(
      this.equipo, this.temporada, this.categoria, this.pais, this.jugador);
  @override
  _PuntuacionesPartidosState createState() => new _PuntuacionesPartidosState();
}

class _PuntuacionesPartidosState extends State<PuntuacionesPartidos> {
  double total;
  double promedio;

  List<Partido> _partidos;
  List<Partido> partidos;

  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });
    partidosJornada();
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  CRUDEquipo dao = CRUDEquipo();

  Future<List<Partido>> partidosJornada1() async {
    var partidos = dao.getEquipoPartidos(
        widget.temporada, widget.pais, widget.categoria, widget.equipo);
    await new Future.delayed(new Duration(seconds: 5));
    return partidos;
  }

   Future<List<Partido>> partidosJornada() async {
    partidos = await dao.getEquipoPartidos(
        widget.temporada, widget.pais, widget.categoria, widget.equipo);
    int longitudPuntuaciones = 0;
    for (var i = 0; i < partidos.length; i++) {
      partidos[i].putuacionJugadorPartido = new AccionPutuacionJugadorPartido();
      var imgequipo;
      if (partidos[i].equipoCASA == widget.equipo.equipo)
        partidos[i].putuacionJugadorPartido = await dao.getPuntosPartidos(
            widget.temporada,
            widget.pais,
            widget.categoria,
            widget.equipo,
            partidos[i],
            widget.jugador,
            "jugadoresCASA");
      else
        partidos[i].putuacionJugadorPartido = await dao.getPuntosPartidos(
            widget.temporada,
            widget.pais,
            widget.categoria,
            widget.equipo,
            partidos[i],
            widget.jugador,
            "jugadoresFUERA");

      await new Future.delayed(new Duration(seconds: 5));
      double aux = 0;
      try {
        aux = double.parse(partidos[i].putuacionJugadorPartido.putuacion);
        aux > 0 ? longitudPuntuaciones++ : null;
      } catch (o) {
        aux = 0;
      }
      total += aux;
    }
    promedio = total / longitudPuntuaciones;
    return partidos;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:
        Column(children: <Widget>[
          Expanded(
            child: jornadasPartidos(),
          ),
        ])
    );
  }

    Widget jornadasPartidos() {
    return FutureBuilder<List<Partido>>(
                future: partidosJornada(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                        child: Text(
                          "Espere...",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ));
                  }
                  if (snapshot.hasError) {
                    // return: show error widget
                  }
                  List<Partido> values = snapshot.data;
                  values.sort((a, b) => a.jornada.compareTo(b.jornada));
                  return ListView.builder(
                    itemCount: _partidos.length,
                    itemBuilder: (buildContext, index) =>
                        Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 0, bottom: 0),
                          child: Card(
                            color: Config.colorCard,
                            elevation: 5,
                            child: Container(
                              height: 130,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.9,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    color: Colors.blue.shade900,
                                    child: Center(
                                        child: Text(
                                          'Scouter: ${_partidos[index]
                                              .observador}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color: Colors.white),
                                        )),
                                  ),
                                  Container(
                                    height: 5,
                                  ),
                                  new Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(6),
                                        2: FlexColumnWidth(6),
                                        3: FlexColumnWidth(2),
                                      },
                                      defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          Image.network(
                                              Config.escudoClubes(
                                                  _partidos[index].equipoCASA),
                                              // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${widget.equipoDetails.equipo}.png?alt=media",
                                              height: 35),
                                          Text("${_partidos[index].equipoCASA}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                          Text(
                                              "${_partidos[index].equipoFUERA}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                          Image.network(
                                              Config.escudoClubes(
                                                  _partidos[index].equipoFUERA),
                                              // "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${widget.equipoDetails.equipo}.png?alt=media",
                                              height: 35),
                                        ]),
                                      ]),
                                  new Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(6),
                                        2: FlexColumnWidth(6),
                                        3: FlexColumnWidth(2),
                                      },
                                      defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          Container(),
                                          Text(
                                              _partidos[index].accion,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green.shade900,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                          Text(_partidos[index]
                                              .putuacionJugadorPartido
                                              .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green.shade900,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                          Container(),
                                          Container(),
                                          Text(
                                              _partidos[index].golesCASA != ""
                                                  ? "${_partidos[index]
                                                  .golesCASA}"
                                                  : "-",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green.shade900,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                          Text(
                                              _partidos[index].golesFUERA != ""
                                                  ? "${_partidos[index]
                                                  .golesFUERA}"
                                                  : "-",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green.shade900,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                          Container(),
                                        ]),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                  );
                });
    }

  }


