import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/dao/CRUDCategoria.dart';
import 'package:iadvancedscout/dao/CRUDEntrenador.dart';
import 'package:iadvancedscout/dao/CRUDEquipo.dart';
import 'package:iadvancedscout/dao/CRUDJugador.dart';
import 'package:iadvancedscout/dao/CRUDPais.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';
import 'package:iadvancedscout/dao/entredadorDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/futbol_mio_icons.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';

import 'package:iadvancedscout/view/equipos/equipoCardAux.dart';
import 'package:iadvancedscout/view/temporada/temporadaView.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';
import 'package:provider/provider.dart';

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
    print("PAIS");
    print(_temporadaAux.id);
    List<Pais> datos = await CRUDPais().fetchPaises(_temporadaAux);
    setState(() {
      print(datos[0].id);
      _paisAux = datos[0];
      paises.addAll(datos);
    });
  }

  _cogerCategorias() async {
    List<Categoria> datos =
        await CRUDCategoria().fetchCategorias(_temporadaAux, _paisAux);
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
                                    _cogerEquipos();
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RaisedButton.icon(
                    onPressed: () async {
                      getMigrarJugadores();
                    },
                    label: Text(
                      "Los Mejores",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    icon: Icon(
                      CustomIcon.medal,
                      size: 20,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.black,
                    color: Colors.black),
              ]),
            ],
          )),
    );
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
        print(
            "${i}:${list2[i].entrenador},${list2[i].equipo},${list2[i].categoria},${doc.id}");

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

  getMigrarJugadores() async {
    print("getMigrarJugadores");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    for (var doc in equipos) {
      print("${doc.equipo},${_temporadaAux.id},${_paisAux.id},${_categoriaAux.id}");
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
         await _db
            .collection(""
            "/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "jugadoresDATA").doc(jug.key).set(
             jug.toMap());

    }}
  }
}
