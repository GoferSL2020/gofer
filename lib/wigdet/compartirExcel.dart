import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJornada.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/dao/CRUDPais.dart';
import 'package:iadvancedscout/dao/CRUDPartido.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';
import 'package:iadvancedscout/dao/entredadorDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/futbol_mio_icons.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/modelo/EquipoCloud.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;

class CompartirExcel extends StatefulWidget {
  CompartirExcel();

  @override
  _CompartirExcelState createState() => _CompartirExcelState();
}

class _CompartirExcelState extends State<CompartirExcel> {
  final GlobalKey<FormState> formkey = new GlobalKey();

  bool isLoading = false;

  FirebaseDatabase _database = FirebaseDatabase.instance;



  @override
  void initState() {
    setState(() {
      temporadasAux;
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Temporada> temporadas = List();
  List<Pais> paises = List();
  List<Categoria> categorias = List();
  Temporada _temporadaAux = new Temporada();
  Pais _paisAux = new Pais();
  Categoria _categoriaAux = new Categoria();

 // List<Equipo> equipos = List();
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
    paises.clear();
    //print("PAIS");
    //print(_temporadaAux.id);
    List<Pais> datos = await CRUDPais().fetchPaises(_temporadaAux);
    setState(() {
      //print(datos[0].id);
      _paisAux = datos[0];
      paises.addAll(datos);
    });
  }

  _cogerCategorias() async {
    categorias.clear();
    List<Categoria> datos =
        await CRUDCategoria().fetchCategorias(_temporadaAux, _paisAux);
    Categoria c=new Categoria();
    c.id = '';
    c.categoria = 'TODOS';
    datos.add(c);
    setState(() {
      _categoriaAux = datos[0];
      categorias.addAll(datos);
    });
  }


  _cogerJornadas() async {
    CRUDJornada dao = CRUDJornada();
    List<Jornada> datos =
    await dao.fetchJornadas(_temporadaAux, _paisAux, _categoriaAux);
    setState(() {
      jornadas.addAll(datos);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: new Icon(FutbolMio.tactica_2)),
        ],
        backgroundColor: Colors.black,
        title: Text("IAClub - Migración",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(top: 5.0, left: 20, right: 20, bottom: 5),
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
                        TableRow(children: [
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
                        ]),
                      ])),
              Container(
                padding: EdgeInsets.only(left: 75,right: 75),
                color:Colors.white,
                child:

              SizedBox(width: 50,
                  child:
                RaisedButton.icon(
                    onPressed: () async {

                      if(_categoriaAux.categoria=="TODOS"){
                        print("TODOS");
                        _generateExcel(categorias);
                      }else{
                        List<Categoria> cat=[];
                        cat.add(_categoriaAux);
                        print("SIN TODOS");
                        _generateExcel(cat);
                      }
                     // getMigrarJugadores();
                      //getMigrarPuntuacionesRFEF();
                      //getMigrarPuntuacionesNuevo2Division();
                      //getMigrarJugadoresUPDATE();
                      //getMigrarNacionalidad();
                      //getMigrarNacionalidadEspanol();

                      //ponerExcelJugadores();
                      //getMigrarPuntuacionesNuevo();
                      //getCambiarTipoJugadores();
                      //getMigrarCiclo1();
                      //getMigrarPuntuacionesNuevo();
                      //getMigrarJugadores();
                    },
                    label: Text(
                      "Compartir",
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
              ),),
            ],
          )),
    );
  }


  String listaTiposLetraAux(String posicionAux) {
    if (posicionAux.contains("A"))
      return "1";
    else if (posicionAux.contains("B"))
      return "2";
    else if (posicionAux.contains("C"))
      return "3";
    else if (posicionAux.contains("D"))
      return "4";
    else if (posicionAux.contains("E"))
      return "5";
    else if (posicionAux.contains("F"))
      return "6";
    else
      return "";
  }

  String listaTiposAux(String posicionAux) {
    if (posicionAux.toUpperCase().contains("PORTERO"))
      return "P ";
    else if (posicionAux.toUpperCase().contains("LATERAL"))
      return "L ";
    else if (posicionAux.toUpperCase().contains("CARRILERO"))
      return "FB ";
    else if (posicionAux.toUpperCase().contains("DEFENSA"))
      return "CB ";
    else if (posicionAux.toUpperCase().contains("CENTRAL"))
      return "CB ";
    else if (posicionAux.toUpperCase().contains("MEDIO"))
      return "MF ";
    else if (posicionAux.toUpperCase().contains("INTERIOR"))
      return "MF ";
    else if (posicionAux.toUpperCase().contains("VOLANTE"))
      return "MF ";
    else if (posicionAux.toUpperCase().contains("CENTROCAMPISTA"))
      return "MF ";
    else if (posicionAux.toUpperCase().contains("PIVOTE"))
      return "MF ";
    else if (posicionAux.toUpperCase().contains("PUNTA"))
      return "MF ";
    else if (posicionAux.toUpperCase().contains("DELANTERO"))
      return "CF ";
    else if (posicionAux.toUpperCase().contains("EXTREMO"))
      return "WF ";
    else
      return "";
  }


  String puntuacionEstado(String puntuaciones) {
    if (puntuaciones=="A") return "A";
    if (puntuaciones=="T") return "T";
    if (puntuaciones=="S") return "SC";
    if (puntuaciones=="SC") return "SC";
    if (puntuaciones=="SIM") return "";
    if (puntuaciones=="SI") return "";
    if (puntuaciones=="SV") return "";
    if (puntuaciones=="NA") return "";
    if (puntuaciones=="EX") return "SC";
    return puntuaciones;

  }

