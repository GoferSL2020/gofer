
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/categoria.dart';

import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';

import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/scout.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import '../../my_flutter_app_icons.dart';

class AddPartido extends StatefulWidget {
  final Partido partido;
  final Temporada temporada;
  final Pais pais;
  final Jornada jornada;
  final Categoria categoria;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  AddPartido(
      {@required this.partido,
        @required this.categoria,
        @required this.pais,
        @required this.jornada,
        @required this.temporada});

  @override
  _AddPartidoState createState() => new _AddPartidoState();
}

class _AddPartidoState extends State<AddPartido> {
  final _formKey = GlobalKey<FormState>();
  String _equipo1 = "";
  String _equipo2 = "";

  List<String> equipos1 = List();
  List<Equipo> equipos2 = List();
  final dao = new CRUDEquipo();
  final dao2 = new CRUDCategoria();

  @override
  void initState() {
    cogerEquipos();
    cogerScouting();
    //_equipo1=_equipo1[0];
    // TODO: implement initState
    super.initState();
  }


  String _observador = "";
  List<String> _observadores = List();
  List<Scout> _observadoresAUX = List();

  String _accion = "";
  List<String> _acciones = <String>[
    '', //45, 90
    'EVALUAR', //45, 90
    'SIN IMÁGENES', //45, 90
    'SIN VISUALIZAR', //40, 80
    'APLAZADO', //35 ,70
  ];

  String _golesCasa = "";
  String _golesFuera = "";
  List<String> _goles = <String>[
    '', //45, 90
    '0', //45, 90
    '1', //45, 90
    '2', //45, 90
    '3', //40, 80
    '4', //35 ,70
    '5', //35 ,70
    '6', //35 ,70
    '7', //35 ,70
    '8', //35 ,70
    '9', //35 ,70
    '10', //35 ,70
    '11', //35 ,70
  ];


  cogerScouting() async {
    _observadores.clear();
    _observadoresAUX =
    await dao2.fetchScouting(widget.temporada, widget.pais, widget.categoria);
    print(_observadoresAUX.length);
    _observadores.add("");
    for (var d in _observadoresAUX) {
      setState(() {
        _observadores.add(d.scout);
      });
    }
  }



  cogerEquipos() async {
    equipos2.clear();
    equipos1.clear();
    equipos2 =
    await dao.fetchEquipos(widget.temporada, widget.pais, widget.categoria);
    equipos1.add("");
    for (var d in equipos2) {
      setState(() {
        equipos1.add(d.equipo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FormField inputObservaciones = new FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: "Selecciona el scouter",
            ),
            isEmpty: _observador == '',
            child: new DropdownButtonFormField(
              items: _observadores.map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              value: _observador,
              validator: (value) => value == null ? 'Poner el scouter' : null,
              isDense: true,
              onChanged: (value) {
                _observador = value;
                state.didChange(value);
              },
            ),
          );
        });

    FormField inputAccion = new FormField(builder: (FormFieldState state) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: "Selecciona la accion",
        ),
        isEmpty: _accion == '',
        child: new DropdownButtonFormField(
          items: _acciones.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: _accion,
          validator: (value) => value == null ? 'Poner la accion' : null,
          isDense: true,
          onChanged: (value) {
            _accion = value;
            state.didChange(value);
          },
        ),
      );
    });
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 50,
                    child: IconButton(
                      icon:
                      new Image.asset(Config.icono),

                      onPressed: () {
                        //var a = singOut();
                        //if (a != null) {

                        //}
                      },
                    ))
              ]
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout -Jornada",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Abajo(temporada: widget.temporada,),
      body:
      ListView(
          children: <Widget>[
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.black,
              child: Text(
                widget.temporada.temporada,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Config.colorAPP,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              width: double.infinity,
              height: 20,
              color: Colors.black,
              child: Text(
                "Jornada: ${widget.jornada.jornada.toString()} - ${widget
                    .jornada.fecha.toString()}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Config.colorAPP,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              width: double.infinity,
              height: 20,
              color: Colors.black,
              child: Text(
                widget.categoria.categoria,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Config.colorAPP,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text('CASA',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Config.color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                equipos1.isEmpty != null ? new Container(
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(
                            top: 15, left: 25.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all()),
                        //isEmpty: _equipo1 == null,
                        child: new DropdownButton(
                          icon: Icon(Icons.arrow_drop_down, size: 30,
                            color: Colors.black,),
                          value: _equipo1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,

                            fontWeight: FontWeight.normal,
                          ),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _equipo1 = newValue;
                            });
                          },
                          items: equipos1.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(width: 5,),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(
                            top: 15, left: 25.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all()),
                        //isEmpty: _equipo1 == null,
                        child: new DropdownButton(
                          icon: Icon(Icons.arrow_drop_down, size: 30,
                            color: Colors.black,),
                          value: _golesCasa,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,

                            fontWeight: FontWeight.normal,
                          ),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _golesCasa = newValue;
                            });
                          },
                          items: _goles.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                Container(
                  padding: EdgeInsets.only(top: 0),
                  width: double.infinity,
                  child: Text('FUERA',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Config.color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                equipos1.isEmpty != null ? new Container(
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(
                            top: 15, left: 25.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all()),
                        //isEmpty: _equipo1 == null,
                        child: new DropdownButton(
                          icon: Icon(Icons.arrow_drop_down, size: 30,
                            color: Colors.black,),
                          value: _equipo2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.normal,
                          ),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _equipo2 = newValue;
                            });
                          },
                          items: equipos1.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(width: 5,),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(
                            top: 15, left: 25.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all()),
                        //isEmpty: _equipo1 == null,
                        child: new DropdownButton(
                          icon: Icon(Icons.arrow_drop_down, size: 30,
                            color: Colors.black,),
                          value: _golesFuera,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,

                            fontWeight: FontWeight.normal,
                          ),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _golesFuera = newValue;
                            });
                          },
                          items: _goles.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                Padding(
                    padding: EdgeInsets.only(left: 20, top: 0, right: 20,bottom: 20),
                    child: inputObservaciones
                ),

                RaisedButton.icon(
                  onPressed: () {
                    CRUDPartido dao = new CRUDPartido();
                    widget.partido.equipoCASA = _equipo1;
                    widget.partido.equipoFUERA = _equipo2;
                    widget.partido.golesCASA = _golesCasa;
                    widget.partido.golesFUERA = _golesFuera;
                    widget.partido.observador = _observador;
                    widget.partido.fecha = widget.jornada.fecha;
                    widget.partido.jornada = widget.jornada.jornada;
                      widget.partido.resultado = "";
                    if (widget.partido.equipoFUERA == widget.partido.equipoCASA) {
                      Fluttertoast.showToast(
                          msg: "Los dos equipos son el mismo",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red.shade900,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                      else{
                      try {
                        dao.addPartido(
                            widget.temporada, widget.pais, widget.categoria,
                            widget.jornada, widget.partido);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Se ha grabado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "No se ha grabado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red.shade900,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }
                    }
                  },
                  label: Text("Aceptar",
                    style: TextStyle(color: Colors.white, fontSize: 12),),
                  icon: Icon(Icons.save, size: 20, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.black,
                  color: Colors.grey.shade700,),
              ]),
            )
          ]),

    );
  }
}
