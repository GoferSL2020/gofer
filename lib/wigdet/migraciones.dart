import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/equipo.dart';
import 'package:iadvancedscout/modelo/jornada.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/partido.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/modelo/temporada.dart';

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
                                    _cogerEquipos();
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
                        ]),
                      ])),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RaisedButton.icon(
                    onPressed: () async {
                      getMigrarCiclo1();
                      //getMigrarPuntuaciones();
                      //getMigrarJugadores();
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
    print(equipos.length);
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


  getMigrarPuntuaciones() async {
    print("getMigrarPuntuaciones");
    CRUDPartido dao = CRUDPartido();
    CRUDJugador daoJug = CRUDJugador();
    JugadorDao daoJugDAO = JugadorDao();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<Player> jugadoresCASABBDD = await daoJugDAO.getPuntacionesJornadas();
    List<Player> jugadoresFUERABBDD = await daoJugDAO.getPuntacionesJornadas();
    //jornadas=jornadas.sublist(1);
    for (int i=0;i<17;i++) {
      Jornada jornada=jornadas[i];
      print("${jornada.jornada},${jornada.fecha},${jornada.id}");
      print("${DateTime.now()}");
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ


      List<Partido> partidos = await dao.fetchPartidosJornada(
          _temporadaAux, _paisAux, _categoriaAux, jornada);
      for (var partido in partidos) {
        List<Player> jugadoresCASA = await daoJug.fetchJugadores(
            _temporadaAux, _paisAux, _categoriaAux, partido.equipoCASA);
        List<Player> jugadoresFUERA = await daoJug.fetchJugadores(
            _temporadaAux, _paisAux, _categoriaAux, partido.equipoFUERA);
        //print("/temporadas/${_temporadaAux.id}/""paises/${_paisAux.id}/""categorias/${_categoriaAux.id}/""jornadas/${jornada.id}/partidos/${partido.id}");
        for (var jugCASA in jugadoresCASA) {
            List<Player> outputList = jugadoresCASABBDD.where((o) =>
            (o.jugador) == (jugCASA.jugador)).toList();
           // print("/temporadas/${_temporadaAux.id}/""paises/${_paisAux.id}/""categorias/${_categoriaAux.id}/""jornadas/${jornada.id}/partidos/${partido.id}/jugadoresCASA/${jugCASA.key}");
            if(outputList.length>0) {
              if (outputList.length == 1) {
                jugCASA.ponerPuntuacion(outputList[0], jornada.jornada);
              }
              else {
                if (outputList[0].equipo == jugCASA.equipo)
                  jugCASA.ponerPuntuacion(outputList[0], jornada.jornada);
                if (outputList[1].equipo == jugCASA.equipo)
                  jugCASA.ponerPuntuacion(outputList[1], jornada.jornada);
              }
            }
            else{
              jugCASA.accion="";
              jugCASA.puntuacion=0;
            }
            await _db.collection("/temporadas/${_temporadaAux.id}/"
                "paises/${_paisAux.id}/"
                "categorias/${_categoriaAux.id}/"
                "jornadas/${jornada.id}/partidos/${partido.id}/jugadoresCASA").doc(jugCASA.key).set(
                jugCASA.toJsonPuntuaciones());
          print("LOCAL:${jornada.jornada}: ${jugCASA.jugador}:${jugCASA.accion}:${jugCASA.puntuacion}:");
        }
        for (var jugFUERA in jugadoresFUERA) {
            List<Player> outputList = jugadoresCASABBDD.where((o) =>
            o.jugador== jugFUERA.jugador).toList();
          //  print("/temporadas/${_temporadaAux.id}/""paises/${_paisAux.id}/""categorias/${_categoriaAux.id}/""jornadas/${jornada.id}/partidos/${partido.id}/jugadoresFUERA/${jugFUERA.key}");
            if(outputList.length>0) {
              if (outputList.length == 1) {
                jugFUERA.ponerPuntuacion(outputList[0], jornada.jornada);
              }
              else {
                if (outputList[0].equipo == jugFUERA.equipo)
                  jugFUERA.ponerPuntuacion(outputList[0], jornada.jornada);
                if (outputList[1].equipo == jugFUERA.equipo)
                  jugFUERA.ponerPuntuacion(outputList[1], jornada.jornada);
              }
            }
            else{
              jugFUERA.accion="";
              jugFUERA.puntuacion=0;
            }
            await _db.collection("/temporadas/${_temporadaAux.id}/"
                "paises/${_paisAux.id}/"
                "categorias/${_categoriaAux.id}/"
                "jornadas/${jornada.id}/partidos/${partido.id}/jugadoresFUERA").doc(jugFUERA.key).set(
                jugFUERA.toJsonPuntuaciones());
            print("VISITANTE:${jornada.jornada}: ${jugFUERA.jugador}:${jugFUERA.accion}:${jugFUERA.puntuacion}:");
          }
        }
    }
    print("${DateTime.now()}");
  }


getMigrarCiclo1() async {
  print("getCiclo1");
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  print(equipos.length);
  CRUDPartido dao = CRUDPartido();
  CRUDJugador daoJug = CRUDJugador();
  JugadorDao daoJugDAO = JugadorDao();
  List<Player> jugadoresBBDD = await daoJugDAO.getPuntacionesJornadas();

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

   //   print("${jug.key}:${jug.jugador}:${jug.equipo}:${ciclo}");
      print("/temporadas/${_temporadaAux.id}/paises/${_paisAux.id}/categorias/${_categoriaAux.id}/equipos/${doc.id}/jugadores/${jug.key}");
      await _db
          .collection(""
          "/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${doc.id}/jugadores").doc(jug.key).update({"nivel": ciclo});

    }}
}
}