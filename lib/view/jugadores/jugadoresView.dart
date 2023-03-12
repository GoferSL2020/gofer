import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iafootfeel/custom_icon_icons.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDJugador.dart';

import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/player.dart';

import 'package:iafootfeel/view/jugadores/scouting/tabEditJugador.dart';
import 'package:iafootfeel/wigdet/abajo.dart';

class JugadoresView extends StatefulWidget {
  final FiltroJugadores? _filtro;
  final Pais? _pais;
  JugadoresView(this._filtro, this._pais);

  @override
  _JugadoresViewState createState() => new _JugadoresViewState();
}

class _JugadoresViewState extends State<JugadoresView> {
  String contador = "";
  List<Player> jugador = <Player>[];
  List<Player> jugadorTODOS = <Player>[];
  final _filtrar = TextEditingController();
  final _posicion = TextEditingController();
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });
    setState(() {
      _cogerJugadores();
    });
    super.initState();
  }

  _getRequests() async {
    setState(() {
      _cogerJugadores();
    });
  }

  _cogerJugadores() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Player> datos;
    if (widget._filtro!.cantera!.contains("Sub") ||
        widget._filtro!.cantera!.contains("Absoluta")) {
      datos = await CRUDJugador()
          .fetchJugadoresFootFeelCanteraSelecciones(widget._filtro!);
    } else {
      if (widget._filtro!.firmado == true)
        datos = await CRUDJugador().fetchJugadoresFootFeel(widget._filtro!);
      else
        datos =
            await CRUDJugador().fetchJugadoresFootFeelCantera(widget._filtro!);
    }
    setState(() {
      jugador = datos;
      if (widget._filtro!.firmado == true)
        jugador.sort((a, b) => a.jugador.compareTo(b.jugador));
      else
        jugador.sort((a, b) => a.catCantera.compareTo(b.catCantera));
      for (var d in jugador) jugadorTODOS.add(d);
    });
  }

  cambiarJugadores() async {
    List<Player> datos;
    datos = await CRUDJugador().fetchJugadoresFootFeelTodos();
    for (var juga in datos) {
      if ((juga.nacionalidad2 != "") && (juga.nacionalidad2 != null) ){
        CRUDJugador().updateJugadorScouting(juga);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = new CRUDJugador();
    TextFormField inputNombre = TextFormField(
      controller: _filtrar,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Filtrar jugadores',
        fillColor: Colors.white,
        hoverColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          Icons.zoom_in,
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          jugador.clear();
          if (value.trim() == "") {
            for (var d in jugadorTODOS) {
              jugador.add(d);
            }
          }
          for (var d in jugadorTODOS) {
            if (d.jugador.toUpperCase().contains(value.toUpperCase(), 0)) {
              jugador.add(d);
            } else {
            }
          }

          // jugador = jugadorTODOS.where((element) => element.jugador.contains(value)).toList();
        });
      },
    );

    TextFormField inputPosicion = TextFormField(
      controller: _posicion,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Filtrar posición',
        fillColor: Colors.white,
        hoverColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          Icons.zoom_in,
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Incorrecto';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          jugador.clear();
          if (value.trim() == "") {
            for (var d in jugadorTODOS) {
              jugador.add(d);
            }
          }
          for (var d in jugadorTODOS) {
            if (d.posicion.toUpperCase().contains(value.toUpperCase(), 0)) {
              jugador.add(d);
            } else {

            }
          }

          // jugador = jugadorTODOS.where((element) => element.jugador.contains(value)).toList();
        });
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            Container(
                width: 50,
                child: IconButton(
                  icon: new Image.asset(Config.icono),
                  onPressed: () {},
                )),
          ],
          backgroundColor: Colors.black,
          title: Text(widget._filtro!.lugar!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Config.colorFootFeel,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          //backgroundColor: widget.jugador.getColor(),
          onPressed: () {
            Player jugador = new Player();
            if (BBDDService().getUserScout().puesto == "Agenda FootFeel")
              jugador.scouter = BBDDService().getUserScout().name;
            else
              jugador.scouter = widget._filtro!.scouter!;
            if (widget._pais!.pais !="") {
              jugador.pais = widget._pais!.pais;
              jugador.equipo = widget._filtro!.equipo!;
              if (widget._pais!.pais == "LALIGA") {
                if (widget._filtro!.cantera == "Senior")
                  jugador.competecion = "";
                else
                  jugador.competecion = widget._filtro!.cantera!;
                jugador.categoria = widget._filtro!.cantera!;
              } else {
                jugador.competecion = widget._filtro!.cantera!;
              }
            } else {
              jugador.pais = "";
              jugador.competecion = "";
              jugador.categoria = "";
              jugador.equipo = "";
            }

            Navigator.pop(context, true);

            Navigator.of(context)
                .push(
                  new MaterialPageRoute(
                      builder: (_) => TabEditJugador(
                          jugador, false, widget._filtro!, widget._pais!)),
                )
                .then((val) => val ? _getRequests() : null);
          },
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          tooltip: "Añadir un jugador",
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Abajo(),
                  ));
                },
              ),
            ],
          ),
        ),
        body: Container(
            child: Column(children: <Widget>[
          Container(
            height: 25,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              BBDDService().getUserScout().name +
                  " - " +
                  BBDDService().getUserScout().puesto,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            height: 25,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              "Jugadores (${jugador.length})",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            height: 1,
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, bottom: 10),
          ),
          Container(
              color: Colors.black,
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: inputNombre),
          Container(
              color: Colors.black,
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: inputPosicion),
          Container(
            height: 2,
            color: Colors.grey,
            padding: EdgeInsets.only(top: 10, bottom: 10),
          ),
          Visibility(
              visible: jugador.isNotEmpty,
              child: Flexible(
                  child: ListView.separated(
                      itemCount: jugador.length,
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                      itemBuilder: (buildContext, index) {
                        return Dismissible(
                            background: slideLeftBackground(),
                            //secondaryBackground: slideLeftBackground(),

                            key: Key(jugador![index].key),
                            confirmDismiss:
                                (DismissDirection dismissDirection) async {
                              switch (dismissDirection) {
                                case DismissDirection.endToStart:
                                  return await _showConfirmationDialog(
                                          context,
                                          'Eliminar el jugador',
                                          jugador[index]) ==
                                      true;
                                // case DismissDirection.startToEnd:
                                //  return await _showConfirmationDialog(context, 'Cambiar el jugador',jugadoresList[index]) == true;
                                case DismissDirection.horizontal:
                                case DismissDirection.vertical:
                                case DismissDirection.up:
                                case DismissDirection.down:
                                  assert(false);
                              }
                              return false;
                            },
                            onDismissed: (direction) {
                              //_showAlert(context,jugadoresList[index]);
                              // Remove the item from the data source.
                              //print(direction);
                              setState(() {
                                CRUDJugador con = new CRUDJugador();
                                con.removeJugador(jugador[index]);
                                jugador.removeAt(index);
                              });
                            },
                            child: ListTile(
                              onTap: () {
                                paginaJugador(context, jugador[index]);
                              },
                              tileColor: jugador[index].proceso == true
                                  ? Colors.grey.shade300
                                  : null,
                              title: Row(children: [
                                //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                Expanded(
                                  child: Text(
                                    jugador[index].jugador.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                              trailing: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 1, right: 5),
                                    height: 15.0,
                                    child: Text(
                                      jugador[index].firmado == true
                                          ? "${jugador[index].scouter}"
                                          : "",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  new Container(
                                    height: 15.0,
                                    padding: EdgeInsets.only(top: 1, right: 5),
                                    child: Text(
                                      "${jugador[index].categoria} ${jugador[index].catCantera}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Container(
                                        padding:
                                            EdgeInsets.only(top: 1, right: 5),
                                        height: 15.0,
                                        child: Text(
                                          "${jugador[index].equipo}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                    Text(
                                      jugador[index].posicion.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Config.edadSubSolo(
                                              jugador[index].fechaNacimiento) +
                                          "  ${jugador[index].categoriaEdad}",
                                      style: TextStyle(
                                          color: Config.edadColorSub(
                                              Config.edadSubSolo(jugador[index]
                                                  .fechaNacimiento)),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    /*     Text(
                                          jugador[index].key,
                                      style: TextStyle(
                                          color: Config.edadColorSub(
                                              Config.edadSub(jugador[index]
                                                  .fechaNacimiento)),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    )*/
                                    new Container(
                                      height: 3.0,
                                    ),

                                    Row(
                                      children: [
                                        new Container(
                                          width: 15.0,
                                          height: 15.0,
                                          decoration: new BoxDecoration(
                                              color: Player.nivelColor(
                                                  jugador[index].nivel),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.0)),
                                        ),
                                        new Container(
                                          width: 5.0,
                                        ),
                                        new Container(
                                          width: 15.0,
                                          height: 15.0,
                                          decoration: new BoxDecoration(
                                              color: Player.nivelColor(
                                                  jugador[index].nivel2),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.0)),
                                        ),
                                      ],
                                    ),
                                  ]),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: new Image.network(
                                    Config.escudoClubesFF(
                                        jugador[index].equipo),
                                    height: 35),
                              ),
                            ));
                      })))
        ])));
  }

  void paginaJugador(BuildContext context, Player jugador) {
    Navigator.pop(context, true);
    Navigator.of(context)
        .push(
          new MaterialPageRoute(
              builder: (_) =>
                  TabEditJugador(jugador, false, widget._filtro!, widget._pais!)),
        )
        .then((val) => val ? _getRequests() : null);
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green.shade900,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Cambiar el jugador",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red.shade900,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Eliminar el jugador",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(
      BuildContext context, String action, Player jugador) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return BBDDService().getUserScout().puesto == "FootFeel"
            ? CupertinoAlertDialog(
                title: Text('ATENCIÓN',
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    )),
                content: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    Text('¿Quieres $action el jugador\n${jugador.jugador}?'),
                    Container(
                      height: 10,
                    ),
                    Text('Eliminar los datos del jugador',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        )),
                    Container(
                      height: 10,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Aceptar',
                        style:
                            TextStyle(fontSize: 16, color: Colors.green.shade900)),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16, color: Config.colorAPP),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                       // showDialog() returns false
                    },
                  ),
                ],
              )
            : CupertinoAlertDialog(
                title: Text('ATENCIÓN',
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    )),
                content: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    Text('No puedes eliminar el \n${jugador.jugador}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        )),
                    Container(
                      height: 10,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Aceptar',
                        style:
                            TextStyle(fontSize: 16, color: Colors.green.shade900)),
                    onPressed: () {
                      Navigator.pop(context, false);

                    },
                  ),
                ],
              );
      },
    );
  }
}