String estadoPuntuacion(String puntuaciones) {
  if (puntuaciones=="A") return "A";
  if (puntuaciones=="T") return "T";
  if (puntuaciones=="S") return "S";
  if (puntuaciones=="SC") return "S";
  if (puntuaciones=="SI") return "SIM";
  if (puntuaciones=="SIM") return "SIM";
  if (puntuaciones=="SV") return "SV";
  if (puntuaciones=="NA") return "NA";
  if (puntuaciones=="EX") return "EX";
  return "";


}

  ponerCabecera(Worksheet sheet) {
    //Adding cell style.

    styleCabecera.backColor = '#D9E1F2';
    styleCabecera.hAlign = HAlignType.center;
    styleCabecera.vAlign = VAlignType.center;
    styleCabecera.bold = true;
    styleCabecera.wrapText=true;
    sheet.getRangeByName('A1:GL1').cellStyle = styleCabecera;

    styleCabecera2.backColor = '#F78B09';
    styleCabecera2.hAlign = HAlignType.center;
    styleCabecera2.vAlign = VAlignType.center;
    styleCabecera2.bold = true;
    styleCabecera2.wrapText=true;


    int columna=1;
      sheet.getRangeByIndex(1, columna).text = "id".toUpperCase();columna++;//idjugador,
      sheet.getRangeByIndex(1, columna).text = "jugador".toUpperCase();columna++;//_jugador,
      sheet.getRangeByIndex(1, columna).text = "equipo".toUpperCase();columna++;//_equipo,
      sheet.getRangeByIndex(1, columna).text = "temporada".toUpperCase();columna++;//_temporada,
      sheet.getRangeByIndex(1, columna).text = "categoria".toUpperCase();columna++;//_categoria,
      sheet.getRangeByIndex(1, columna).text = "dorsal".toUpperCase();columna++;//_dorsal,
      sheet.getRangeByIndex(1, columna).text = "lateral".toUpperCase();columna++;//_lateral,
      sheet.getRangeByIndex(1, columna).text = "posicion".toUpperCase();columna++;//_posicion,
      sheet.getRangeByIndex(1, columna).text = "posicion alternativa".toUpperCase();columna++;//_posicionalternativa,
      sheet.getRangeByIndex(1, columna).text = "pais".toUpperCase();columna++;//_pais,
      sheet.getRangeByIndex(1, columna).text = "fecha Nacimiento".toUpperCase();columna++;//_fechaNacimiento,
      sheet.getRangeByIndex(1, columna).text = "peso".toUpperCase();columna++;//_peso,
      sheet.getRangeByIndex(1, columna).text = "altura".toUpperCase();columna++;//_altura,
      sheet.getRangeByIndex(1, columna).text = "valor".toUpperCase();columna++;//_valor,
      sheet.getRangeByIndex(1, columna).text = "pais Nacimiento".toUpperCase();columna++;//_paisNacimiento,
      sheet.getRangeByIndex(1, columna).text = "ccaa".toUpperCase();columna++;//_ccaa,
      sheet.getRangeByIndex(1, columna).text = "nacionalidad".toUpperCase();columna++;//_nacionalidad,
      sheet.getRangeByIndex(1, columna).text = "contrato".toUpperCase();columna++;//_contrato,
      sheet.getRangeByIndex(1, columna).text = "fecha Contrato".toUpperCase();columna++;//_fechaContrato,
      sheet.getRangeByIndex(1, columna).text = "veredicto".toUpperCase();columna++;//_veredicto,
      sheet.getRangeByIndex(1, columna).text = "prestamo".toUpperCase();columna++;//_prestamo,

    sheet.getRangeByIndex(1, columna).text = "J. 1".toUpperCase();columna++;//_J. 1,
    sheet.getRangeByIndex(1, columna).text = "J. 2".toUpperCase();columna++;//_J. 2,
    sheet.getRangeByIndex(1, columna).text = "J. 3".toUpperCase();columna++;//_J. 3,
    sheet.getRangeByIndex(1, columna).text = "J. 4".toUpperCase();columna++;//_J. 4,
    sheet.getRangeByIndex(1, columna).text = "J. 5".toUpperCase();columna++;//_J. 5,
    sheet.getRangeByIndex(1, columna).text = "J. 6".toUpperCase();columna++;//_J. 6,
    sheet.getRangeByIndex(1, columna).text = "J. 7".toUpperCase();columna++;//_J. 7,
    sheet.getRangeByIndex(1, columna).text = "J. 8".toUpperCase();columna++;//_J. 8,
    sheet.getRangeByIndex(1, columna).text = "J. 9".toUpperCase();columna++;//_J. 9,
    sheet.getRangeByIndex(1, columna).text = "J. 10".toUpperCase();columna++;//_J. 10,
    sheet.getRangeByIndex(1, columna).text = "J. 11".toUpperCase();columna++;//_J. 11,
    sheet.getRangeByIndex(1, columna).text = "J. 12".toUpperCase();columna++;//_J. 12,
    sheet.getRangeByIndex(1, columna).text = "J. 13".toUpperCase();columna++;//_J. 13,
    sheet.getRangeByIndex(1, columna).text = "J. 14".toUpperCase();columna++;//_J. 14,
    sheet.getRangeByIndex(1, columna).text = "J. 15".toUpperCase();columna++;//_J. 15,
    sheet.getRangeByIndex(1, columna).text = "J. 16".toUpperCase();columna++;//_J. 16,
    sheet.getRangeByIndex(1, columna).text = "J. 17".toUpperCase();columna++;//_J. 17,
    sheet.getRangeByIndex(1, columna).text = "J. 18".toUpperCase();columna++;//_J. 18,
    sheet.getRangeByIndex(1, columna).text = "J. 19".toUpperCase();columna++;//_J. 19,
    sheet.getRangeByIndex(1, columna).text = "J. 20".toUpperCase();columna++;//_J. 20,
    sheet.getRangeByIndex(1, columna).text = "J. 21".toUpperCase();columna++;//_J. 21,
    sheet.getRangeByIndex(1, columna).text = "J. 22".toUpperCase();columna++;//_J. 22,
    sheet.getRangeByIndex(1, columna).text = "J. 23".toUpperCase();columna++;//_J. 23,
    sheet.getRangeByIndex(1, columna).text = "J. 24".toUpperCase();columna++;//_J. 24,
    sheet.getRangeByIndex(1, columna).text = "J. 25".toUpperCase();columna++;//_J. 25,
    sheet.getRangeByIndex(1, columna).text = "J. 26".toUpperCase();columna++;//_J. 26,
    sheet.getRangeByIndex(1, columna).text = "J. 27".toUpperCase();columna++;//_J. 27,
    sheet.getRangeByIndex(1, columna).text = "J. 28".toUpperCase();columna++;//_J. 28,
    sheet.getRangeByIndex(1, columna).text = "J. 29".toUpperCase();columna++;//_J. 29,
    sheet.getRangeByIndex(1, columna).text = "J. 30".toUpperCase();columna++;//_J. 30,
    sheet.getRangeByIndex(1, columna).text = "J. 31".toUpperCase();columna++;//_J. 31,
    sheet.getRangeByIndex(1, columna).text = "J. 32".toUpperCase();columna++;//_J. 32,
    sheet.getRangeByIndex(1, columna).text = "J. 33".toUpperCase();columna++;//_J. 33,
    sheet.getRangeByIndex(1, columna).text = "J. 34".toUpperCase();columna++;//_J. 34,
    sheet.getRangeByIndex(1, columna).text = "J. 35".toUpperCase();columna++;//_J. 35,
    sheet.getRangeByIndex(1, columna).text = "J. 36".toUpperCase();columna++;//_J. 36,
    sheet.getRangeByIndex(1, columna).text = "J. 37".toUpperCase();columna++;//_J. 37,
    sheet.getRangeByIndex(1, columna).text = "J. 38".toUpperCase();columna++;//_J. 38,
    sheet.getRangeByIndex(1, columna).text = "J. 39".toUpperCase();columna++;//_J. 39,
    sheet.getRangeByIndex(1, columna).text = "J. 40".toUpperCase();columna++;//_J. 40,
    sheet.getRangeByIndex(1, columna).text = "J. 41".toUpperCase();columna++;//_J. 41,
    sheet.getRangeByIndex(1, columna).text = "J. 42".toUpperCase();columna++;//_J. 42,
    sheet.getRangeByIndex(1, columna).cellStyle=styleCabecera2;
    sheet.getRangeByIndex(1, columna).text = "PUNTUACIÓN TOTAL".toUpperCase();columna++;//_J. 43,
    sheet.getRangeByIndex(1, columna).cellStyle=styleCabecera2;
    sheet.getRangeByIndex(1, columna).text = "PROMEDIO".toUpperCase();columna++;//_J. 43,
    sheet.getRangeByIndex(1, columna).cellStyle=styleCabecera2;
    sheet.getRangeByIndex(1, columna).text = "INDICADOR SUBJETIVO PxP".toUpperCase();columna++;//_J. 43,
    /*sheet.getRangeByIndex(1, columna).text = "J. 44".toUpperCase();columna++;//_J. 44,
    sheet.getRangeByIndex(1, columna).text = "J. 45".toUpperCase();columna++;//_J. 45,
    sheet.getRangeByIndex(1, columna).text = "J. 46".toUpperCase();columna++;//_J. 46,
    sheet.getRangeByIndex(1, columna).text = "J. 47".toUpperCase();columna++;//_J. 47,
    sheet.getRangeByIndex(1, columna).text = "J. 48".toUpperCase();columna++;//_J. 48,
    sheet.getRangeByIndex(1, columna).text = "J. 49".toUpperCase();columna++;//_puntaciones_jornada_49,*/
    sheet.getRangeByIndex(1, columna).text = "nivel 1".toUpperCase();columna++;//_nivel,
    sheet.getRangeByIndex(1, columna).text = "nivel 2".toUpperCase();columna++;//_nivel2,
    sheet.getRangeByIndex(1, columna).text = "nivel 3".toUpperCase();columna++;//_nivel3,
    sheet.getRangeByIndex(1, columna).text = "nivel 4".toUpperCase();columna++;//_nivel4,
    sheet.getRangeByIndex(1, columna).text = "tipo".toUpperCase();columna++;//_observaciones == null ? "".toUpperCase();columna++;//_observaciones,
    sheet.getRangeByIndex(1, columna).text = "descripción".toUpperCase();columna++;//_observaciones == null ? "".toUpperCase();columna++;//_observaciones,
    sheet.getRangeByIndex(1, columna).text = "observaciones".toUpperCase();columna++;//_observaciones == null ? "".toUpperCase();columna++;//_observaciones,

    sheet.getRangeByIndex(1, columna).text = "ofe niveltecnico".toUpperCase();columna++;//_ofe_niveltecnico,
      sheet.getRangeByIndex(1, columna).text = "ofe profundidad".toUpperCase();columna++;//_ofe_profundidad,
      sheet.getRangeByIndex(1, columna).text = "ofe capacidad de generar buenos centros al area".toUpperCase();columna++;//_ofe_capacidaddegenerarbuenoscentrosalarea,
      sheet.getRangeByIndex(1, columna).text = "ofe capacidad de asociacion".toUpperCase();columna++;//_ofe_capacidaddeasociacion,
      sheet.getRangeByIndex(1, columna).text = "ofe desborde".toUpperCase();columna++;//_ofe_desborde,
      sheet.getRangeByIndex(1, columna).text = "ofe superioridad por dentro".toUpperCase();columna++;//_ofe_superioridadpordentro,
      sheet.getRangeByIndex(1, columna).text = "ofe finalizacion".toUpperCase();columna++;//_ofe_finalizacion,
      sheet.getRangeByIndex(1, columna).text = "ofe saque de banda longitud".toUpperCase();columna++;//_ofe_saquedebanda_longitud,
      sheet.getRangeByIndex(1, columna).text = "ofe lanzador de abps".toUpperCase();columna++;//_ofe_lanzadordeabps,
      sheet.getRangeByIndex(1, columna).text = "ofe salida de balon".toUpperCase();columna++;//_ofe_salidadebalon,
      sheet.getRangeByIndex(1, columna).text = "ofe pase largo medio".toUpperCase();columna++;//_ofe_paselargo_medio,
      sheet.getRangeByIndex(1, columna).text = "ofe cambios de orientacion".toUpperCase();columna++;//_ofe_cambiosdeorientacion,
      sheet.getRangeByIndex(1, columna).text = "ofe bate lineas con pase interior".toUpperCase();columna++;//_ofe_batelineasconpaseinterior,
      sheet.getRangeByIndex(1, columna).text = "ofe conduccion para dividir".toUpperCase();columna++;//_ofe_conduccionparadividir,
      sheet.getRangeByIndex(1, columna).text = "ofe primer pase tras recuperacion".toUpperCase();columna++;//_ofe_primerpasetrasrecuperacion,
      sheet.getRangeByIndex(1, columna).text = "ofe interviene en abps".toUpperCase();columna++;//_ofe_intervieneenabps,
      sheet.getRangeByIndex(1, columna).text = "ofe velocidad en el juego".toUpperCase();columna++;//_ofe_velocidadeneljuego,
      sheet.getRangeByIndex(1, columna).text = "ofe incorporacion a zonas de remate".toUpperCase();columna++;//_ofe_incorporacionazonasderemate,
      sheet.getRangeByIndex(1, columna).text = "ofe amplitud".toUpperCase();columna++;//_ofe_amplitud,
      sheet.getRangeByIndex(1, columna).text = "ofe desmarques de apoyo".toUpperCase();columna++;//_ofe_desmarquesdeapoyo,
      sheet.getRangeByIndex(1, columna).text = "ofe desmarques de ruptura".toUpperCase();columna++;//_ofe_desmarquesderuptura,
      sheet.getRangeByIndex(1, columna).text = "ofe capacidad de generar buenos centros laterales al area".toUpperCase();columna++;//_ofe_capacidaddegenerarbuenoscentroslateralesalarea,
      sheet.getRangeByIndex(1, columna).text = "ofe habilidad 1vs1".toUpperCase();columna++;//_ofe_habilidad1vs1,
      sheet.getRangeByIndex(1, columna).text = "ofe realizacion del ultimo pase".toUpperCase();columna++;//_ofe_realizaciondelultimopase,
      sheet.getRangeByIndex(1, columna).text = "ofe goleador".toUpperCase();columna++;//_ofe_goleador,
      sheet.getRangeByIndex(1, columna).text = "ofe explotacion de espacios".toUpperCase();columna++;//_ofe_explotaciondeespacios,
      sheet.getRangeByIndex(1, columna).text = "ofe duelos aereos".toUpperCase();columna++;//_ofe_duelosaereos,
      sheet.getRangeByIndex(1, columna).text = "ofe desborde por velocidad".toUpperCase();columna++;//_ofe_desbordeporvelocidad,
      sheet.getRangeByIndex(1, columna).text = "ofe dominio de 2vs1 pared".toUpperCase();columna++;//_ofe_dominiode2vs1_pared,
      sheet.getRangeByIndex(1, columna).text = "ofe ambidextro".toUpperCase();columna++;//_ofe_ambidextro,
      sheet.getRangeByIndex(1, columna).text = "ofe juego de cara".toUpperCase();columna++;//_ofe_juegodecara,
      sheet.getRangeByIndex(1, columna).text = "ofe proteccion de lbalon".toUpperCase();columna++;//_ofe_protecciondelbalon,
      sheet.getRangeByIndex(1, columna).text = "ofe caidas a banda".toUpperCase();columna++;//_ofe_caidasabanda,
      sheet.getRangeByIndex(1, columna).text = "ofe prolongaciones aereas".toUpperCase();columna++;//_ofe_prolongacionesaereas,
      sheet.getRangeByIndex(1, columna).text = "ofe dominio del area".toUpperCase();columna++;//_ofe_dominiodelarea,
      sheet.getRangeByIndex(1, columna).text = "ofe llegada a posiciones de remate".toUpperCase();columna++;//_ofe_llegadaaposicionesderemate,
      sheet.getRangeByIndex(1, columna).text = "ofe juego es espacio reducido".toUpperCase();columna++;//_ofe_juegoesespacioreducido,
      sheet.getRangeByIndex(1, columna).text = "ofe definidor ante el portero".toUpperCase();columna++;//_ofe_definidor_anteelportero,
      sheet.getRangeByIndex(1, columna).text = "ofe rematador finalizador".toUpperCase();columna++;//_ofe_rematador_finalizador,
      sheet.getRangeByIndex(1, columna).text = "ofe capacidad asociativa apoyos a la linea defensiva".toUpperCase();columna++;//_ofe_capacidadasociativa_apoyosalalineadefensiva,
      sheet.getRangeByIndex(1, columna).text = "ofe desplazamiento en largo".toUpperCase();columna++;//_ofe_desplazamientoenlargo,
      sheet.getRangeByIndex(1, columna).text = "fis velocidad de reaccion".toUpperCase();columna++;//_fis_velocidaddereaccion,
      sheet.getRangeByIndex(1, columna).text = "fis velocidad de desplazamiento".toUpperCase();columna++;//_fis_velocidaddedesplazamiento,
      sheet.getRangeByIndex(1, columna).text = "fis agilidad".toUpperCase();columna++;//_fis_agilidad,
      sheet.getRangeByIndex(1, columna).text = "fis envergadura".toUpperCase();columna++;//_fis_envergadura,
      sheet.getRangeByIndex(1, columna).text = "fis fuerza potencia".toUpperCase();columna++;//_fis_fuerza_potencia,
      sheet.getRangeByIndex(1, columna).text = "fis cuerpo a cuerpo".toUpperCase();columna++;//_fis_cuerpoacuerpo,
      sheet.getRangeByIndex(1, columna).text = "fis capacidad de salto".toUpperCase();columna++;//_fis_capacidaddesalto,
      sheet.getRangeByIndex(1, columna).text = "fis explosividad".toUpperCase();columna++;//_fis_explosividad,
      sheet.getRangeByIndex(1, columna).text = "fis potencia de salto lateral y vertical".toUpperCase();columna++;//_fis_potenciadesaltolateralyvertical,
      sheet.getRangeByIndex(1, columna).text = "fis resistencia ida y vuelta".toUpperCase();columna++;//_fis_resistencia_idayvuelta,
      sheet.getRangeByIndex(1, columna).text = "fis cambio de ritmo".toUpperCase();columna++;//_fis_cambioderitmo,
      sheet.getRangeByIndex(1, columna).text = "psic liderazgo".toUpperCase();columna++;//_psic_liderazgo,
      sheet.getRangeByIndex(1, columna).text = "psic comunicacion".toUpperCase();columna++;//_psic_comunicacion,
      sheet.getRangeByIndex(1, columna).text = "psic seguridad".toUpperCase();columna++;//_psic_seguridad,
      sheet.getRangeByIndex(1, columna).text = "psic toma de decisiones".toUpperCase();columna++;//_psic_tomadedecisiones,
      sheet.getRangeByIndex(1, columna).text = "psic agresividad".toUpperCase();columna++;//_psic_agresividad,
      sheet.getRangeByIndex(1, columna).text = "psic polivalencia".toUpperCase();columna++;//_psic_polivalencia,
      sheet.getRangeByIndex(1, columna).text = "psic competitividad".toUpperCase();columna++;//_psic_competitividad,
      sheet.getRangeByIndex(1, columna).text = "psic agresividad contundencia".toUpperCase();columna++;//_psic_agresividad_contundencia,
      sheet.getRangeByIndex(1, columna).text = "psic no asume riesgos extremos".toUpperCase();columna++;//_psic_noasumeriesgosextremos,
      sheet.getRangeByIndex(1, columna).text = "psic entendimiento del juego inteligencia".toUpperCase();columna++;//_psic_entendimientodeljuego_inteligencia,
      sheet.getRangeByIndex(1, columna).text = "psic creatividad".toUpperCase();columna++;//_psic_creatividad,
      sheet.getRangeByIndex(1, columna).text = "psic confianza".toUpperCase();columna++;//_psic_confianza,
      sheet.getRangeByIndex(1, columna).text = "psic compromiso".toUpperCase();columna++;//_psic_compromiso,
      sheet.getRangeByIndex(1, columna).text = "psic valentia".toUpperCase();columna++;//_psic_valentia,
      sheet.getRangeByIndex(1, columna).text = "psic oportunismo".toUpperCase();columna++;//_psic_oportunismo,
      sheet.getRangeByIndex(1, columna).text = "def acoso presion sobre el oponente".toUpperCase();columna++;//_def_acoso_presionsobreeloponente,
      sheet.getRangeByIndex(1, columna).text = "def actituddefensiva".toUpperCase();columna++;//_def_actituddefensiva,
      sheet.getRangeByIndex(1, columna).text = "def activacion de los mecanismos depresion".toUpperCase();columna++;//_def_activaciondelosmecanismosdepresion,
      sheet.getRangeByIndex(1, columna).text = "def anticipacion".toUpperCase();columna++;//_def_anticipacion,
      sheet.getRangeByIndex(1, columna).text = "def ayudas permanentes al lateral".toUpperCase();columna++;//_def_ayudaspermanentesallateral,
      sheet.getRangeByIndex(1, columna).text = "def capacidad de marcaje".toUpperCase();columna++;//_def_capacidaddemarcaje,
      sheet.getRangeByIndex(1, columna).text = "def capacidad para tapar centros".toUpperCase();columna++;//_def_capacidadparataparcentros,
      sheet.getRangeByIndex(1, columna).text = "def cerrar el lado debil basculaciones".toUpperCase();columna++;//_def_cerrarelladodebil_basculaciones,
      sheet.getRangeByIndex(1, columna).text = "def cierra lineas de pase".toUpperCase();columna++;//_def_cierralineasdepase,
      sheet.getRangeByIndex(1, columna).text = "def cobertura de centrales".toUpperCase();columna++;//_def_coberturadecentrales,
      sheet.getRangeByIndex(1, columna).text = "def coberturas".toUpperCase();columna++;//_def_coberturas,
      sheet.getRangeByIndex(1, columna).text = "def colocacion".toUpperCase();columna++;//_def_colocacion,
      sheet.getRangeByIndex(1, columna).text = "def comportamiento fuera de zona".toUpperCase();columna++;//_def_comportamientofueradezona,
      sheet.getRangeByIndex(1, columna).text = "def correcta basculacion".toUpperCase();columna++;//_def_correctabasculacion,
      sheet.getRangeByIndex(1, columna).text = "def correcta basculacion distancia de intervalos".toUpperCase();columna++;//_def_correctabasculacion_distanciadeintervalos,
      sheet.getRangeByIndex(1, columna).text = "def correcto perfilamiento".toUpperCase();columna++;//_def_correctoperfilamiento,
      sheet.getRangeByIndex(1, columna).text = "def cruces".toUpperCase();columna++;//_def_cruces,
      sheet.getRangeByIndex(1, columna).text = "def destreza ante centros laterales".toUpperCase();columna++;//_def_destrezaantecentroslaterales,
      sheet.getRangeByIndex(1, columna).text = "def dificil de superar en el 1vs1".toUpperCase();columna++;//_def_dificildesuperarenel1vs1,
      sheet.getRangeByIndex(1, columna).text = "def dominio de las zonas de rechace".toUpperCase();columna++;//_def_dominiodelaszonasderechace,
      sheet.getRangeByIndex(1, columna).text = "def duelos aereos".toUpperCase();columna++;//_def_duelosaereos,
      sheet.getRangeByIndex(1, columna).text = "def duelos defensivos".toUpperCase();columna++;//_def_duelosdefensivos,
      sheet.getRangeByIndex(1, columna).text = "def evita recepciones entre lineas".toUpperCase();columna++;//_def_evitarecepcionesentrelineas,
      sheet.getRangeByIndex(1, columna).text = "def evita ser desbordado".toUpperCase();columna++;//_def_evitaserdesbordado,
      sheet.getRangeByIndex(1, columna).text = "def interceptacion de tiro".toUpperCase();columna++;//_def_interceptaciondetiro,
      sheet.getRangeByIndex(1, columna).text = "def mantener la linea defensiva".toUpperCase();columna++;//_def_mantenerlalineadefensiva,
      sheet.getRangeByIndex(1, columna).text = "def marcaje proximo a oponente directo".toUpperCase();columna++;//_def_marcajeproximoaoponentedirecto,
      sheet.getRangeByIndex(1, columna).text = "def ocupa espacios de compañeeros superados".toUpperCase();columna++;//_def_ocupaespaciosdecompanerossuperados,
      sheet.getRangeByIndex(1, columna).text = "def perfilamientos".toUpperCase();columna++;//_def_perfilamientos,
      sheet.getRangeByIndex(1, columna).text = "def permite e lgiro".toUpperCase();columna++;//_def_permiteelgiro,
      sheet.getRangeByIndex(1, columna).text = "def presion tras perdida".toUpperCase();columna++;//_def_presiontrasperdida,
      sheet.getRangeByIndex(1, columna).text = "def resolucion ante paredes rivales".toUpperCase();columna++;//_def_resolucionanteparedesrivales,
      sheet.getRangeByIndex(1, columna).text = "def sabe cuidar su espalda".toUpperCase();columna++;//_def_sabecuidarsuespalda,
      sheet.getRangeByIndex(1, columna).text = "def vigila y referencia al rival en fase ofensiva".toUpperCase();columna++;//_def_vigilayreferenciaalrival_enfaseofensiva,
      sheet.getRangeByIndex(1, columna).text = "def vigilancias sobre lateral rival".toUpperCase();columna++;//_def_vigilanciassobrelateralrival,
      sheet.getRangeByIndex(1, columna).text = "def blocaje".toUpperCase();columna++;//_def_blocaje,
      sheet.getRangeByIndex(1, columna).text = "def juego aereo lateral".toUpperCase();columna++;//_def_juegoaereolateral,
      sheet.getRangeByIndex(1, columna).text = "def juego aereo frontal".toUpperCase();columna++;//_def_juegoaereofrontal,
      sheet.getRangeByIndex(1, columna).text = "def habilidad en el 1vs1".toUpperCase();columna++;//_def_habilidadenel1vs1,
      sheet.getRangeByIndex(1, columna).text = "def despeje".toUpperCase();columna++;//_def_despeje,
      sheet.getRangeByIndex(1, columna).text = "def anticipacion intuicion".toUpperCase();columna++;//_def_anticipacion_intuicion,
      sheet.getRangeByIndex(1, columna).text = "def cobertura de linea defensiva".toUpperCase();columna++;//_def_coberturadelineadefensiva,
      sheet.getRangeByIndex(1, columna).text = "def abps".toUpperCase();columna++;//_def_abps,
      sheet.getRangeByIndex(1, columna).text = "def penaltis".toUpperCase();columna++;//_def_penaltis,

/*      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_1".toUpperCase();columna++;//_estrella_jornada_1,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_2";columna++;//_estrella_jornada_2,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_3";columna++;//_estrella_jornada_3,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_4";columna++;//_estrella_jornada_4,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_5";columna++;//_estrella_jornada_5,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_6";columna++;//_estrella_jornada_6,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_7";columna++;//_estrella_jornada_7,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_8";columna++;//_estrella_jornada_8,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_9";columna++;//_estrella_jornada_9,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_10";columna++;//_estrella_jornada_10,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_11";columna++;//_estrella_jornada_11,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_12";columna++;//_estrella_jornada_12,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_13";columna++;//_estrella_jornada_13,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_14";columna++;//_estrella_jornada_14,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_15";columna++;//_estrella_jornada_15,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_16";columna++;//_estrella_jornada_16,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_17";columna++;//_estrella_jornada_17,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_18";columna++;//_estrella_jornada_18,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_19";columna++;//_estrella_jornada_19,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_20";columna++;//_estrella_jornada_20,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_21";columna++;//_estrella_jornada_21,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_22";columna++;//_estrella_jornada_22,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_23";columna++;//_estrella_jornada_23,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_24";columna++;//_estrella_jornada_24,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_25";columna++;//_estrella_jornada_25,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_26";columna++;//_estrella_jornada_26,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_27";columna++;//_estrella_jornada_27,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_28";columna++;//_estrella_jornada_28,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_29";columna++;//_estrella_jornada_29,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_30";columna++;//_estrella_jornada_30,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_31";columna++;//_estrella_jornada_31,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_32";columna++;//_estrella_jornada_32,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_33";columna++;//_estrella_jornada_33,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_34";columna++;//_estrella_jornada_34,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_35";columna++;//_estrella_jornada_35,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_36";columna++;//_estrella_jornada_36,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_37";columna++;//_estrella_jornada_37,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_38";columna++;//_estrella_jornada_38,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_39";columna++;//_estrella_jornada_39,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_40";columna++;//_estrella_jornada_40,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_41";columna++;//_estrella_jornada_41,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_42";columna++;//_estrella_jornada_42,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_43";columna++;//_estrella_jornada_43,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_44";columna++;//_estrella_jornada_44,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_45";columna++;//_estrella_jornada_45,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_46";columna++;//_estrella_jornada_46,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_47";columna++;//_estrella_jornada_47,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_48";columna++;//_estrella_jornada_48,
      sheet.getRangeByIndex(1, columna).text = "estrella_jornada_49";columna++;//_estrella_jornada_49,*/
      sheet.getRangeByIndex(1, columna).text = "nombre";columna++;//BBDDService()
      sheet.getRangeByIndex(1, columna).text = "email";columna++;//BBDDService()
      //sheet.getRangeByIndex(1, columna).text = "fecha:";
  }


  CellStyle styleAplazado;
  CellStyle styleNA;
  CellStyle styleEX;
  CellStyle styleSIM;
  CellStyle styleSV;
  CellStyle styleTitular;
  CellStyle styleSuplente;
  CellStyle styleBlanco;
  CellStyle styleCabecera;
  CellStyle styleCabecera2;

  CellStyle styleSuperlativo;
  CellStyle styleSuper;
  CellStyle styleDestacado;
  CellStyle styleIntermedio;
  CellStyle styleDudoso;
  CellStyle styleBajo;
  CellStyle styleNAD;


  Future<void> _generateExcel(List<Categoria> categoriaList) async{
    final Workbook workbook = Workbook(0);
    //Adding a Sheet with name to workbook.
    final Worksheet sheet1 = workbook.worksheets.addWithName('${_categoriaAux.categoria}');
    sheet1.showGridlines = true;
    sheet1.enableSheetCalculations();

    styleAplazado=new CellStyle(workbook);
    styleNA=new CellStyle(workbook);
    styleSIM=new CellStyle(workbook);
    styleSV=new CellStyle(workbook);
    styleTitular=new CellStyle(workbook);
    styleSuplente=new CellStyle(workbook);
    styleBlanco=new CellStyle(workbook);
    styleEX=new CellStyle(workbook);
    styleCabecera=new CellStyle(workbook);
    styleCabecera2=new CellStyle(workbook);

    styleSuperlativo=new CellStyle(workbook);
     styleSuper=new CellStyle(workbook);
     styleDestacado=new CellStyle(workbook);
     styleIntermedio=new CellStyle(workbook);
     styleDudoso=new CellStyle(workbook);
     styleBajo=new CellStyle(workbook);
     styleNAD=new CellStyle(workbook);

    styleBlanco.backColor="#FFFFFF";
    styleAplazado.backColor="#3383FF";
    styleNA.backColor="#FFE333";
    styleSIM.backColor="#C1C0BE";
    styleSV.backColor="#C38EFC";
    styleTitular.backColor="#6ACC70";
    styleSuplente.backColor="#FFA94F";
    styleEX.backColor="#FF4F4F";

    styleSuperlativo.backColor ="#057C15";
    styleSuper.backColor ="#09F729";
    styleDestacado.backColor ="#F7F309";
    styleIntermedio.backColor ="#F78B09";
    styleDudoso.backColor ="#FB36DD";
    styleBajo.backColor ="#931C01";
    styleNAD.backColor ="#6BEBFF";



    styleBlanco.hAlign=HAlignType.center;
    styleAplazado.hAlign=HAlignType.center;
    styleNA.hAlign=HAlignType.center;
    styleSIM.hAlign=HAlignType.center;
    styleSV.hAlign=HAlignType.center;
    styleTitular.hAlign=HAlignType.center;
    styleSuplente.hAlign=HAlignType.center;
    styleSuplente.hAlign=HAlignType.center;
    styleEX.hAlign=HAlignType.center;
    sheet1.enableSheetCalculations();
    ponerCabecera(sheet1);
    int fila=2;
    CRUDEquipo dao = CRUDEquipo();
    CRUDJugador daoJug = CRUDJugador();
    List<Equipo> equiposList=[];
    for (var cat in categoriaList) {
      if(cat.categoria!="TODOS"){
      equiposList.clear();
      equiposList =
      await dao.fetchEquipos(_temporadaAux, _paisAux, cat);
      for (var doc in equiposList) {
        //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ

        List<Player> jugadores = await daoJug.fetchJugadoresList(
            _temporadaAux, _paisAux, cat, doc);
        int columna = 1;
        for (var jug in jugadores) {
          columna = 1;
          //sheet1.getRangeByIndex(fila, columna).value=jug.idjugador;columna++;
          ponerCeldaValor(sheet1, fila, columna, jug.idjugador);
          columna++; //_jugador,
          ponerCeldaValor(sheet1, fila, columna, jug.jugador);
          columna++; //_jugador,
          ponerCeldaValor(sheet1, fila, columna, jug.equipo);
          columna++; //_equipo,
          ponerCeldaValor(sheet1, fila, columna, _temporadaAux.temporada);
          columna++; //_temporada,
          ponerCeldaValor(sheet1, fila, columna, jug.categoria);
          columna++; //_categoria,
          ponerCeldaValor(sheet1, fila, columna, jug.dorsal);
          columna++; //_dorsal,
          ponerCeldaValor(sheet1, fila, columna, jug.lateral);
          columna++; //_lateral,
          ponerCeldaValor(sheet1, fila, columna, jug.posicion);
          columna++; //_posicion,
          ponerCeldaValor(sheet1, fila, columna, jug.posicionalternativa);
          columna++; //_posicionalternativa,
          ponerCeldaValor(sheet1, fila, columna, jug.pais);
          columna++; //_pais,
          ponerCeldaValor(sheet1, fila, columna, jug.fechaNacimiento);
          columna++; //_fechaNacimiento,
          ponerCeldaValor(sheet1, fila, columna, jug.peso);
          columna++; //_peso,
          ponerCeldaValor(sheet1, fila, columna, jug.altura);
          columna++; //_altura,
          ponerCeldaValor(sheet1, fila, columna, jug.valor);
          columna++; //_valor,
          ponerCeldaValor(sheet1, fila, columna, jug.paisNacimiento);
          columna++; //_paisNacimiento,
          ponerCeldaValor(sheet1, fila, columna, jug.ccaa);
          columna++; //_ccaa,
          ponerCeldaValor(sheet1, fila, columna, jug.nacionalidad);
          columna++; //_nacionalidad,
          ponerCeldaValor(sheet1, fila, columna, jug.contrato);
          columna++; //_contrato,
          ponerCeldaValor(sheet1, fila, columna, jug.fechaContrato);
          columna++; //_fechaContrato,
          ponerCeldaValor(sheet1, fila, columna, jug.veredicto);
          columna++; //_veredicto,
          ponerCeldaValor(sheet1, fila, columna, jug.prestamo);
          columna++; //_prestamo,
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_1,
              jug.estado_jornada_1);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_2,
              jug.estado_jornada_2);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_3,
              jug.estado_jornada_3);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_4,
              jug.estado_jornada_4);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_5,
              jug.estado_jornada_5);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_6,
              jug.estado_jornada_6);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_7,
              jug.estado_jornada_7);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_8,
              jug.estado_jornada_8);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_9,
              jug.estado_jornada_9);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_10,
              jug.estado_jornada_10);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_11,
              jug.estado_jornada_11);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_12,
              jug.estado_jornada_12);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_13,
              jug.estado_jornada_13);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_14,
              jug.estado_jornada_14);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_15,
              jug.estado_jornada_15);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_16,
              jug.estado_jornada_16);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_17,
              jug.estado_jornada_17);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_18,
              jug.estado_jornada_18);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_19,
              jug.estado_jornada_19);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_20,
              jug.estado_jornada_20);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_21,
              jug.estado_jornada_21);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_22,
              jug.estado_jornada_22);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_23,
              jug.estado_jornada_23);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_24,
              jug.estado_jornada_24);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_25,
              jug.estado_jornada_25);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_26,
              jug.estado_jornada_26);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_27,
              jug.estado_jornada_27);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_28,
              jug.estado_jornada_28);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_29,
              jug.estado_jornada_29);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_30,
              jug.estado_jornada_30);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_31,
              jug.estado_jornada_31);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_32,
              jug.estado_jornada_32);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_33,
              jug.estado_jornada_33);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_34,
              jug.estado_jornada_34);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_35,
              jug.estado_jornada_35);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_36,
              jug.estado_jornada_36);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_37,
              jug.estado_jornada_37);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_38,
              jug.estado_jornada_38);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_39,
              jug.estado_jornada_39);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_40,
              jug.estado_jornada_40);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_41,
              jug.estado_jornada_41);
          columna++;
          ponerCeldaValorPuntuacion(
              sheet1, fila, columna, jug.puntaciones_jornada_42,
              jug.estado_jornada_42);
          columna++;
          String puntuacionTolal="=SUM(V"+fila.toString()+":"+"BK"+fila.toString()+")";
          sheet1.getRangeByIndex(fila, columna).setFormula(puntuacionTolal);
          sheet1.getRangeByIndex(fila, columna).numberFormat='#,##0.00';
          columna++;
          String promedio="=AVERAGE(V"+fila.toString()+":"+"BK"+fila.toString()+")";
          sheet1.getRangeByIndex(fila, columna).setFormula(promedio);
          sheet1.getRangeByIndex(fila, columna).numberFormat='#,##0.00';
          columna++;
          String indicador="=BL"+fila.toString()+"*BM"+fila.toString()+"";
          print(indicador);
          sheet1.getRangeByIndex(fila, columna).setFormula(indicador);
          sheet1.getRangeByIndex(fila, columna).numberFormat='#,##0.000';
          columna++;
          /*ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_43,jug.estado_jornada_43);columna++;
            ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_44,jug.estado_jornada_44);columna++;
            ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_45,jug.estado_jornada_45);columna++;
            ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_46,jug.estado_jornada_46);columna++;
            ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_47,jug.estado_jornada_47);columna++;
            ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_48,jug.estado_jornada_48);columna++;
            ponerCeldaValorPuntuacion(sheet1, fila, columna, jug.puntaciones_jornada_49,jug.estado_jornada_49);columna++;*/
          ponerCeldaValorNivel(sheet1, fila, columna, jug.nivel);
          columna++; //_nivel,
          ponerCeldaValorNivel(sheet1, fila, columna, jug.nivel2);
          columna++; //_nivel2,
          ponerCeldaValorNivel(sheet1, fila, columna, jug.nivel3);
          columna++; //_nivel3,
          ponerCeldaValorNivel(sheet1, fila, columna, jug.nivel4);
          columna++; //_nivel4,

          ponerCeldaValor(sheet1, fila, columna, jug.tipoLetra());
          columna++; //_tipo,

          ponerCeldaValor(sheet1, fila, columna,  Player.tipoJugador(jug.posicion,jug.tipo));
          columna++;

          ponerCeldaValor(sheet1, fila, columna, jug.observaciones);
          columna++; //_observaciones == null ? ");columna++;//_observaciones,

          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_niveltecnico);
          columna++; //_ofe_niveltecnico,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_profundidad);
          columna++; //_ofe_profundidad,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.ofe_capacidaddegenerarbuenoscentrosalarea);
          columna++; //_ofe_capacidaddegenerarbuenoscentrosalarea,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_capacidaddeasociacion);
          columna++; //_ofe_capacidaddeasociacion,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_desborde);
          columna++; //_ofe_desborde,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_superioridadpordentro);
          columna++; //_ofe_superioridadpordentro,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_finalizacion);
          columna++; //_ofe_finalizacion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_saquedebanda_longitud);
          columna++; //_ofe_saquedebanda_longitud,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_lanzadordeabps);
          columna++; //_ofe_lanzadordeabps,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_salidadebalon);
          columna++; //_ofe_salidadebalon,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_paselargo_medio);
          columna++; //_ofe_paselargo_medio,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_cambiosdeorientacion);
          columna++; //_ofe_cambiosdeorientacion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_batelineasconpaseinterior);
          columna++; //_ofe_batelineasconpaseinterior,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_conduccionparadividir);
          columna++; //_ofe_conduccionparadividir,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_primerpasetrasrecuperacion);
          columna++; //_ofe_primerpasetrasrecuperacion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_intervieneenabps);
          columna++; //_ofe_intervieneenabps,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_velocidadeneljuego);
          columna++; //_ofe_velocidadeneljuego,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_incorporacionazonasderemate);
          columna++; //_ofe_incorporacionazonasderemate,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_amplitud);
          columna++; //_ofe_amplitud,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_desmarquesdeapoyo);
          columna++; //_ofe_desmarquesdeapoyo,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_desmarquesderuptura);
          columna++; //_ofe_desmarquesderuptura,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.ofe_capacidaddegenerarbuenoscentroslateralesalarea);
          columna++; //_ofe_capacidaddegenerarbuenoscentroslateralesalarea,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_habilidad1vs1);
          columna++; //_ofe_habilidad1vs1,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_realizaciondelultimopase);
          columna++; //_ofe_realizaciondelultimopase,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_goleador);
          columna++; //_ofe_goleador,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_explotaciondeespacios);
          columna++; //_ofe_explotaciondeespacios,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_duelosaereos);
          columna++; //_ofe_duelosaereos,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_desbordeporvelocidad);
          columna++; //_ofe_desbordeporvelocidad,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_dominiode2vs1_pared);
          columna++; //_ofe_dominiode2vs1_pared,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_ambidextro);
          columna++; //_ofe_ambidextro,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_juegodecara);
          columna++; //_ofe_juegodecara,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_protecciondelbalon);
          columna++; //_ofe_protecciondelbalon,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.ofe_caidasabanda);
          columna++; //_ofe_caidasabanda,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_prolongacionesaereas);
          columna++; //_ofe_prolongacionesaereas,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_dominiodelarea);
          columna++; //_ofe_dominiodelarea,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_llegadaaposicionesderemate);
          columna++; //_ofe_llegadaaposicionesderemate,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_juegoesespacioreducido);
          columna++; //_ofe_juegoesespacioreducido,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_definidor_anteelportero);
          columna++; //_ofe_definidor_anteelportero,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_rematador_finalizador);
          columna++; //_ofe_rematador_finalizador,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.ofe_capacidadasociativa_apoyosalalineadefensiva);
          columna++; //_ofe_capacidadasociativa_apoyosalalineadefensiva,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.ofe_desplazamientoenlargo);
          columna++; //_ofe_desplazamientoenlargo,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.fis_velocidaddereaccion);
          columna++; //_fis_velocidaddereaccion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.fis_velocidaddedesplazamiento);
          columna++; //_fis_velocidaddedesplazamiento,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.fis_agilidad);
          columna++; //_fis_agilidad,
          ponerCeldaValor(sheet1, fila, columna, jug.fis_envergadura);
          columna++; //_fis_envergadura,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.fis_fuerza_potencia);
          columna++; //_fis_fuerza_potencia,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.fis_cuerpoacuerpo);
          columna++; //_fis_cuerpoacuerpo,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.fis_capacidaddesalto);
          columna++; //_fis_capacidaddesalto,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.fis_explosividad);
          columna++; //_fis_explosividad,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.fis_potenciadesaltolateralyvertical);
          columna++; //_fis_potenciadesaltolateralyvertical,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.fis_resistencia_idayvuelta);
          columna++; //_fis_resistencia_idayvuelta,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.fis_cambioderitmo);
          columna++; //_fis_cambioderitmo,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_liderazgo);
          columna++; //_psic_liderazgo,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_comunicacion);
          columna++; //_psic_comunicacion,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_seguridad);
          columna++; //_psic_seguridad,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.psic_tomadedecisiones);
          columna++; //_psic_tomadedecisiones,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_agresividad);
          columna++; //_psic_agresividad,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_polivalencia);
          columna++; //_psic_polivalencia,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.psic_competitividad);
          columna++; //_psic_competitividad,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.psic_agresividad_contundencia);
          columna++; //_psic_agresividad_contundencia,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.psic_noasumeriesgosextremos);
          columna++; //_psic_noasumeriesgosextremos,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.psic_entendimientodeljuego_inteligencia);
          columna++; //_psic_entendimientodeljuego_inteligencia,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_creatividad);
          columna++; //_psic_creatividad,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_confianza);
          columna++; //_psic_confianza,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_compromiso);
          columna++; //_psic_compromiso,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_valentia);
          columna++; //_psic_valentia,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.psic_oportunismo);
          columna++; //_psic_oportunismo,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_acoso_presionsobreeloponente);
          columna++; //_def_acoso_presionsobreeloponente,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_actituddefensiva);
          columna++; //_def_actituddefensiva,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.def_activaciondelosmecanismosdepresion);
          columna++; //_def_activaciondelosmecanismosdepresion,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_anticipacion);
          columna++; //_def_anticipacion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_ayudaspermanentesallateral);
          columna++; //_def_ayudaspermanentesallateral,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_capacidaddemarcaje);
          columna++; //_def_capacidaddemarcaje,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_capacidadparataparcentros);
          columna++; //_def_capacidadparataparcentros,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_cerrarelladodebil_basculaciones);
          columna++; //_def_cerrarelladodebil_basculaciones,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_cierralineasdepase);
          columna++; //_def_cierralineasdepase,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_coberturadecentrales);
          columna++; //_def_coberturadecentrales,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_coberturas);
          columna++; //_def_coberturas,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_colocacion);
          columna++; //_def_colocacion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_comportamientofueradezona);
          columna++; //_def_comportamientofueradezona,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_correctabasculacion);
          columna++; //_def_correctabasculacion,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.def_correctabasculacion_distanciadeintervalos);
          columna++; //_def_correctabasculacion_distanciadeintervalos,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_correctoperfilamiento);
          columna++; //_def_correctoperfilamiento,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_cruces);
          columna++; //_def_cruces,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_destrezaantecentroslaterales);
          columna++; //_def_destrezaantecentroslaterales,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_dificildesuperarenel1vs1);
          columna++; //_def_dificildesuperarenel1vs1,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_dominiodelaszonasderechace);
          columna++; //_def_dominiodelaszonasderechace,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_duelosaereos);
          columna++; //_def_duelosaereos,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_duelosdefensivos);
          columna++; //_def_duelosdefensivos,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_evitarecepcionesentrelineas);
          columna++; //_def_evitarecepcionesentrelineas,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_evitaserdesbordado);
          columna++; //_def_evitaserdesbordado,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_interceptaciondetiro);
          columna++; //_def_interceptaciondetiro,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_mantenerlalineadefensiva);
          columna++; //_def_mantenerlalineadefensiva,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_marcajeproximoaoponentedirecto);
          columna++; //_def_marcajeproximoaoponentedirecto,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.def_ocupaespaciosdecompanerossuperados);
          columna++; //_def_ocupaespaciosdecompanerossuperados,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_perfilamientos);
          columna++; //_def_perfilamientos,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_permiteelgiro);
          columna++; //_def_permiteelgiro,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_presiontrasperdida);
          columna++; //_def_presiontrasperdida,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_resolucionanteparedesrivales);
          columna++; //_def_resolucionanteparedesrivales,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_sabecuidarsuespalda);
          columna++; //_def_sabecuidarsuespalda,
          ponerCeldaValorCaracter(sheet1, fila, columna,
              jug.def_vigilayreferenciaalrival_enfaseofensiva);
          columna++; //_def_vigilayreferenciaalrival_enfaseofensiva,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_vigilanciassobrelateralrival);
          columna++; //_def_vigilanciassobrelateralrival,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_blocaje);
          columna++; //_def_blocaje,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_juegoaereolateral);
          columna++; //_def_juegoaereolateral,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_juegoaereofrontal);
          columna++; //_def_juegoaereofrontal,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_habilidadenel1vs1);
          columna++; //_def_habilidadenel1vs1,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_despeje);
          columna++; //_def_despeje,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_anticipacion_intuicion);
          columna++; //_def_anticipacion_intuicion,
          ponerCeldaValorCaracter(
              sheet1, fila, columna, jug.def_coberturadelineadefensiva);
          columna++; //_def_coberturadelineadefensiva,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_abps);
          columna++; //_def_abps,
          ponerCeldaValorCaracter(sheet1, fila, columna, jug.def_penaltis);
          columna++; //_def_penaltis,

          ponerCeldaValor(sheet1, fila, columna, jug.nombre);
          columna++; //BBDDService()
          ponerCeldaValor(sheet1, fila, columna, jug.email);
          columna++; //BBDDService()
          //ponerCeldaValor(sheet1, fila, columna, DateTime.now().toString());
          //print("${jug.equipo}:${jug.jugador}");
          fila++;
        }
      }


      }
    }

    print("ABRRRRRRRRRRRRRRREEEE");
    final List<int> bytes = workbook.saveAsStream();
    print("ABRRRRRRRRRRRRRRREEEE");
    workbook.dispose();

    final Directory directory =
    await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/${_categoriaAux.categoria}.xlsx');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    print("ABRRRRRRRRRRRRRRREEEE");
    await open_file.OpenFile.open('$path/${_categoriaAux.categoria}.xlsx');
    //Launch file.
    //await FileSaveHelper.saveAndLaunchFile(bytes, 'ExpensesReport.xlsx');
  }

  ponerCeldaValor(Worksheet sheet1, int fila, int columna, var jug) {

    sheet1.getRangeByIndex(fila, columna).value = jug;

  }

  ponerCeldaValorNivel(Worksheet sheet1, int fila, int columna, String jug) {
    print(jug);
    if(jug==null)jug="";
    sheet1
        .getRangeByIndex(fila, columna)
        .value = jug.toUpperCase();
      if(jug.toUpperCase()=="SUPERLATIVO") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleSuperlativo;

    }
    if(jug.toUpperCase()=="SUPERIOR") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleSuper;

    }
    if(jug.toUpperCase()=="INTERMEDIO") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleIntermedio;

    }
    if(jug.toUpperCase()=="DUDOSO") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleDudoso;

    }
    if(jug.toUpperCase()=="DESTACADO") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleDestacado;

    }
    if(jug.toUpperCase()=="DISCRETO") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleBajo;

    }
    if(jug.toUpperCase()=="N/A") {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleNAD;

    }
  }

  ponerCeldaValorCaracter(Worksheet sheet1, int fila, int columna, bool jug) {

    if(jug==true) {
      sheet1
          .getRangeByIndex(fila, columna)
          .cellStyle = styleAplazado;
      sheet1
          .getRangeByIndex(fila, columna)
          .value = jug;
    }else{
        sheet1
            .getRangeByIndex(fila, columna)
            .cellStyle = styleBlanco;
        sheet1
            .getRangeByIndex(fila, columna)
            .value =jug;
      }
    }


   ponerCeldaValorPuntuacion(Worksheet sheet1, int fila, int columna, String jug,  String estado) {
     double punt=0.0;
     print(jug);
     try{
       punt=double.parse(jug.replaceAll(",", "."));
       print(punt);
       sheet1.getRangeByIndex(fila, columna).value = punt;
       sheet1.getRangeByIndex(fila, columna).numberFormat='#,##0.00';

       //jug=punt.toString();
     }catch(e){
       sheet1.getRangeByIndex(fila, columna).value = estado;
     }
     if(jug==null) {
       jug = "";
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleBlanco;
       sheet1.getRangeByIndex(fila, columna).value = "";
     }//jug=jug.replaceAll(",", ".");
     if(estado =="SV"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleSV;
       sheet1.getRangeByIndex(fila, columna).value = "SV";
     }
     if(estado =="EX"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleEX;
       if ((jug==null)||(jug=="")) sheet1.getRangeByIndex(fila, columna).value = "EX";
     }
     if(estado =="SIM"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleSIM;
       sheet1.getRangeByIndex(fila, columna).value = "SIM";
     }
     if(estado =="A"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleAplazado;
       sheet1.getRangeByIndex(fila, columna).value = "A";
     }
     if(estado =="NA"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleNA;
       sheet1.getRangeByIndex(fila, columna).value = "NA";

     }
     if(estado =="T"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleTitular;
       if ((jug==null)||(jug==""))sheet1.getRangeByIndex(fila, columna).value = "T";

     }
     if(estado =="S"){
       sheet1.getRangeByIndex(fila, columna).cellStyle=styleSuplente;
       if ((jug==null)||(jug==""))sheet1.getRangeByIndex(fila, columna).value = "S";
     }
     //sheet1.getRangeByIndex(fila, columna).numberFormat='#,##0.000';
  }

   ponerCeldaValorInt(Worksheet sheet1, int fila, int columna, int jug) {
    sheet1.getRangeByIndex(fila, columna).value = jug;
    if(sheet1.getRangeByIndex(fila, columna).value =="SV"){
      sheet1.getRangeByIndex(fila, columna).cellStyle=styleSV;
    }
    if(sheet1.getRangeByIndex(fila, columna).value =="SIM"){
      sheet1.getRangeByIndex(fila, columna).cellStyle=styleSIM;
    }
    if(sheet1.getRangeByIndex(fila, columna).value =="A"){
      sheet1.getRangeByIndex(fila, columna).cellStyle=styleAplazado;
    }
    if(sheet1.getRangeByIndex(fila, columna).value =="NA"){
      sheet1.getRangeByIndex(fila, columna).cellStyle=styleNA;
    }
    if(sheet1.getRangeByIndex(fila, columna).value =="T"){
      sheet1.getRangeByIndex(fila, columna).cellStyle=styleTitular;
    }
    if(sheet1.getRangeByIndex(fila, columna).value =="S"){
      sheet1.getRangeByIndex(fila, columna).cellStyle=styleSuplente;
    }
    if(sheet1.getRangeByIndex(fila, columna).value ==null){
      sheet1.getRangeByIndex(fila, columna).value="";
    }
  }


  Future<void> _generateExcel2() async {
      //Create a Excel document.

      //Creating a workbook.
      final Workbook workbook = Workbook(0);
      //Adding a Sheet with name to workbook.
      final Worksheet sheet1 = workbook.worksheets.addWithName('Budget');
      sheet1.showGridlines = false;

      sheet1.enableSheetCalculations();
      sheet1.getRangeByIndex(1, 1).columnWidth = 19.13;
      sheet1.getRangeByIndex(1, 2).columnWidth = 13.65;
      sheet1.getRangeByIndex(1, 3).columnWidth = 12.25;
      sheet1.getRangeByIndex(1, 4).columnWidth = 11.35;
      sheet1.getRangeByIndex(1, 5).columnWidth = 8.09;
      sheet1.getRangeByName('A1:A18').rowHeight = 19.47;

      //Adding cell style.
      final Style style1 = workbook.styles.add('Style1');
      style1.backColor = '#D9E1F2';
      style1.hAlign = HAlignType.left;
      style1.vAlign = VAlignType.center;
      style1.bold = true;

      final Style style2 = workbook.styles.add('Style2');
      style2.backColor = '#8EA9DB';
      style2.vAlign = VAlignType.center;
      style2.numberFormat = r'[Red]($#,###)';
      style2.bold = true;

      sheet1.getRangeByName('A10').cellStyle = style1;
      sheet1.getRangeByName('B10:D10').cellStyle.backColor = '#D9E1F2';
      sheet1.getRangeByName('B10:D10').cellStyle.hAlign = HAlignType.right;
      sheet1.getRangeByName('B10:D10').cellStyle.vAlign = VAlignType.center;
      sheet1.getRangeByName('B10:D10').cellStyle.bold = true;

      sheet1.getRangeByName('A11:A17').cellStyle.vAlign = VAlignType.center;
      sheet1.getRangeByName('A11:D17').cellStyle.borders.bottom.lineStyle =
          LineStyle.thin;
      sheet1.getRangeByName('A11:D17').cellStyle.borders.bottom.color = '#BFBFBF';

      sheet1.getRangeByName('D18').cellStyle = style2;
      sheet1.getRangeByName('D18').cellStyle.vAlign = VAlignType.center;
      sheet1.getRangeByName('A18:C18').cellStyle.backColor = '#8EA9DB';
      sheet1.getRangeByName('A18:C18').cellStyle.vAlign = VAlignType.center;
      sheet1.getRangeByName('A18:C18').cellStyle.bold = true;
      sheet1.getRangeByName('A18:C18').numberFormat = r'$#,###';



      sheet1.getRangeByName('B11:D17').numberFormat = r'$#,###';
      sheet1.getRangeByName('D11').numberFormat = r'[Red]($#,###)';
      sheet1.getRangeByName('D12').numberFormat = r'[Red]($#,###)';
      sheet1.getRangeByName('D14').numberFormat = r'[Red]($#,###)';

      sheet1.getRangeByName('B11').number = 16250;
      sheet1.getRangeByName('B12').number = 1600;
      sheet1.getRangeByName('B13').number = 1000;
      sheet1.getRangeByName('B14').number = 12400;
      sheet1.getRangeByName('B15').number = 3000;
      sheet1.getRangeByName('B16').number = 4500;
      sheet1.getRangeByName('B17').number = 3000;
      sheet1.getRangeByName('B18').formula = '=SUM(B11:B17)';

      sheet1.getRangeByName('C11').number = 17500;
      sheet1.getRangeByName('C12').number = 1828;
      sheet1.getRangeByName('C13').number = 800;
      sheet1.getRangeByName('C14').number = 14000;
      sheet1.getRangeByName('C15').number = 2600;
      sheet1.getRangeByName('C16').number = 4464;
      sheet1.getRangeByName('C17').number = 2700;
      sheet1.getRangeByName('C18').formula = '=SUM(C11:C17)';

      sheet1.getRangeByName('D11').formula = '=IF(C11>B11,C11-B11,B11-C11)';
      sheet1.getRangeByName('D12').formula = '=IF(C12>B12,C12-B12,B12-C12)';
      sheet1.getRangeByName('D13').formula = '=IF(C13>B13,C13-B13,B13-C13)';
      sheet1.getRangeByName('D14').formula = '=IF(C14>B14,C14-B14,B14-C14)';
      sheet1.getRangeByName('D15').formula = '=IF(C15>B15,C15-B15,B15-C15)';
      sheet1.getRangeByName('D16').formula = '=IF(C16>B16,C16-B16,B16-C16)';
      sheet1.getRangeByName('D17').formula = '=IF(C17>B17,C17-B17,B17-C17)';
      sheet1.getRangeByName('D18').formula = '=IF(C18>B18,C18-B18,B18-C18)';

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();
      final Directory directory =
      await path_provider.getApplicationDocumentsDirectory();
      final String path = directory.path;
      final File file = File('$path/${_categoriaAux.categoria}.xlsx');
      await file.writeAsBytes(bytes);
      //Launch the file (used open_file package)
      await open_file.OpenFile.open('$path/${_categoriaAux.categoria}.xlsx');
      //Launch file.
      //await FileSaveHelper.saveAndLaunchFile(bytes, 'ExpensesReport.xlsx');
    }
  }

