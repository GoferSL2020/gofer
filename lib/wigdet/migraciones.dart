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
                      getMigrarPuntuacionesNuevo();
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


  getMigrarJugadoresUPDATE()  async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<EquipoCloud> equipos= await JugadorDao().getDataCollectionEquipos(_temporadaAux.id,_paisAux.id,_categoriaAux.id);
    await new Future.delayed(new Duration(seconds: 1));

    List<Player> lista = new List();
    print("getJugadores");
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
          if(v["_prestamo"]==null) jugador.prestamo="no";
          print("${v["jugador"]}, PRESTAMO:${v["_prestamo"]},PRESTAMO:${jugador.prestamo}:${equiposBASEDATOS.nombre}:${equiposBASEDATOS.key}");

          String idKeyJugador=await CRUDJugador().getJugadorByNombre(_temporadaAux, _paisAux, _categoriaAux,equiposBASEDATOS.key, jugador.jugador);
          print("${jugador.jugador}:${jugador.equipo}:${jugador.prestamo}:${idKeyJugador}");
          print("/temporadas/${_temporadaAux.id}/"
          "paises/${_paisAux.id}/"
          "categorias/${_categoriaAux.id}/"
          "equipos/${equiposBASEDATOS.key}/jugadores/${idKeyJugador}");
          //print(jugador.equipo);
          _db.collection(""
              "/temporadas/${_temporadaAux.id}/"
              "paises/${_paisAux.id}/"
              "categorias/${_categoriaAux.id}/"
              "equipos/${equiposBASEDATOS.key}/jugadores").doc("${idKeyJugador}").
              update({
                  "prestamo" : jugador.prestamo
                });
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

  getMigrarJugadoresDATA() async {
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

  ponerExcelJugadores() async {
    print("ponerExcelJugadores");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    for (var doc in equipos) {
      //temporadas/BuJNv17ghCPGnq37P2ev/paises/QqjzloEo6PI7sHfsffk2/categorias/rAeKFLQSry7l1x0WVW01/equipos/tbXIokAhjIMVyuNWcUyZ
      CRUDJugador dao = CRUDJugador();
      List<Player> jugadores = await dao.fetchJugadoresList(
          _temporadaAux, _paisAux, _categoriaAux, doc);
      for (var jug in jugadores) {
        //jug.tipo=tipoNuevo;
        print("${jug.temporada}:${jug.categoria}:${jug.equipo}:${jug.jugador}:"
            "${jug.dorsal}:${jug.posicion}:${jug.posicionalternativa}"
            ":${jug.nacionalidad}:${jug.pais}:${jug.ccaa}:${jug
            .fechaNacimiento}:${Config.edad(jug.fechaNacimiento)}:"
            "${jug.puntaciones_jornada_1}:"
            "${jug.puntaciones_jornada_2}:"
            "${jug.puntaciones_jornada_3}:"
            "${jug.puntaciones_jornada_4}:"
            "${jug.puntaciones_jornada_5}:"
            "${jug.puntaciones_jornada_6}:"
            "${jug.puntaciones_jornada_7}:"
            "${jug.puntaciones_jornada_8}:"
            "${jug.puntaciones_jornada_9}:"
            "${jug.puntaciones_jornada_10}:"
            "${jug.puntaciones_jornada_11}:"
            "${jug.puntaciones_jornada_12}:"
            "${jug.puntaciones_jornada_13}:"
            "${jug.puntaciones_jornada_14}:"
            "${jug.puntaciones_jornada_15}:"
            "${jug.puntaciones_jornada_16}:"
            "${jug.puntaciones_jornada_17}:"
            "${jug.nacionalidad}:"
            "${jug.paisNacimiento}:"
            "${jug.ccaa}:"
            "${jug.prestamo}:"
            "");
      }
    }
  }

  getCambiarTipoJugadores() async {
    print("getCambiarTipoJugadores");
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
        print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${jug.tipo}");
         String tipoAux= listaTiposAux(jug.posicion);
        String tipoLetraAux=listaTiposLetraAux(jug.tipo);
        String tipoNuevo= tipoAux+tipoLetraAux;
        //jug.tipo=tipoNuevo;
        print("${jug.equipo}:${jug.jugador}:${jug.posicion}:${tipoNuevo}");
        await _db
            .collection("/temporadas/${_temporadaAux.id}/"
            "paises/${_paisAux.id}/"
            "categorias/${_categoriaAux.id}/"
            "equipos/${doc.id}/jugadores").doc(jug.key).update({"tipo": tipoNuevo,"tipoAntiguo": jug.tipo});
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


  getMigrarPuntuacionesNuevo() async {
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

              "estado_jornada_17": "",
              "estado_jornada_18": "",
           /*   "paisNacimiento" : "${jugador.paisNacimiento}",
              "ccaa" : "${jugador.ccaa}",
              "nacionalidad" : "${jugador.nacionalidad}",*/

            }
        );
      }catch(e){
        print("ERRRRROOOOORR:${jugador.equipo}:${jugador.jugador}");
      }

    }
  }

  String puntuacionEstado(String puntuaciones) {
    if (puntuaciones=="A") return "";
    if (puntuaciones=="T") return "";
    if (puntuaciones=="S") return "";
    if (puntuaciones=="SC") return "SC";
    if (puntuaciones=="SIM") return "";
    if (puntuaciones=="SI") return "";
    if (puntuaciones=="SV") return "";
    if (puntuaciones=="NA") return "";
    if (puntuaciones=="EX") return "";
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