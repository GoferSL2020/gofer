

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/conf/excelJugadores.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJornada.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/dao/CRUDPais.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/filtro/jugadoresFiltros.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:image_picker/image_picker.dart';


class FiltroJugadoresEstrella extends StatefulWidget {

  FiltroJugadoresEstrella() ;

  @override
  _FiltroJugadoresEstrellaState createState() => _FiltroJugadoresEstrellaState();
 }

class _FiltroJugadoresEstrellaState extends State<FiltroJugadoresEstrella> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  String niveles;
  String posicion;
  String temporada="2021-2022";
  String tipo;
  String categoria=" ";
  double _edad=15;
  double _edad2=45;
  bool isLoading = false;
  PickedFile _imageFile;
  String imageUrl;
  TextEditingController _nombre = TextEditingController();
  TextEditingController _lugar = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(15, 44);


  FirebaseDatabase _database = FirebaseDatabase.instance;

  Player jugadorFiltro;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  List<Temporada> temporadas = List();
  List<Pais> paises = List();
  List<Categoria> categorias = List();
  Temporada _temporadaAux = new Temporada();
  Pais _paisAux = new Pais();

  Categoria _categoriaAux = new Categoria();
  Jornada _jornadaAux = new Jornada(0,"");

  List<Jornada> jornadas = List();


  Future<List<String>> get temporadasAux async {
    CRUDTemporada dao = CRUDTemporada();
    QuerySnapshot docs = await dao.getDataCollection();

    List<Temporada> datos = List();
    Temporada t = new Temporada();
    t.id = '';
    t.temporada = '';
    datos.add(t);

    for (var d in docs.docs) {
      Temporada t = new Temporada();
      t.id = d.id;
      t.temporada = d.data()['temporada'];
      datos.add(t);
    }

    setState(() {
      _temporadaAux = datos[0];
      temporadas = datos;
    });
  }

  _cogerPais() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    paises.clear();
    jornadas.clear();
    List<Pais> datos = await CRUDPais().fetchPaises(_temporadaAux);
    setState(() {
      //print(datos[0].id);
      _paisAux = datos[0];
      paises.addAll(datos);
    });
  }

  _cogerCategorias() async {
    categorias.clear();
    jornadas.clear();
    List<Categoria> datos =
    await CRUDCategoria().fetchCategorias(_temporadaAux, _paisAux);
    setState(() {
      _categoriaAux = datos[0];
      categorias.addAll(datos);
    });
    _cogerJornadas();
  }

  _cogerJornadas() async {
    jornadas.clear();
    List<Jornada> datos =
    await CRUDJornada().fetchJornadas(_temporadaAux, _paisAux, categorias[0]);
    setState(() {
      _jornadaAux = datos[0];
      jornadas.addAll(datos);
    });
  }


  List<String> _posicion = <String>
  [ 'TODOS','PORTERO',
    'LATERAL DERECHO',
    'LATERAL IZQUIERDO',
    'CENTRAL',
    'CARRILERO DERECHO',
    'CARRILERO IZQUIERDO',
    'PIVOTE',
    'MEDIO CENTRO',
    'VOLANTE',
    'INTERIOR',
    'MEDIA PUNTA',
    'EXTREMO IZQUIERDO',
    'EXTREMO DERECHO',
    'DELANTERO'];
  List<String> _niveles= <String>
  [ " ",'N/A','Discreto',
    'Dudoso',
    'Intermedio',
    'Destacado',
    'Superior',
    'Superlativo',
  ];
  List<String> _tipo= <String>
  [ " "
  ];

  List<String> _temporadas= <String>
  ["2021-2022","2020-2021",
  ];

  @override
  void initState() {

    setState(() {
      temporadasAux;
      jugadorFiltro=new Player();
      jugadorFiltro.temporada="2021-2022";
      jugadorFiltro.posicion="TODOS";
      posicion="TODOS";
      jugadorFiltro.nivel="";
      jugadorFiltro.tipo="";
      niveles=" ";
      tipo=" ";

    });
    // TODO: implement initState



    super.initState();
  }



  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),
            onPressed: () {
              //var a = singOut();
              //if (a != null) {
              Navigator.of(context).pop();

              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => TemporadasPage(),
              ));

              //}
            },
          )
        ],
        backgroundColor: Colors.black,
        title: Text("IAScout - Filtro jugadores",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
          key: formkey,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
              Padding(
                  padding:
                  EdgeInsets.only( top: 5.0, left: 20, right:20, bottom: 5),
                  child: new Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(300.0),
                      },
                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      //border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona la temporada",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Temporada>(
                                hint: Text("Selecciona la temporada"),
                                value: _temporadaAux,
                                validator: (value) => value == null
                                    ? 'Selecciona la temporada'
                                    : null,
                                isDense: true,
                                onChanged: (Temporada value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _temporadaAux = value;
                                    jugadorFiltro.temporada=value.temporada;
                                    _cogerPais();

                                    state.didChange(value);
                                  });
                                },
                                items: temporadas.map((Temporada temp) {
                                  return DropdownMenuItem<Temporada>(
                                    value: temp,
                                    child: Text(
                                      temp.temporada,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ]),
                        TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona el pais",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Pais>(
                                hint: Text("Selecciona el pais"),
                                value: _paisAux,
                                validator: (value) =>
                                value == null ? 'Selecciona el pais' : null,
                                isDense: true,
                                onChanged: (Pais value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _paisAux = value;
                                    jugadorFiltro.pais=value.pais;
                                    _cogerCategorias();

                                    state.didChange(value);
                                  });
                                },
                                items: paises.map((Pais temp) {
                                  return DropdownMenuItem<Pais>(
                                    value: temp,
                                    child: Text(
                                      temp.pais,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ]),
                       /* TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona el categoria",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Categoria>(
                                hint: Text("Selecciona el categoria"),
                                value: _categoriaAux,
                                validator: (value) =>
                                value == null ? 'Selecciona el categoria' : null,
                                isDense: true,
                                onChanged: (Categoria value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _categoriaAux = value;
                                    jugadorFiltro.categoria=value.categoria;
                                    _cogerJornadas();
                                    state.didChange(value);
                                  });
                                },
                                items: categorias.map((Categoria temp) {
                                  return DropdownMenuItem<Categoria>(
                                    value: temp,
                                    child: Text(
                                      temp.categoria,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ]),*/
                        TableRow(children: [
                          FormField(builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Selecciona la jornada",
                              ),
                              //isEmpty: temporadasAux == null,
                              child: DropdownButtonFormField<Jornada>(
                                hint: Text("Selecciona la jornada"),
                                value: _jornadaAux,
                                validator: (value) =>
                                value == null ? 'Selecciona la jornada' : null,
                                isDense: true,
                                onChanged: (Jornada value) async {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _jornadaAux = value;
                                    jugadorFiltro.jornada=value.jornada;
                                    state.didChange(value);
                                  });
                                },
                                items: jornadas.map((Jornada temp) {
                                  return DropdownMenuItem<Jornada>(
                                    value: temp,
                                    child: Text("Jornada ${temp.jornada}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ]),
                      ])
              ),
            Container(
            height: 20,color:Colors.white,),
              Padding(
                padding:
                EdgeInsets.only(top: 0.0, left: 20, right: 20, bottom: 5),
                child: isLoading
                    ? CircularProgressIndicator()
                    :
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  RaisedButton.icon(
                      onPressed: () async {
                        Fluttertoast.showToast(
                            msg: "Espera...\nEstamos haciendo el \nfiltro",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 40,
                            backgroundColor: Colors.red.shade900,
                            textColor: Colors.white,
                            fontSize: 12.0);
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => JugadoresFiltroPage(jugadorFiltro,_categoriaAux,_temporadaAux,_paisAux, true),
                            ));

                          });
                          setState(() {
                            isLoading = false;
                          });

                        }catch(e){
                          setState(() {
                            isLoading=false;
                          });
                          e.toString();
                        }
                      },
                      label: Text(
                        "Aceptar",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      icon: Icon(
                        CustomIcon.search,
                        size: 20,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.black,
                      color: Colors.blue),
                  RaisedButton.icon(
                      onPressed: () async {
                        ExcelJugadores excel=ExcelJugadores(jugadorFiltro,_temporadaAux,_paisAux,_categoriaAux);
                        excel.generateExcel();

                      }  // _generateExcel(categorias);
                      ,
                      label: Text(
                        "Excel",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      icon: Icon(
                        CustomIcon.file_excel,
                        size: 20,
                        color: Colors.white,
                      ),
                      textColor: Colors.white,
                      splashColor: Colors.white,
                      color: Colors.black),
                ]),

              ),
                    Container(
                      height: 50,color:Colors.white,),
            ],
          )
          ),
      )
    );
  }

  List<TableRow> ponerFisico() {
    List<String> caract;
    if (jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract = Player.porteroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract = Player.lateralFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract = Player.carrileroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract = Player.centralFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract = Player.centralFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract = Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract = Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract = Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract = Player.medioFisico;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract = Player.delanteroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract = Player.delanteroFisico;
    else if (jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
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
          value: Player.dameElValor(doc, jugadorFiltro),
          onChanged: (newValue) {
            setState(() {
              Player.poneElValor(doc, newValue, jugadorFiltro);
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
    if(jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroDefensa;
    else if(jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralDefensa;
    else if(jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroDefensa;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoDefensa;
    else
      caract=Player.todosDefensa;
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
              value: Player.dameElValor(doc, jugadorFiltro),
              onChanged: (newValue) {
                setState(() {
                  Player.poneElValor(doc, newValue,  jugadorFiltro);
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
    if(jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroOfensivas;
    else if(jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralOfensivas;
    else if(jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroOfensivas;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoOfensivas;
    else
      caract=Player.todosOfensivas;
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
              value: Player.dameElValor(doc, jugadorFiltro),
              onChanged: (newValue) {
                setState(() {
                  Player.poneElValor(doc, newValue,  jugadorFiltro);
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
    if(jugadorFiltro.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.porteroPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.lateralPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.carrileroPsicologia;
    else if(jugadorFiltro.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.centralPsicologia;
    else if(jugadorFiltro.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.centralPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.medioPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.delanteroPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.delanteroPsicologia;
    else  if(jugadorFiltro.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.extremoPsicologia;
    else
      caract=Player.todosPsicologia;
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
              value: Player.dameElValor(doc, jugadorFiltro),
              onChanged: (newValue) {
                setState(() {
                  Player.poneElValor(doc, newValue,  jugadorFiltro);
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


}


