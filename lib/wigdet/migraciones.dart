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

class Migraciones extends StatefulWidget {
  Migraciones();

  @override
  _MigracionesState createState() => _MigracionesState();
}

class _MigracionesState extends State<Migraciones> {
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

  List<Equipo> equipos = List();
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
    List<Pais> datos = await CRUDPais().fetchPaises(_temporadaAux);
    setState(() {
      //print(datos[0].id);
      _paisAux = datos[0];
      paises.addAll(datos);
    });
  }

  _cogerCategorias() async {
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

  _cogerEquipos() async {
    CRUDEquipo dao = CRUDEquipo();
    List<Equipo> datos =
        await dao.fetchEquipos(_temporadaAux, _paisAux, _categoriaAux);
    setState(() {
      equipos.addAll(datos);
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
                                    if(_categoriaAux.categoria!="TODOS"){
                                      _cogerEquipos();
                                    }
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
                padding: EdgeInsets.only(left: 70, right: 70),

                width: 50,
                child:

                SizedBox(width: 150,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getMigrarJugadores();
                    //    getMigrarJugadoresUPDATE();
                    //    getMigrarJugadoresAntiguo();
                      },
                      label: Text(
                        "Antigua a Nueva",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {

                       getMigrarPuntuacionesRFEF();

                      },
                      label: Text(
                        "Puntuaciones RFEF",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {

                        getMigrarPuntuacionesNuevo2Division();

                      },
                      label: Text(
                        "Puntuaciones 2ªDivisión",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getCambiarTipoJugadores();
                        //getMigrarCiclo1();
                        //getMigrarPuntuacionesNuevo();
                        //getMigrarJugadores();
                      },
                      label: Text(
                        "Tipo de Jugadores",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getPonerTemporadaCategoriaEquipo();
                        //getMigrarCiclo1();
                        //getMigrarPuntuacionesNuevo();
                        //getMigrarJugadores();
                      },
                      label: Text(
                        "Poner Categoria",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getCambiarDorsalJugadores();
                        //getMigrarCiclo1();
                        //getMigrarPuntuacionesNuevo();
                        //getMigrarJugadores();
                      },
                      label: Text(
                        "Cambiar el Dorsal",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

              SizedBox(width: 50,
                  child:
                RaisedButton.icon(
                    onPressed: () async {
                      getMigrarCiclo1();
                    },
                    label: Text(
                      "Migrar Ciclo",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getMigrarJugadoresAntiguo();
                      },
                      label: Text(
                        "Migrar jugadores Antiguo",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getMigrarJugadoresDATA();
                      },
                      label: Text(
                        "Migrar jugadores DATABIG",
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
              Container(
                color:Colors.white,padding: EdgeInsets.only(left: 70, right: 70),
                child:

                SizedBox(width: 50,
                  child:
                  RaisedButton.icon(
                      onPressed: () async {
                        getMigrarJugadoresUPDATE();
                      },
                      label: Text(
                        "Migrar jugadores UPDATE",
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


  getMigrarJugadoresUPDATE()  async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<EquipoCloud> equipos= await JugadorDao().getDataCollectionEquipos(_temporadaAux.id,_paisAux.id,_categoriaAux.id);
    await new Future.delayed(new Duration(seconds: 1));

    List<Player> lista = new List();
    print("getMigrarJugadoresUPDATE");
    for(var equiposBASEDATOS in equipos) {
      print("${equiposBASEDATOS.nombre}");
      //EQUIPO DE LOS ANTIGUOS
      String path2 =
          "temporadas/2021-2022/paises/ESPAÑA/categorias/${_categoriaAux.categoria}/equipos/${equiposBASEDATOS
          .nombre}/jugadores";
      print(path2);
      await FirebaseDatabase.instance.reference().child(
          path2).once().then((snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        //print(values.toString());
        values.forEach((k, v) async {
          Jugador jugador = Jugador.fromJson(k, v);
          jugador.idTemporada=_temporadaAux.id;
          jugador.idPais=_paisAux.id;
          jugador.idCategoria=_categoriaAux.id;
          jugador.idEquipo=equiposBASEDATOS.key;
          String idKeyJugador=await CRUDJugador().getJugadorByNombre(_temporadaAux, _paisAux, _categoriaAux,equiposBASEDATOS.key, jugador.jugador);
          print("${jugador.jugador}:${jugador.equipo}::${idKeyJugador}");
          //print(jugador.equipo);
          try {
            await _db.collection(""
                "/temporadas/${_temporadaAux.id}/"
                "paises/${_paisAux.id}/"
                "categorias/${_categoriaAux.id}/"
                "equipos/${equiposBASEDATOS.key}/jugadores").doc(
                "${idKeyJugador}").
            update({
              "_ofe_niveltecnico": jugador.ofe_niveltecnico,
              "_ofe_profundidad": jugador.ofe_profundidad,
              "_ofe_capacidaddegenerarbuenoscentrosalarea": jugador
                  .ofe_capacidaddegenerarbuenoscentrosalarea,
              "_ofe_capacidaddeasociacion": jugador.ofe_capacidaddeasociacion,
              "_ofe_desborde": jugador.ofe_desborde,
              "_ofe_superioridadpordentro": jugador.ofe_superioridadpordentro,
              "_ofe_finalizacion": jugador.ofe_finalizacion,
              "_ofe_saquedebanda_longitud": jugador.ofe_saquedebanda_longitud,
              "_ofe_lanzadordeabps": jugador.ofe_lanzadordeabps,
              "_ofe_salidadebalon": jugador.ofe_salidadebalon,
              "_ofe_paselargo_medio": jugador.ofe_paselargo_medio,
              "_ofe_cambiosdeorientacion": jugador.ofe_cambiosdeorientacion,
              "_ofe_batelineasconpaseinterior": jugador
                  .ofe_batelineasconpaseinterior,
              "_ofe_conduccionparadividir": jugador.ofe_conduccionparadividir,
              "_ofe_primerpasetrasrecuperacion": jugador
                  .ofe_primerpasetrasrecuperacion,
              "_ofe_intervieneenabps": jugador.ofe_intervieneenabps,
              "_ofe_velocidadeneljuego": jugador.ofe_velocidadeneljuego,
              "_ofe_incorporacionazonasderemate": jugador
                  .ofe_incorporacionazonasderemate,
              "_ofe_amplitud": jugador.ofe_amplitud,
              "_ofe_desmarquesdeapoyo": jugador.ofe_desmarquesdeapoyo,
              "_ofe_desmarquesderuptura": jugador.ofe_desmarquesderuptura,
              "_ofe_capacidaddegenerarbuenoscentroslateralesalarea":
              jugador.ofe_capacidaddegenerarbuenoscentroslateralesalarea,
              "_ofe_habilidad1vs1": jugador.ofe_habilidad1vs1,
              "_ofe_realizaciondelultimopase": jugador
                  .ofe_realizaciondelultimopase,
              "_ofe_goleador": jugador.ofe_goleador,
              "_ofe_explotaciondeespacios": jugador.ofe_explotaciondeespacios,
              "_ofe_duelosaereos": jugador.ofe_duelosaereos,
              "_ofe_desbordeporvelocidad": jugador.ofe_desbordeporvelocidad,
              "_ofe_dominiode2vs1_pared": jugador.ofe_dominiode2vs1_pared,
              "_ofe_ambidextro": jugador.ofe_ambidextro,
              "_ofe_juegodecara": jugador.ofe_juegodecara,
              "_ofe_protecciondelbalon": jugador.ofe_protecciondelbalon,
              "_ofe_caidasabanda": jugador.ofe_caidasabanda,
              "_ofe_prolongacionesaereas": jugador.ofe_prolongacionesaereas,
              "_ofe_dominiodelarea": jugador.ofe_dominiodelarea,
              "_ofe_llegadaaposicionesderemate": jugador
                  .ofe_llegadaaposicionesderemate,
              "_ofe_juegoesespacioreducido": jugador.ofe_juegoesespacioreducido,
              "_ofe_definidor_anteelportero": jugador
                  .ofe_definidor_anteelportero,
              "_ofe_rematador_finalizador": jugador.ofe_rematador_finalizador,
              "_ofe_capacidadasociativa_apoyosalalineadefensiva":
              jugador.ofe_capacidadasociativa_apoyosalalineadefensiva,
              "_ofe_desplazamientoenlargo": jugador.ofe_desplazamientoenlargo,
              "_fis_velocidaddereaccion": jugador.fis_velocidaddereaccion,
              "_fis_velocidaddedesplazamiento": jugador
                  .fis_velocidaddedesplazamiento,
              "_fis_agilidad": jugador.fis_agilidad,
              "_fis_velocidaddereaccion": jugador.fis_velocidaddereaccion,
              "_fis_fuerza_potencia": jugador.fis_fuerza_potencia,
              "_fis_cuerpoacuerpo": jugador.fis_cuerpoacuerpo,
              "_fis_capacidaddesalto": jugador.fis_capacidaddesalto,
              "_fis_explosividad": jugador.fis_explosividad,
              "_fis_potenciadesaltolateralyvertical":
              jugador.fis_potenciadesaltolateralyvertical,
              "_fis_resistencia_idayvuelta": jugador.fis_resistencia_idayvuelta,
              "_fis_cambioderitmo": jugador.fis_cambioderitmo,
              "_fis_envergadura": jugador.fis_envergadura,
              "_psic_liderazgo": jugador.psic_liderazgo,
              "_psic_comunicacion": jugador.psic_comunicacion,
              "_psic_seguridad": jugador.psic_seguridad,
              "_psic_tomadedecisiones": jugador.psic_tomadedecisiones,
              "_psic_agresividad": jugador.psic_agresividad,
              "_psic_polivalencia": jugador.psic_polivalencia,
              "_psic_competitividad": jugador.psic_competitividad,
              "_psic_agresividad_contundencia": jugador
                  .psic_agresividad_contundencia,
              "_psic_noasumeriesgosextremos": jugador
                  .psic_noasumeriesgosextremos,
              "_psic_entendimientodeljuego_inteligencia":
              jugador.psic_entendimientodeljuego_inteligencia,
              "_psic_creatividad": jugador.psic_creatividad,
              "_psic_confianza": jugador.psic_confianza,
              "_psic_compromiso": jugador.psic_compromiso,
              "_psic_valentia": jugador.psic_valentia,
              "_psic_oportunismo": jugador.psic_oportunismo,
              "_def_acoso_presionsobreeloponente":
              jugador.def_acoso_presionsobreeloponente,
              "_def_actituddefensiva": jugador.def_actituddefensiva,
              "_def_activaciondelosmecanismosdepresion":
              jugador.def_activaciondelosmecanismosdepresion,
              "_def_anticipacion": jugador.def_anticipacion,
              "_def_ayudaspermanentesallateral": jugador
                  .def_ayudaspermanentesallateral,
              "_def_capacidaddemarcaje": jugador.def_capacidaddemarcaje,
              "_def_capacidadparataparcentros": jugador
                  .def_capacidadparataparcentros,
              "_def_cerrarelladodebil_basculaciones":
              jugador.def_cerrarelladodebil_basculaciones,
              "_def_cierralineasdepase": jugador.def_cierralineasdepase,
              "_def_coberturadecentrales": jugador.def_coberturadecentrales,
              "_def_coberturas": jugador.def_coberturas,
              "_def_colocacion": jugador.def_colocacion,
              "_def_comportamientofueradezona": jugador
                  .def_comportamientofueradezona,
              "_def_correctabasculacion": jugador.def_correctabasculacion,
              "_def_correctabasculacion_distanciadeintervalos":
              jugador.def_correctabasculacion_distanciadeintervalos,
              "_def_correctoperfilamiento": jugador.def_correctoperfilamiento,
              "_def_cruces": jugador.def_cruces,
              "_def_destrezaantecentroslaterales":
              jugador.def_destrezaantecentroslaterales,
              "_def_dificildesuperarenel1vs1": jugador
                  .def_dificildesuperarenel1vs1,
              "_def_dominiodelaszonasderechace": jugador
                  .def_dominiodelaszonasderechace,
              "_def_duelosaereos": jugador.def_duelosaereos,
              "_def_duelosdefensivos": jugador.def_duelosdefensivos,
              "_def_evitarecepcionesentrelineas": jugador
                  .def_evitarecepcionesentrelineas,
              "_def_evitaserdesbordado": jugador.def_evitaserdesbordado,
              "_def_interceptaciondetiro": jugador.def_interceptaciondetiro,
              "_def_mantenerlalineadefensiva": jugador
                  .def_mantenerlalineadefensiva,
              "_def_marcajeproximoaoponentedirecto":
              jugador.def_marcajeproximoaoponentedirecto,
              "_def_ocupaespaciosdecompanerossuperados":
              jugador.def_ocupaespaciosdecompanerossuperados,
              "_def_perfilamientos": jugador.def_perfilamientos,
              "_def_permiteelgiro": jugador.def_permiteelgiro,
              "_def_presiontrasperdida": jugador.def_presiontrasperdida,
              "_def_resolucionanteparedesrivales":
              jugador.def_resolucionanteparedesrivales,
              "_def_sabecuidarsuespalda": jugador.def_sabecuidarsuespalda,
              "_def_vigilayreferenciaalrival_enfaseofensiva":
              jugador.def_vigilayreferenciaalrival_enfaseofensiva,
              "_def_vigilanciassobrelateralrival":
              jugador.def_vigilanciassobrelateralrival,
              "_def_blocaje": jugador.def_blocaje,
              "_def_juegoaereolateral": jugador.def_juegoaereolateral,
              "_def_juegoaereofrontal": jugador.def_juegoaereofrontal,
              "_def_habilidadenel1vs1": jugador.def_habilidadenel1vs1,
              "_def_despeje": jugador.def_despeje,
              "_def_anticipacion_intuicion": jugador.def_anticipacion_intuicion,
              "_def_coberturadelineadefensiva": jugador
                  .def_coberturadelineadefensiva,
              "_def_abps": jugador.def_abps,
              "_def_penaltis": jugador.def_penaltis
            });
          }catch(e){
            print("ERROR:${jugador.jugador}:${jugador.equipo}::${idKeyJugador}");
          }
        });
      });
    }
    print("FIN");
  }

  getMigrarJugadoresSoloEquipoESPANA()  async {
    String equipoAux="Internacional Madrid";
    String equipoID="8jrrYhokZHyJXedpu0wR";
    String categoriaID="rAeKFLQSry7l1x0WVW01";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> lista = new List();
    print("getJugadores");
    String path2 =
        "temporadas/2021-2022/paises/ESPAÑA/categorias/1ª División RFEF Grupo 1/equipos/$equipoAux/jugadores";
    print(path2);
    await FirebaseDatabase.instance.reference().child(
        path2).once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      //print(values.toString());
      values.forEach((k, v) {
        print("${v["jugador"]}:${equipoAux}:${equipoID}");
        Jugador jugador = Jugador.fromJson(k, v);
        //print(jugador.jugador);
        //print(jugador.equipo);
        Player player=Player.fromJsonJugador(jugador);
        //lista.add(player);
        _db.collection(""
            "/temporadas/BuJNv17ghCPGnq37P2ev/"
            "paises/QqjzloEo6PI7sHfsffk2/"
            "categorias/rAeKFLQSry7l1x0WVW01/"
            "equipos/${equipoID}/jugadores")
            .add(player.toMap());
      });
    });
    return lista;
  }

  cogerEquipos()async{
 //   https://iadvancedscout-default-rtdb.firebaseio.com/temporadas/2021-2022/paises/ESPA%C3%91A/categorias/1%C2%AA%20Divisio%CC%81n%20RFEF%20Grupo%201/equipos/Athletic%20Bilbao%20B/jugadores
 //   https://iadvancedscout-default-rtdb.firebaseio.com/temporadas/2021-2022/paises/ESPA%C3%91A/categorias/1%C2%AA%20Divisi%C3%B3n%20RFEF%20Grupo%201/equipos/Athletic%20Bilbao%20B/jugadores
  }

  List<String> getEquipo() {
    List<String> equiposList=[];
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    equiposList.clear();
    _database.reference()
        .child('temporadas/${_temporadaAux.temporada}/paises/${_paisAux.pais}/categorias/${_categoriaAux.categoria}/equipos')
        .once()
        .then((DataSnapshot snapshotResult) {
      if (snapshotResult == null || snapshotResult.value == null) return;
      Map<dynamic, dynamic> paisesMap = snapshotResult.value;
      paisesMap.forEach((key, value) {
       print(
          "/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos");
        _db.collection(""
          "/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos")
          .add({"equipo" : value["equipo"]});
        print(value["equipo"]);

      });
    });
    return equiposList;
  }

  getMigrarJugadoresAntiguo()  async {
    List<String> equipos= await getEquipo();
    await new Future.delayed(new Duration(seconds: 1));
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> lista = new List();
    print("getJugadoresAntiguo");
    for(var equiposAntigua in equipos) {
      print("${equiposAntigua}");
      /*_db.collection(""
          "/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos")
          .add({"equipo" : equiposAntigua});*/
      }
  }


  getMigrarJugadores()  async {
    List<EquipoCloud> equipos= await JugadorDao().getDataCollectionEquipos(_temporadaAux.id,_paisAux.id,_categoriaAux.id);
    await new Future.delayed(new Duration(seconds: 1));
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> lista = new List();
    print("getJugadores");
    for(var equiposBASEDATOS in equipos) {
      print("${equiposBASEDATOS.nombre}");
      String path2 =
          "temporadas/2020-2021/paises/ESPAÑA/categorias/${_categoriaAux.categoria}/equipos/${equiposBASEDATOS
          .nombre}/jugadores";
      print(path2);
      await FirebaseDatabase.instance.reference().child(
          path2).once().then((snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((k, v) {
          Jugador jugador = Jugador.fromJson(k, v);
          jugador.idTemporada=_temporadaAux.id;
          jugador.idPais=_paisAux.id;
          jugador.idCategoria=_categoriaAux.id;
          jugador.idEquipo=equiposBASEDATOS.key;

          //print(jugador.equipo);
          Player player=Player.fromJsonJugador(jugador);
          lista.add(player);
          _db.collection(""
              "/temporadas/${_temporadaAux.id}/"
              "paises/${_paisAux.id}/"
              "categorias/${_categoriaAux.id}/"
              "equipos/${equiposBASEDATOS.key}/jugadores")
              .add(player.toMap());
        });
      });
    }
    return lista;
  }

  getMigrarEntrenador() async {
    print("getMigrarEntrenador");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    EntrenadorDao dao = new EntrenadorDao();
    for (var doc in equipos) {
      print("${doc.equipo},${doc.categoria},${doc.temporada}");
      List<Entrenador> list2 =
          await dao.getEntrenadoresSolo(_categoriaAux, doc);
      for (var i = 0; i < list2.length; i++) {

        //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
        print("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${doc.id}/entrenadores");
        await _db
            .collection(""
                "/temporadas/${_temporadaAux.id}/"
                "paises/${_paisAux.id}/"
                "categorias/${_categoriaAux.id}/"
                "equipos/${doc.id}/entrenadores")
            .add(list2[i].toMap());
      }
    }
  }

  getMigrarEntrenadorSoloEquipo() async {
    print("getMigrarEntrenador");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    String equipoId = "8jrrYhokZHyJXedpu0wR";
    String equipo = "Internacional Madrid";
    EntrenadorDao dao = new EntrenadorDao();
    List<Entrenador> list2 = await dao.getEntrenadoresSoloEquipo(equipo);
    for (var i = 0; i < list2.length; i++) {
      print(
          "${i}:${list2[i].entrenador},${list2[i].equipo},${list2[i].categoria}");
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
      print("/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${equipoId}/entrenadores");
      await _db
          .collection(""
              "/temporadas/${_temporadaAux.id}/"
              "paises/${_paisAux.id}/"
              "categorias/${_categoriaAux.id}/"
              "equipos/${equipoId}/entrenadores")
          .add(list2[i].toMap());
    }
  }

  getMigrarJugadoresDATA() async {
    print("getMigrarJugadoresDATA");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    print(equipos.length);
    for (var doc in equipos) {
      print(
          "${doc.equipo},${doc.categoria},${doc.id}");
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
      print("/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${doc.id}/jugadores");
      CRUDJugador dao=CRUDJugador();
      List<Player> jugadores=await dao.fetchJugadoresList(_temporadaAux, _paisAux, _categoriaAux, doc);
      for (var jug in jugadores) {
        print(jug.key);
        print(jug.jugador);
        print(jug.equipo);
        jug.idTemporada="${_temporadaAux.id}";
        jug.idPais="${_paisAux.id}";
        jug.idCategoria="${_categoriaAux.id}";
        jug.idEquipo=doc.id;
         await _db
            .collection(""
            "/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "jugadoresDATA").doc(jug.key).set(
             jug.toMap());

    }}
  }


  getCambiarTipoJugadores() async {
    print("getCambiarTipoJugadores");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    print(equipos.length);
    for (var doc in equipos) {
     /* print("${doc.equipo},${_temporadaAux.id},${_paisAux.id},${_categoriaAux.id}");
      print(
          "${doc.equipo},${doc.categoria},${doc.id}");
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
      print("/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${doc.id}/jugadores");*/
      CRUDJugador dao=CRUDJugador();
      List<Player> jugadores=await dao.fetchJugadoresList(_temporadaAux, _paisAux, _categoriaAux, doc);
      for (var jug in jugadores) {
        //print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${jug.tipo}");
         String tipoAux= listaTiposAux(jug.posicion);
        String tipoLetraAux=listaTiposLetraAux(jug.tipoAntiguo);
         String tipoNuevo="";
         if(tipoLetraAux!="")
            tipoNuevo= tipoAux+tipoLetraAux;
        //jug.tipo=tipoNuevo;
        print("${jug.equipo}:${jug.jugador}:${jug.tipoAntiguo}:${jug.tipoAntiguo}:${tipoNuevo}");
        await _db
            .collection("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${doc.id}/jugadores").doc(jug.key).update({"tipo": tipoNuevo});
      }}
  }


  getPonerTemporadaCategoriaEquipo() async {
    print("getPonerTemporadaCategoriaEquipo");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    print(equipos.length);
    for (var doc in equipos) {
      CRUDJugador dao=CRUDJugador();
      List<Player> jugadores=await dao.fetchJugadoresList(_temporadaAux, _paisAux, _categoriaAux, doc);
      for (var jug in jugadores) {
        //print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${jug.tipo}");
        String tipoAux= listaTiposAux(jug.posicion);
        String tipoLetraAux=listaTiposLetraAux(jug.tipo);
        String tipoNuevo= tipoAux+tipoLetraAux;
        //jug.tipo=tipoNuevo;
        if(jug.nacionalidad=="Español") {
          print("${doc.equipo}:${jug.jugador}:${jug.posicion}");
          await _db
              .collection("/temporadas/${_temporadaAux.id}/"
              "paises/${_paisAux.id}/"
              "categorias/${_categoriaAux.id}/"
              "equipos/${doc.id}/jugadores").doc(jug.key).update(
              {"categoria": _categoriaAux.categoria,
                "equipo": doc.equipo,
                "temporada": _temporadaAux.temporada});
        }
      }}
  }

  getCambiarDorsalJugadores() async {
    print("getCambiarDorsalJugadores");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    print(equipos.length);
    for (var doc in equipos) {
      /* print("${doc.equipo},${_temporadaAux.id},${_paisAux.id},${_categoriaAux.id}");
      print(
          "${doc.equipo},${doc.categoria},${doc.id}");
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
      print("/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${doc.id}/jugadores");*/
      CRUDJugador dao=CRUDJugador();
      List<Player> jugadores=await dao.fetchJugadoresList(_temporadaAux, _paisAux, _categoriaAux, doc);
      for (var jug in jugadores) {
        //print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${jug.tipo}");
        //print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${jug.dorsal}");
        int dorsal=0;
        if(jug.dorsal==99){
          print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${jug.dorsal}");
          await _db
              .collection("/temporadas/${_temporadaAux.id}/"
              "paises/${_paisAux.id}/"
              "categorias/${_categoriaAux.id}/"
              "equipos/${doc.id}/jugadores").doc(jug.key).update({"dorsal": 99,"dorsalAntiguo": jug.dorsal});

        }


      }}
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


  getMigrarPuntuacionesRFEF() async {
    print("getMigrarPuntuaciones");
    CRUDPartido dao = CRUDPartido();
    CRUDJugador daoJug = CRUDJugador();
    JugadorDao daoJugDAO = JugadorDao();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> jugadoresCASABBDD = await daoJugDAO.getPuntacionesJornadas(_categoriaAux.categoria);
    //jornadas=jornadas.sublist(1);

    for(var jugador in jugadoresCASABBDD){
      print("${jugador.equipo}:${jugador.jugador}");
      try {
      String idKeyEquipo=await CRUDEquipo().getEquipoByNombre(_temporadaAux, _paisAux, _categoriaAux, jugador.equipo);
      String idKeyJugador=await CRUDJugador().getJugadorByNombre(_temporadaAux, _paisAux, _categoriaAux,idKeyEquipo, jugador.jugador);

        print("${idKeyEquipo}:${idKeyJugador}:${jugador.equipo}:${jugador
            .jugador}");
        await _db.collection("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${idKeyEquipo}/jugadores").doc("${idKeyJugador}").update(
            {
              "dorsal": jugador.dorsal,
              "puntaciones_jornada_1": "${puntuacionEstado(jugador.puntaciones_jornada_1)}",
              "puntaciones_jornada_2": "${puntuacionEstado(jugador.puntaciones_jornada_2)}",
              "puntaciones_jornada_3": "${puntuacionEstado(jugador.puntaciones_jornada_3)}",
              "puntaciones_jornada_4": "${puntuacionEstado(jugador.puntaciones_jornada_4)}",
              "puntaciones_jornada_5": "${puntuacionEstado(jugador.puntaciones_jornada_5)}",
              "puntaciones_jornada_6": "${puntuacionEstado(jugador.puntaciones_jornada_6)}",
              "puntaciones_jornada_7": "${puntuacionEstado(jugador.puntaciones_jornada_7)}",
              "puntaciones_jornada_8": "${puntuacionEstado(jugador.puntaciones_jornada_8)}",
              "puntaciones_jornada_9": "${puntuacionEstado(jugador.puntaciones_jornada_9)}",
              "puntaciones_jornada_10": "${puntuacionEstado(jugador.puntaciones_jornada_10)}",
              "puntaciones_jornada_11": "${puntuacionEstado(jugador.puntaciones_jornada_11)}",
              "puntaciones_jornada_12": "${puntuacionEstado(jugador.puntaciones_jornada_12)}",
              "puntaciones_jornada_13": "${puntuacionEstado(jugador.puntaciones_jornada_13)}",
              "puntaciones_jornada_14": "${puntuacionEstado(jugador.puntaciones_jornada_14)}",
              "puntaciones_jornada_15": "${puntuacionEstado(jugador.puntaciones_jornada_15)}",
              "puntaciones_jornada_16": "${puntuacionEstado(jugador.puntaciones_jornada_16)}",
              "puntaciones_jornada_17": "${puntuacionEstado(jugador.puntaciones_jornada_17)}",
              "puntaciones_jornada_18": "${puntuacionEstado(jugador.puntaciones_jornada_18)}",
              "puntaciones_jornada_19": "${puntuacionEstado(jugador.puntaciones_jornada_19)}",
              "puntaciones_jornada_20": "${puntuacionEstado(jugador.puntaciones_jornada_20)}",
              "puntaciones_jornada_21": "${puntuacionEstado(jugador.puntaciones_jornada_21)}",

              "estado_jornada_1": "${estadoPuntuacion(jugador.puntaciones_jornada_1)}",
            "estado_jornada_2": "${estadoPuntuacion(jugador.puntaciones_jornada_2)}",
            "estado_jornada_3": "${estadoPuntuacion(jugador.puntaciones_jornada_3)}",
            "estado_jornada_4": "${estadoPuntuacion(jugador.puntaciones_jornada_4)}",
            "estado_jornada_5": "${estadoPuntuacion(jugador.puntaciones_jornada_5)}",
            "estado_jornada_6": "${estadoPuntuacion(jugador.puntaciones_jornada_6)}",
            "estado_jornada_7": "${estadoPuntuacion(jugador.puntaciones_jornada_7)}",
            "estado_jornada_8": "${estadoPuntuacion(jugador.puntaciones_jornada_8)}",
            "estado_jornada_9": "${estadoPuntuacion(jugador.puntaciones_jornada_9)}",
            "estado_jornada_10": "${estadoPuntuacion(jugador.puntaciones_jornada_10)}",
            "estado_jornada_11": "${estadoPuntuacion(jugador.puntaciones_jornada_11)}",
            "estado_jornada_12": "${estadoPuntuacion(jugador.puntaciones_jornada_12)}",
            "estado_jornada_13": "${estadoPuntuacion(jugador.puntaciones_jornada_13)}",
            "estado_jornada_14": "${estadoPuntuacion(jugador.puntaciones_jornada_14)}",
            "estado_jornada_15": "${estadoPuntuacion(jugador.puntaciones_jornada_15)}",
              "estado_jornada_16": "${estadoPuntuacion(jugador.puntaciones_jornada_16)}",
              "estado_jornada_17": "${estadoPuntuacion(jugador.puntaciones_jornada_17)}",
              "estado_jornada_18": "",
              "estado_jornada_19": "",
              "estado_jornada_20": "",
              "estado_jornada_21":"",
               "paisNacimiento" : "${jugador.paisNacimiento}",
              "ccaa" : "${jugador.ccaa}",
              "nacionalidad" : "${jugador.nacionalidad}",

            }
        );
      }catch(e){
        print("ERRRRROOOOORR:${jugador.equipo}:${jugador.jugador}");
      }

    }
  }



  getMigrarPuntuacionesNuevo2Division() async {
    print("getMigrarPuntuacionesNuevo2Division");
    CRUDPartido dao = CRUDPartido();
    CRUDJugador daoJug = CRUDJugador();
    JugadorDao daoJugDAO = JugadorDao();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> jugadoresCASABBDD = await daoJugDAO.getPuntacionesJornadas2Divsion(_categoriaAux.categoria);
    //jornadas=jornadas.sublist(1);

    for(var jugador in jugadoresCASABBDD){
      print("${jugador.equipo}:${jugador.jugador}");
      try {
        String idKeyEquipo=await CRUDEquipo().getEquipoByNombre(_temporadaAux, _paisAux, _categoriaAux, jugador.equipo);
        String idKeyJugador=await CRUDJugador().getJugadorByNombre(_temporadaAux, _paisAux, _categoriaAux,idKeyEquipo, jugador.jugador);

        print("${idKeyEquipo}:${idKeyJugador}:${jugador.equipo}:${jugador
            .jugador}");
        await _db.collection("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${idKeyEquipo}/jugadores").doc("${idKeyJugador}").update(
            {
              "lateral": "${puntuacionEstado(jugador.lateral)}",
              "valor": "${puntuacionEstado(jugador.valor)}",
              "dorsal": jugador.dorsal,
              "prestamo": "${puntuacionEstado(jugador.prestamo)}",
              "peso": "${puntuacionEstado(jugador.peso)}",
              "altura": "${puntuacionEstado(jugador.altura)}",
              "fechaContrato": "${puntuacionEstado(jugador.fechaContrato)}",
              "puntaciones_jornada_1": "${puntuacionEstado(jugador.puntaciones_jornada_1)}",
              "puntaciones_jornada_2": "${puntuacionEstado(jugador.puntaciones_jornada_2)}",
              "puntaciones_jornada_3": "${puntuacionEstado(jugador.puntaciones_jornada_3)}",
              "puntaciones_jornada_4": "${puntuacionEstado(jugador.puntaciones_jornada_4)}",
              "puntaciones_jornada_5": "${puntuacionEstado(jugador.puntaciones_jornada_5)}",
              "puntaciones_jornada_6": "${puntuacionEstado(jugador.puntaciones_jornada_6)}",
              "puntaciones_jornada_7": "${puntuacionEstado(jugador.puntaciones_jornada_7)}",
              "puntaciones_jornada_8": "${puntuacionEstado(jugador.puntaciones_jornada_8)}",
              "puntaciones_jornada_9": "${puntuacionEstado(jugador.puntaciones_jornada_9)}",
              "puntaciones_jornada_10": "${puntuacionEstado(jugador.puntaciones_jornada_10)}",
              "puntaciones_jornada_11": "${puntuacionEstado(jugador.puntaciones_jornada_11)}",
              "puntaciones_jornada_12": "${puntuacionEstado(jugador.puntaciones_jornada_12)}",
              "puntaciones_jornada_13": "${puntuacionEstado(jugador.puntaciones_jornada_13)}",
              "puntaciones_jornada_14": "${puntuacionEstado(jugador.puntaciones_jornada_14)}",
              "puntaciones_jornada_15": "${puntuacionEstado(jugador.puntaciones_jornada_15)}",
              "puntaciones_jornada_16": "${puntuacionEstado(jugador.puntaciones_jornada_16)}",
              "puntaciones_jornada_17": "${puntuacionEstado(jugador.puntaciones_jornada_17)}",
              "puntaciones_jornada_18": "${puntuacionEstado(jugador.puntaciones_jornada_18)}",
              "puntaciones_jornada_19": "${puntuacionEstado(jugador.puntaciones_jornada_19)}",
              "puntaciones_jornada_20": "${puntuacionEstado(jugador.puntaciones_jornada_20)}",
              "puntaciones_jornada_21": "${puntuacionEstado(jugador.puntaciones_jornada_21)}",

              "estado_jornada_1": "${estadoPuntuacion(jugador.puntaciones_jornada_1)}",
              "estado_jornada_2": "${estadoPuntuacion(jugador.puntaciones_jornada_2)}",
              "estado_jornada_3": "${estadoPuntuacion(jugador.puntaciones_jornada_3)}",
              "estado_jornada_4": "${estadoPuntuacion(jugador.puntaciones_jornada_4)}",
              "estado_jornada_5": "${estadoPuntuacion(jugador.puntaciones_jornada_5)}",
              "estado_jornada_6": "${estadoPuntuacion(jugador.puntaciones_jornada_6)}",
              "estado_jornada_7": "${estadoPuntuacion(jugador.puntaciones_jornada_7)}",
              "estado_jornada_8": "${estadoPuntuacion(jugador.puntaciones_jornada_8)}",
              "estado_jornada_9": "${estadoPuntuacion(jugador.puntaciones_jornada_9)}",
              "estado_jornada_10": "${estadoPuntuacion(jugador.puntaciones_jornada_10)}",
              "estado_jornada_11": "${estadoPuntuacion(jugador.puntaciones_jornada_11)}",
              "estado_jornada_12": "${estadoPuntuacion(jugador.puntaciones_jornada_12)}",
              "estado_jornada_13": "${estadoPuntuacion(jugador.puntaciones_jornada_13)}",
              "estado_jornada_14": "${estadoPuntuacion(jugador.puntaciones_jornada_14)}",
              "estado_jornada_15": "${estadoPuntuacion(jugador.puntaciones_jornada_15)}",
              "estado_jornada_16": "${estadoPuntuacion(jugador.puntaciones_jornada_16)}",
              "estado_jornada_17": "${estadoPuntuacion(jugador.puntaciones_jornada_17)}",
              "estado_jornada_18": "${estadoPuntuacion(jugador.puntaciones_jornada_18)}",
              "estado_jornada_19": "${estadoPuntuacion(jugador.puntaciones_jornada_19)}",
              "estado_jornada_20": "${estadoPuntuacion(jugador.puntaciones_jornada_20)}",
              "estado_jornada_21": "${estadoPuntuacion(jugador.puntaciones_jornada_21)}",
                "paisNacimiento" : "${jugador.paisNacimiento}",
              "ccaa" : "${jugador.ccaa}",
              "nacionalidad" : "${jugador.nacionalidad}",

            }
        );
      }catch(e){
        print("ERRRRROOOOORR:${jugador.equipo}:${jugador.jugador}");
      }

    }
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

  getMigrarNacionalidad() async {
    print("getMigrarNacionalidad");
    CRUDPartido dao = CRUDPartido();
    CRUDJugador daoJug = CRUDJugador();
    JugadorDao daoJugDAO = JugadorDao();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> jugadoresCASABBDD = await daoJugDAO.getPuntacionesJornadas(_categoriaAux.categoria);
    //jornadas=jornadas.sublist(1);

    for(var jugador in jugadoresCASABBDD){
      print("${jugador.equipo}:${jugador.jugador}");
      try {
        String idKeyEquipo=await CRUDEquipo().getEquipoByNombre(_temporadaAux, _paisAux, _categoriaAux, jugador.equipo);
        String idKeyJugador=await CRUDJugador().getJugadorByNombre(_temporadaAux, _paisAux, _categoriaAux,idKeyEquipo, jugador.jugador);

        print("${idKeyEquipo}:${idKeyJugador}:${jugador.equipo}:${jugador
            .jugador}");
        await _db.collection("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${idKeyEquipo}/jugadores").doc("${idKeyJugador}").update(
            {
              "paisNacimiento" : "${jugador.paisNacimiento}",
              "ccaa" : "${jugador.ccaa}",
              "nacionalidad" : "${jugador.nacionalidad}",

            }
              );
      }catch(e){
        print("ERRRRROOOOORR:${jugador.equipo}:${jugador.jugador}");
      }

    }
  }

  getMigrarNacionalidadEspanol() async {
    print("getMigrarNacionalidad");
    CRUDPartido dao = CRUDPartido();
    CRUDJugador daoJug = CRUDJugador();
    JugadorDao daoJugDAO = JugadorDao();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> jugadoresCASABBDD = await daoJugDAO.getPuntacionesJornadas(_categoriaAux.categoria);
    //jornadas=jornadas.sublist(1);

    for(var jugador in jugadoresCASABBDD){
      print("${jugador.equipo}:${jugador.jugador}");
      try {
        String idKeyEquipo=await CRUDEquipo().getEquipoByNombre(_temporadaAux, _paisAux, _categoriaAux, jugador.equipo);
        String idKeyJugador=await CRUDJugador().getJugadorByNombre(_temporadaAux, _paisAux, _categoriaAux,idKeyEquipo, jugador.jugador);

        print("${idKeyEquipo}:${idKeyJugador}:${jugador.equipo}:${jugador
            .jugador}");

        await _db.collection("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${idKeyEquipo}/jugadores").doc("${idKeyJugador}").update(
            {
              "paisNacimiento" : "${jugador.paisNacimiento}",
              "ccaa" : "${jugador.ccaa}",
              "nacionalidad" : "${jugador.nacionalidad}",

            }
        );
      }catch(e){
        print("ERRRRROOOOORR:${jugador.equipo}:${jugador.jugador}");
      }

    }
  }

getMigrarCiclo1() async {
  print("getCiclo1");
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  print(equipos.length);
  CRUDPartido dao = CRUDPartido();
  CRUDJugador daoJug = CRUDJugador();
  JugadorDao daoJugDAO = JugadorDao();
  List<Player> jugadoresBBDD = await daoJugDAO.getPuntacionesJornadas(_categoriaAux.categoria);

  for (var doc in equipos) {
    print("${doc.equipo},${_temporadaAux.id},${_paisAux.id},${_categoriaAux.id}");
    print(
        "${doc.equipo},${doc.categoria},${doc.id}");
    CRUDJugador dao=CRUDJugador();
    List<Player> jugadores=await dao.fetchJugadoresList(_temporadaAux, _paisAux, _categoriaAux, doc);
    for (var jug in jugadores) {
      String ciclo="";
      List<Player> outputList = jugadoresBBDD.where((o) =>
      o.jugador== jug.jugador).toList();
      if(outputList.length>0) {
        if (outputList.length == 1) {
         ciclo=outputList[0].nivel;
        }
        else {
          if (outputList[0].equipo == jug.equipo)
            ciclo=outputList[0].nivel;
          if (outputList[1].equipo == jug.equipo)
            ciclo=outputList[1].nivel;
        }
      }
      else{
        ciclo="";
      }

      print("${jug.key}:${jug.jugador}:${jug.equipo}:${ciclo}");
      print("/temporadas/${_temporadaAux.id}/paises/${_paisAux.id}/categorias/${_categoriaAux.id}/equipos/${doc.id}/jugadores/${jug.key}");
     /* await _db
          .collection(""
          "/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${doc.id}/jugadores").doc(jug.key).update({"nivel": ciclo});*/

    }}
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

