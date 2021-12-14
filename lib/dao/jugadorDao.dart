import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/model/temporada.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/service/LogoService.dart';
import 'package:iadvancedscout/service/db.dart';
import 'package:iadvancedscout/sheets/gsheets.dart';
import 'package:iadvancedscout/sheets/gsheetsSCOUT.dart';
import 'package:iadvancedscout/userScout.dart';
import 'package:iadvancedscout/view/jugadoresList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
final FirebaseFirestore _db = FirebaseFirestore.instance;

class JugadorDao {
  DB con = new DB();
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;
  DatabaseReference _counterRef;
//insertion
  Future<int> saveJugador(Jugador equipo) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("JUGADOR", equipo.toMap());
    return res;
  }

  //deletion
  Future<int> deleteJugador(String equipo) async {
    var dbClient = await con.db;
    int res = await dbClient
        .rawDelete('DELETE FROM JUGADOR WHERE JUGADOR = ?', [equipo]);
    return res;
  }


  Future<List<Jugador>> getAllJugador(String pais, String categoria) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM JUGADOR WHERE PAIS = '$pais' and CATEGORIA='$categoria'");
    List<Jugador> list =
        res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    //print(list[0].equipo);
    //print(list[0].categoria);
    //print(list[0].pais);
    return list;
  }

  getTodosJugadores() async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JUGADOR  ORDER BY JUGADOR.JUGADOR");

    List<Jugador> list =
        res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    return list;
  }

  getTodosEntrenadores() async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM ENTRENADOR  ORDER BY ENTRENADOR.ENTRENADOR");

    List<Entrenador> list =
    res.isNotEmpty ? res.map((c) => Entrenador.fromMap(c)).toList() : [];
    return list;
  }

  getEntrenadoresSolo(Categoria categoria, Equipo equipo) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM ENTRENADOR "
        " where CATEGORIA='${categoria.categoria}' and EQUIPO='${equipo.equipo}' "
        " ORDER BY ENTRENADOR.ENTRENADOR");

    List<Entrenador> list =
    res.isNotEmpty ? res.map((c) => Entrenador.fromMap(c)).toList() : [];
    return list;
  }

  getPuntacionesJornadas() async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM PUNTUACIONES ");
       // " where CATEGORIA='${categoria.categoria}' and EQUIPO='${equipo.equipo}' "
        //" ORDER BY ENTRENADOR.ENTRENADOR");

    List<Player> list =
    res.isNotEmpty ? res.map((c) => Player.fromMapBBDDPuntuaciones(c)).toList() : [];
    return list;
  }

  getTodosJugadoresEquipo(String equipo) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JUGADOR  WHERE EQUIPO='${equipo}' ORDER BY JUGADOR.JUGADOR");

    List<Jugador> list =
    res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    return list;
  }


  getTodosJugadoresCategorias(String categoria) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JUGADOR  WHERE CATEGORIA LIKE  '%${categoria}%' ORDER BY JUGADOR.EQUIPO");

    List<Jugador> list =
    res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    return list;
  }

  getAllJugadores(Equipo  equipo) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JUGADOR WHERE "
        "JUGADOR.PAIS = '${equipo.pais}' and JUGADOR.CATEGORIA='${equipo.categoria}' "
        "and JUGADOR.EQUIPO LIKE '${equipo.equipo}' ORDER BY JUGADOR.JUGADOR");

    List<Jugador> list =
        res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    return list;
  }


  void getJugadorIAScoutFire(Jugador _jugador) async {
    await FirebaseDatabase.instance
        .reference()
        .child("JUGADOR")
        .child(_jugador.id)
        .remove()
        .then((_) {
      //print('Transaction  committed.');
    });
  }

  getJugador(Jugador  jugador) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JUGADOR WHERE "
        "JUGADOR.PAIS = '${jugador.pais}' and JUGADOR.CATEGORIA='${jugador.categoria}' "
        "and JUGADOR.JUGADOR='${jugador.jugador}'"
        "and JUGADOR.EQUIPO ='${jugador.equipo}' ");

    List<Jugador> list =
    res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    return list;
  }

  updateJugador(Jugador jugador) async {
    /*var dbClient = await con.db;
    int res = await dbClient.update(
      "JUGADOR", jugador.toMap(),
      // Ensure that the Dog has a matching id.
      where: "JUGADOR = ? AND CATEGORIA =? AND PAIS=? AND EQUIPO=?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [
        jugador.jugador,
        jugador.categoria,
        jugador.pais,
        jugador.equipo
      ],
    );*/
    updateJugadorIAScout(jugador,true);
    updateJugadorIAScout(jugador,false);
    ProductManager().insert(jugador);
    ProductManagerEXCELSCOUT().insert(jugador);
    // return res;
  }

  updateJugadorIAScout(Jugador _jugador, bool jugadores) async {
    String pathJugadores="jugadores${BBDDService().getUserScout().temporada}/${_jugador.id}";
    String pathTemporadas="temporadas/${BBDDService().getUserScout().temporada}/paises/${_jugador.pais}/"
        "categorias/${_jugador.categoria}/"
        "equipos/${_jugador.equipo}/jugadores/${_jugador.id}";
    String path2=jugadores==true?pathJugadores:pathTemporadas;
    // String path2 ="jugadores/${_jugador.id}";
    // Write a message to the database
    //print(path2);
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(path2);
    print(path2.toString());
   await  dbRef.update({
      "id": _jugador.id,
      "categoria": _jugador.categoria,
      "equipo": _jugador.equipo,

      "imagen": _jugador.imagen,
      "jugador": _jugador.jugador,
     "nivel": _jugador.nivel,
     "nivel2": _jugador.nivel2,
     "nivel3": _jugador.nivel3,
     "nivel4": _jugador.nivel4,
     "tipo": _jugador.tipo,
     "observaciones_1": _jugador.observaciones_1,
      "observaciones_2": _jugador.observaciones_2,
      "observaciones_3": _jugador.observaciones_3,
      "observaciones_4": _jugador.observaciones_4,
      "pais": _jugador.pais,
     "posicion": _jugador.posicion,
     "posicion2": _jugador.posicion2,
     "posicionalternativa": _jugador.posicionalternativa,
     "_dorsal" : _jugador.dorsal,
     "_fechaContrato" : _jugador.fechaContrato,
     "_peso" : _jugador.peso,
     "_altura" : _jugador.altura,
     "_valor" : _jugador.valor,
     "_paisNacimiento" : _jugador.paisNacimiento,
     "_contrato" : _jugador.contrato,
     "fechaNacimiento" : _jugador.fechaNacimiento,
     "_veredicto" : _jugador.veredicto,
     "_prestamo" : _jugador.prestamo,
     "_lateral" : _jugador.lateral,
     "ccaa" : _jugador.ccaa,
     "_ofe_niveltecnico" : _jugador.ofe_niveltecnico,
     "_ofe_profundidad" : _jugador.ofe_profundidad,
     "_ofe_capacidaddegenerarbuenoscentrosalarea" : _jugador.ofe_capacidaddegenerarbuenoscentrosalarea,
     "_ofe_capacidaddeasociacion" : _jugador.ofe_capacidaddeasociacion,
     "_ofe_desborde" : _jugador.ofe_desborde,
     "_ofe_superioridadpordentro" : _jugador.ofe_superioridadpordentro,
     "_ofe_finalizacion" : _jugador.ofe_finalizacion,
     "_ofe_saquedebanda_longitud" : _jugador.ofe_saquedebanda_longitud,
     "_ofe_lanzadordeabps" : _jugador.ofe_lanzadordeabps,
     "_ofe_salidadebalon" : _jugador.ofe_salidadebalon,
     "_ofe_paselargo_medio" : _jugador.ofe_paselargo_medio,
     "_ofe_cambiosdeorientacion" : _jugador.ofe_cambiosdeorientacion,
     "_ofe_batelineasconpaseinterior" : _jugador.ofe_batelineasconpaseinterior,
     "_ofe_conduccionparadividir" : _jugador.ofe_conduccionparadividir,
     "_ofe_primerpasetrasrecuperacion" : _jugador.ofe_primerpasetrasrecuperacion,
     "_ofe_intervieneenabps" : _jugador.ofe_intervieneenabps,
     "_ofe_velocidadeneljuego" : _jugador.ofe_velocidadeneljuego,
     "_ofe_incorporacionazonasderemate" : _jugador.ofe_incorporacionazonasderemate,
     "_ofe_amplitud" : _jugador.ofe_amplitud,
     "_ofe_desmarquesdeapoyo" : _jugador.ofe_desmarquesdeapoyo,
     "_ofe_desmarquesderuptura" : _jugador.ofe_desmarquesderuptura,
     "_ofe_capacidaddegenerarbuenoscentroslateralesalarea" : _jugador.ofe_capacidaddegenerarbuenoscentroslateralesalarea,
     "_ofe_habilidad1vs1" : _jugador.ofe_habilidad1vs1,
     "_ofe_realizaciondelultimopase" : _jugador.ofe_realizaciondelultimopase,
     "_ofe_goleador" : _jugador.ofe_goleador,
     "_ofe_explotaciondeespacios" : _jugador.ofe_explotaciondeespacios,
     "_ofe_duelosaereos" : _jugador.ofe_duelosaereos,
     "_ofe_desbordeporvelocidad" : _jugador.ofe_desbordeporvelocidad,
     "_ofe_dominiode2vs1_pared" : _jugador.ofe_dominiode2vs1_pared,
     "_ofe_ambidextro" : _jugador.ofe_ambidextro,
     "_ofe_juegodecara" : _jugador.ofe_juegodecara,
     "_ofe_protecciondelbalon" : _jugador.ofe_protecciondelbalon,
     "_ofe_caidasabanda" : _jugador.ofe_caidasabanda,
     "_ofe_prolongacionesaereas" : _jugador.ofe_prolongacionesaereas,
     "_ofe_dominiodelarea" : _jugador.ofe_dominiodelarea,
     "_ofe_llegadaaposicionesderemate" : _jugador.ofe_llegadaaposicionesderemate,
     "_ofe_juegoesespacioreducido" : _jugador.ofe_juegoesespacioreducido,
     "_ofe_definidor_anteelportero" : _jugador.ofe_definidor_anteelportero,
     "_ofe_rematador_finalizador" : _jugador.ofe_rematador_finalizador,
     "_ofe_capacidadasociativa_apoyosalalineadefensiva" : _jugador.ofe_capacidadasociativa_apoyosalalineadefensiva,
     "_ofe_desplazamientoenlargo" : _jugador.ofe_desplazamientoenlargo,
     "_fis_velocidaddereaccion" : _jugador.fis_velocidaddereaccion,
     "_fis_velocidaddedesplazamiento" : _jugador.fis_velocidaddedesplazamiento,
     "_fis_agilidad" : _jugador.fis_agilidad,
     "_fis_fuerza_potencia" : _jugador.fis_fuerza_potencia,
     "_fis_cuerpoacuerpo" : _jugador.fis_cuerpoacuerpo,
     "_fis_capacidaddesalto" : _jugador.fis_capacidaddesalto,
     "_fis_explosividad" : _jugador.fis_explosividad,
     "_fis_potenciadesaltolateralyvertical" : _jugador.fis_potenciadesaltolateralyvertical,
     "_fis_resistencia_idayvuelta" : _jugador.fis_resistencia_idayvuelta,
     "_fis_cambioderitmo" : _jugador.fis_cambioderitmo,
     "_fis_envergadura":_jugador.fis_envergadura,
     "_psic_liderazgo" : _jugador.psic_liderazgo,
     "_psic_comunicacion" : _jugador.psic_comunicacion,
     "_psic_seguridad" : _jugador.psic_seguridad,
     "_psic_tomadedecisiones" : _jugador.psic_tomadedecisiones,
     "_psic_agresividad" : _jugador.psic_agresividad,
     "_psic_polivalencia" : _jugador.psic_polivalencia,
     "_psic_competitividad" : _jugador.psic_competitividad,
     "_psic_agresividad_contundencia" : _jugador.psic_agresividad_contundencia,
     "_psic_noasumeriesgosextremos" : _jugador.psic_noasumeriesgosextremos,
     "_psic_entendimientodeljuego_inteligencia" : _jugador.psic_entendimientodeljuego_inteligencia,
     "_psic_creatividad" : _jugador.psic_creatividad,
     "_psic_confianza" : _jugador.psic_confianza,
     "_psic_compromiso" : _jugador.psic_compromiso,
     "_psic_valentia" : _jugador.psic_valentia,
     "_psic_oportunismo" : _jugador.psic_oportunismo,
     "_def_acoso_presionsobreeloponente" : _jugador.def_acoso_presionsobreeloponente,
     "_def_actituddefensiva" : _jugador.def_actituddefensiva,
     "_def_activaciondelosmecanismosdepresion" : _jugador.def_activaciondelosmecanismosdepresion,
     "_def_anticipacion" : _jugador.def_anticipacion,
     "_def_ayudaspermanentesallateral" : _jugador.def_ayudaspermanentesallateral,
     "_def_capacidaddemarcaje" : _jugador.def_capacidaddemarcaje,
     "_def_capacidadparataparcentros" : _jugador.def_capacidadparataparcentros,
     "_def_cerrarelladodebil_basculaciones" : _jugador.def_cerrarelladodebil_basculaciones,
     "_def_cierralineasdepase" : _jugador.def_cierralineasdepase,
     "_def_coberturadecentrales" : _jugador.def_coberturadecentrales,
     "_def_coberturas" : _jugador.def_coberturas,
     "_def_colocacion" : _jugador.def_colocacion,
     "_def_comportamientofueradezona" : _jugador.def_comportamientofueradezona,
     "_def_correctabasculacion" : _jugador.def_correctabasculacion,
     "_def_correctabasculacion_distanciadeintervalos" : _jugador.def_correctabasculacion_distanciadeintervalos,
     "_def_correctoperfilamiento" : _jugador.def_correctoperfilamiento,
     "_def_cruces" : _jugador.def_cruces,
     "_def_destrezaantecentroslaterales" : _jugador.def_destrezaantecentroslaterales,
     "_def_dificildesuperarenel1vs1" : _jugador.def_dificildesuperarenel1vs1,
     "_def_dominiodelaszonasderechace" : _jugador.def_dominiodelaszonasderechace,
     "_def_duelosaereos" : _jugador.def_duelosaereos,
     "_def_duelosdefensivos" : _jugador.def_duelosdefensivos,
     "_def_evitarecepcionesentrelineas" : _jugador.def_evitarecepcionesentrelineas,
     "_def_evitaserdesbordado" : _jugador.def_evitaserdesbordado,
     "_def_interceptaciondetiro" : _jugador.def_interceptaciondetiro,
     "_def_mantenerlalineadefensiva" : _jugador.def_mantenerlalineadefensiva,
     "_def_marcajeproximoaoponentedirecto" : _jugador.def_marcajeproximoaoponentedirecto,
     "_def_ocupaespaciosdecompanerossuperados" : _jugador.def_ocupaespaciosdecompanerossuperados,
     "_def_perfilamientos" : _jugador.def_perfilamientos,
     "_def_permiteelgiro" : _jugador.def_permiteelgiro,
     "_def_presiontrasperdida" : _jugador.def_presiontrasperdida,
     "_def_resolucionanteparedesrivales" : _jugador.def_resolucionanteparedesrivales,
     "_def_sabecuidarsuespalda" : _jugador.def_sabecuidarsuespalda,
     "_def_vigilayreferenciaalrival_enfaseofensiva" : _jugador.def_vigilayreferenciaalrival_enfaseofensiva,
     "_def_vigilanciassobrelateralrival" : _jugador.def_vigilanciassobrelateralrival,
     "_def_blocaje" : _jugador.def_blocaje,
     "_def_juegoaereolateral" : _jugador.def_juegoaereolateral,
     "_def_juegoaereofrontal" : _jugador.def_juegoaereofrontal,
     "_def_habilidadenel1vs1" : _jugador.def_habilidadenel1vs1,
     "_def_despeje" : _jugador.def_despeje,
     "_def_anticipacion_intuicion" : _jugador.def_anticipacion_intuicion,
     "_def_coberturadelineadefensiva" : _jugador.def_coberturadelineadefensiva,
     "_def_abps" : _jugador.def_abps,
     "_def_penaltis" : _jugador.def_penaltis,

     "nombre" : BBDDService().getUserScout().name,
     "email" : BBDDService().getUserScout().email,
     "fecha" : DateTime.now().toString(),

   }).then((res) {
      print('Transaction  committed.${_jugador.jugador}');

    }).catchError((err) {
      print(err);
    });
  }

  addEntrenadorIAScout(Jugador _jugador, bool jugadores, int i) async {
    String pathJugadores="jugadores${BBDDService().getUserScout().temporada}/${_jugador.id}";
    String pathTemporadas="temporadas/${BBDDService().getUserScout().temporada}/paises/${_jugador.pais}/"
        "categorias/${_jugador.categoria}/"
        "equipos/${_jugador.equipo}/entrenadores/${_jugador.id}";
    String path2=jugadores==true?pathJugadores:pathTemporadas;
    // String path2 ="jugadores/${_jugador.id}";
    // Write a message to the database
    //print(path2);



    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path2);
    await  dbRef.set({
      "id": i,
      "idKey": _jugador.id,
      "categoria": _jugador.categoria,
      "equipo": _jugador.equipo,
      "imagen": _jugador.imagen,
      "jugador": _jugador.jugador,
      "nivel": _jugador.nivel,
      "nivel2": _jugador.nivel2,
      "nivel3": _jugador.nivel3,
      "nivel4": _jugador.nivel4,
      "tipo": _jugador.tipo,
      "_dorsal" : _jugador.dorsal,
      "_fechaContrato" : _jugador.fechaContrato,
      "_peso" : _jugador.peso,
      "_altura" : _jugador.altura,
      "_valor" : _jugador.valor,
      "_paisNacimiento" : _jugador.paisNacimiento,
      "_contrato" : _jugador.contrato,
      "_veredicto" : _jugador.veredicto,
      "_prestamo" : _jugador.prestamo,
      "_lateral" : _jugador.lateral,
      "observaciones_1": _jugador.observaciones_1,
      "pais": _jugador.pais,
      "posicion": _jugador.posicion,
      "ccaa" : _jugador.ccaa,
      "nacionalidad" :_jugador.nacionalidad,
      "posicionalternativa": _jugador.posicionalternativa,
      "fechaNacimiento": _jugador.fechaNacimiento,
      "_ofe_niveltecnico": _jugador.ofe_niveltecnico,
      "_ofe_profundidad": _jugador.ofe_profundidad,
      "_ofe_capacidaddegenerarbuenoscentrosalarea": _jugador.ofe_capacidaddegenerarbuenoscentrosalarea,
      "_ofe_capacidaddeasociacion": _jugador.ofe_capacidaddeasociacion,
      "_ofe_desborde": _jugador.ofe_desborde,
      "_ofe_superioridadpordentro" :_jugador.ofe_superioridadpordentro,
      "_ofe_finalizacion": _jugador.ofe_finalizacion,
      "_ofe_saquedebanda_longitud": _jugador.ofe_saquedebanda_longitud,
      "_ofe_lanzadordeabps": _jugador.ofe_lanzadordeabps,
      "_ofe_salidadebalon": _jugador.ofe_salidadebalon,
      "_ofe_paselargo_medio": _jugador.ofe_paselargo_medio,
      "_ofe_cambiosdeorientacion": _jugador.ofe_cambiosdeorientacion,
      "_ofe_batelineasconpaseinterior": _jugador.ofe_batelineasconpaseinterior,
      "_ofe_conduccionparadividir": _jugador.ofe_conduccionparadividir,
      "_ofe_primerpasetrasrecuperacion": _jugador.ofe_primerpasetrasrecuperacion,
      "_ofe_intervieneenabps": _jugador.ofe_intervieneenabps,
      "_ofe_velocidadeneljuego": _jugador.ofe_velocidadeneljuego,
      "_ofe_incorporacionazonasderemate": _jugador.ofe_incorporacionazonasderemate,
      "_ofe_amplitud": _jugador.ofe_amplitud,
      "_ofe_desmarquesdeapoyo": _jugador.ofe_desmarquesdeapoyo,
      "_ofe_desmarquesderuptura": _jugador.ofe_desmarquesderuptura,
      "_ofe_capacidaddegenerarbuenoscentroslateralesalarea": _jugador.ofe_capacidaddegenerarbuenoscentroslateralesalarea,
      "_ofe_habilidad1vs1": _jugador.ofe_habilidad1vs1,
      "_ofe_realizaciondelultimopase": _jugador.ofe_realizaciondelultimopase,
      "_ofe_goleador": _jugador.ofe_goleador,
      "_ofe_explotaciondeespacios": _jugador.ofe_explotaciondeespacios,
      "_ofe_duelosaereos": _jugador.ofe_duelosaereos,
      "_ofe_desbordeporvelocidad": _jugador.ofe_desbordeporvelocidad,
      "_ofe_dominiode2vs1_pared": _jugador.ofe_dominiode2vs1_pared,
      "_ofe_ambidextro": _jugador.ofe_ambidextro,
      "_ofe_juegodecara": _jugador.ofe_juegodecara,
      "_ofe_protecciondelbalon": _jugador.ofe_protecciondelbalon,
      "_ofe_caidasabanda": _jugador.ofe_caidasabanda,
      "_ofe_prolongacionesaereas": _jugador.ofe_prolongacionesaereas,
      "_ofe_dominiodelarea": _jugador.ofe_dominiodelarea,
      "_ofe_llegadaaposicionesderemate": _jugador.ofe_llegadaaposicionesderemate,
      "_ofe_juegoesespacioreducido": _jugador.ofe_juegoesespacioreducido,
      "_ofe_definidor_anteelportero": _jugador.ofe_definidor_anteelportero,
      "_ofe_rematador_finalizador": _jugador.ofe_rematador_finalizador,
      "_ofe_capacidadasociativa_apoyosalalineadefensiva": _jugador.ofe_capacidadasociativa_apoyosalalineadefensiva,
      "_ofe_desplazamientoenlargo": _jugador.ofe_desplazamientoenlargo,
      "_fis_velocidaddereaccion": _jugador.fis_velocidaddereaccion,
      "_fis_velocidaddedesplazamiento": _jugador.fis_velocidaddedesplazamiento,
      "_fis_agilidad": _jugador.fis_agilidad,
      "_fis_fuerza_potencia": _jugador.fis_fuerza_potencia,
      "_fis_cuerpoacuerpo": _jugador.fis_cuerpoacuerpo,
      "_fis_capacidaddesalto": _jugador.fis_capacidaddesalto,
      "_fis_explosividad": _jugador.fis_explosividad,
      "_fis_potenciadesaltolateralyvertical": _jugador.fis_potenciadesaltolateralyvertical,
      "_fis_resistencia_idayvuelta": _jugador.fis_resistencia_idayvuelta,
      "_fis_cambioderitmo": _jugador.fis_cambioderitmo,
      "_psic_liderazgo": _jugador.psic_liderazgo,
      "_psic_comunicacion": _jugador.psic_comunicacion,
      "_psic_seguridad": _jugador.psic_seguridad,
      "_psic_tomadedecisiones": _jugador.psic_tomadedecisiones,
      "_psic_agresividad": _jugador.psic_agresividad,
      "_psic_polivalencia": _jugador.psic_polivalencia,
      "_psic_competitividad": _jugador.psic_competitividad,
      "_psic_agresividad_contundencia": _jugador.psic_agresividad_contundencia,
      "_psic_noasumeriesgosextremos": _jugador.psic_noasumeriesgosextremos,
      "_psic_entendimientodeljuego_inteligencia": _jugador.psic_entendimientodeljuego_inteligencia,
      "_psic_creatividad": _jugador.psic_creatividad,
      "_psic_confianza": _jugador.psic_confianza,
      "_psic_compromiso": _jugador.psic_compromiso,
      "_psic_valentia": _jugador.psic_valentia,
      "_psic_oportunismo": _jugador.psic_oportunismo,
      "_def_acoso_presionsobreeloponente": _jugador.def_acoso_presionsobreeloponente,
      "_def_actituddefensiva": _jugador.def_actituddefensiva,
      "_def_activaciondelosmecanismosdepresion": _jugador.def_activaciondelosmecanismosdepresion,
      "_def_anticipacion": _jugador.def_anticipacion,
      "_def_ayudaspermanentesallateral": _jugador.def_ayudaspermanentesallateral,
      "_def_capacidaddemarcaje": _jugador.def_capacidaddemarcaje,
      "_def_capacidadparataparcentros": _jugador.def_capacidadparataparcentros,
      "_def_cerrarelladodebil_basculaciones": _jugador.def_cerrarelladodebil_basculaciones,
      "_def_cierralineasdepase": _jugador.def_cierralineasdepase,
      "_def_coberturadecentrales": _jugador.def_coberturadecentrales,
      "_def_coberturas": _jugador.def_coberturas,
      "_def_colocacion": _jugador.def_colocacion,
      "_def_comportamientofueradezona": _jugador.def_comportamientofueradezona,
      "_def_correctabasculacion": _jugador.def_correctabasculacion,
      "_def_correctabasculacion_distanciadeintervalos": _jugador.def_correctabasculacion_distanciadeintervalos,
      "_def_correctoperfilamiento": _jugador.def_correctoperfilamiento,
      "_def_cruces": _jugador.def_cruces,
      "_def_destrezaantecentroslaterales": _jugador.def_destrezaantecentroslaterales,
      "_def_dificildesuperarenel1vs1": _jugador.def_dificildesuperarenel1vs1,
      "_def_dominiodelaszonasderechace": _jugador.def_dominiodelaszonasderechace,
      "_def_duelosaereos": _jugador.def_duelosaereos,
      "_def_duelosdefensivos": _jugador.def_duelosdefensivos,
      "_def_evitarecepcionesentrelineas": _jugador.def_evitarecepcionesentrelineas,
      "_def_evitaserdesbordado": _jugador.def_evitaserdesbordado,
      "_def_interceptaciondetiro": _jugador.def_interceptaciondetiro,
      "_def_mantenerlalineadefensiva": _jugador.def_mantenerlalineadefensiva,
      "_def_marcajeproximoaoponentedirecto": _jugador.def_marcajeproximoaoponentedirecto,
      "_def_ocupaespaciosdecompanerossuperados": _jugador.def_ocupaespaciosdecompanerossuperados,
      "_def_perfilamientos": _jugador.def_perfilamientos,
      "_def_permiteelgiro": _jugador.def_permiteelgiro,
      "_def_presiontrasperdida": _jugador.def_presiontrasperdida,
      "_def_resolucionanteparedesrivales": _jugador.def_resolucionanteparedesrivales,
      "_def_sabecuidarsuespalda": _jugador.def_sabecuidarsuespalda,
      "_def_vigilayreferenciaalrival_enfaseofensiva": _jugador.def_vigilayreferenciaalrival_enfaseofensiva,
      "_def_vigilanciassobrelateralrival": _jugador.def_vigilanciassobrelateralrival,
      "_def_blocaje": _jugador.def_blocaje,
      "_def_juegoaereolateral": _jugador.def_juegoaereolateral,
      "_def_juegoaereofrontal": _jugador.def_juegoaereofrontal,
      "_def_habilidadenel1vs1": _jugador.def_habilidadenel1vs1,
      "_def_despeje": _jugador.def_despeje,
      "_def_anticipacion_intuicion": _jugador.def_anticipacion_intuicion,
      "_def_coberturadelineadefensiva": _jugador.def_coberturadelineadefensiva,
      "_def_abps": _jugador.def_abps,
      "_def_penaltis": _jugador.def_penaltis,
    }).then((res) {
      print('Transaction  committed.${_jugador.jugador} ${_jugador.equipo}');

    }).catchError((err) {
      print(err);
    });
  }



  addJugadorIAScout(Jugador _jugador, bool jugadores, int i) async {
    String pathJugadores="jugadores${BBDDService().getUserScout().temporada}/${_jugador.id}";
    String pathTemporadas="temporadas/${BBDDService().getUserScout().temporada}/paises/${_jugador.pais}/"
        "categorias/${_jugador.categoria}/"
        "equipos/${_jugador.equipo}/jugadores/${_jugador.id}";
    String path2=jugadores==true?pathJugadores:pathTemporadas;
     // String path2 ="jugadores/${_jugador.id}";
    // Write a message to the database
    //print(path2);



    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path2);
    await  dbRef.set({
      "id": i,
      "idKey": _jugador.id,
      "categoria": _jugador.categoria,
      "equipo": _jugador.equipo,
      "imagen": _jugador.imagen,
      "jugador": _jugador.jugador,
      "nivel": _jugador.nivel,
      "nivel2": _jugador.nivel2,
      "nivel3": _jugador.nivel3,
      "nivel4": _jugador.nivel4,
      "tipo": _jugador.tipo,
      "_dorsal" : _jugador.dorsal,
      "_fechaContrato" : _jugador.fechaContrato,
      "_peso" : _jugador.peso,
      "_altura" : _jugador.altura,
      "_valor" : _jugador.valor,
      "_paisNacimiento" : _jugador.paisNacimiento,
      "_contrato" : _jugador.contrato,
      "_veredicto" : _jugador.veredicto,
      "_prestamo" : _jugador.prestamo,
      "_lateral" : _jugador.lateral,
      "observaciones_1": _jugador.observaciones_1,
      "pais": _jugador.pais,
      "posicion": _jugador.posicion,
      "ccaa" : _jugador.ccaa,
      "nacionalidad" :_jugador.nacionalidad,
      "posicionalternativa": _jugador.posicionalternativa,
      "fechaNacimiento": _jugador.fechaNacimiento,
      "_ofe_niveltecnico": _jugador.ofe_niveltecnico,
      "_ofe_profundidad": _jugador.ofe_profundidad,
      "_ofe_capacidaddegenerarbuenoscentrosalarea": _jugador.ofe_capacidaddegenerarbuenoscentrosalarea,
      "_ofe_capacidaddeasociacion": _jugador.ofe_capacidaddeasociacion,
      "_ofe_desborde": _jugador.ofe_desborde,
      "_ofe_superioridadpordentro" :_jugador.ofe_superioridadpordentro,
      "_ofe_finalizacion": _jugador.ofe_finalizacion,
      "_ofe_saquedebanda_longitud": _jugador.ofe_saquedebanda_longitud,
      "_ofe_lanzadordeabps": _jugador.ofe_lanzadordeabps,
      "_ofe_salidadebalon": _jugador.ofe_salidadebalon,
      "_ofe_paselargo_medio": _jugador.ofe_paselargo_medio,
      "_ofe_cambiosdeorientacion": _jugador.ofe_cambiosdeorientacion,
      "_ofe_batelineasconpaseinterior": _jugador.ofe_batelineasconpaseinterior,
      "_ofe_conduccionparadividir": _jugador.ofe_conduccionparadividir,
      "_ofe_primerpasetrasrecuperacion": _jugador.ofe_primerpasetrasrecuperacion,
      "_ofe_intervieneenabps": _jugador.ofe_intervieneenabps,
      "_ofe_velocidadeneljuego": _jugador.ofe_velocidadeneljuego,
      "_ofe_incorporacionazonasderemate": _jugador.ofe_incorporacionazonasderemate,
      "_ofe_amplitud": _jugador.ofe_amplitud,
      "_ofe_desmarquesdeapoyo": _jugador.ofe_desmarquesdeapoyo,
      "_ofe_desmarquesderuptura": _jugador.ofe_desmarquesderuptura,
      "_ofe_capacidaddegenerarbuenoscentroslateralesalarea": _jugador.ofe_capacidaddegenerarbuenoscentroslateralesalarea,
      "_ofe_habilidad1vs1": _jugador.ofe_habilidad1vs1,
      "_ofe_realizaciondelultimopase": _jugador.ofe_realizaciondelultimopase,
      "_ofe_goleador": _jugador.ofe_goleador,
      "_ofe_explotaciondeespacios": _jugador.ofe_explotaciondeespacios,
      "_ofe_duelosaereos": _jugador.ofe_duelosaereos,
      "_ofe_desbordeporvelocidad": _jugador.ofe_desbordeporvelocidad,
      "_ofe_dominiode2vs1_pared": _jugador.ofe_dominiode2vs1_pared,
      "_ofe_ambidextro": _jugador.ofe_ambidextro,
      "_ofe_juegodecara": _jugador.ofe_juegodecara,
      "_ofe_protecciondelbalon": _jugador.ofe_protecciondelbalon,
      "_ofe_caidasabanda": _jugador.ofe_caidasabanda,
      "_ofe_prolongacionesaereas": _jugador.ofe_prolongacionesaereas,
      "_ofe_dominiodelarea": _jugador.ofe_dominiodelarea,
      "_ofe_llegadaaposicionesderemate": _jugador.ofe_llegadaaposicionesderemate,
      "_ofe_juegoesespacioreducido": _jugador.ofe_juegoesespacioreducido,
      "_ofe_definidor_anteelportero": _jugador.ofe_definidor_anteelportero,
      "_ofe_rematador_finalizador": _jugador.ofe_rematador_finalizador,
      "_ofe_capacidadasociativa_apoyosalalineadefensiva": _jugador.ofe_capacidadasociativa_apoyosalalineadefensiva,
      "_ofe_desplazamientoenlargo": _jugador.ofe_desplazamientoenlargo,
      "_fis_velocidaddereaccion": _jugador.fis_velocidaddereaccion,
      "_fis_velocidaddedesplazamiento": _jugador.fis_velocidaddedesplazamiento,
      "_fis_agilidad": _jugador.fis_agilidad,
      "_fis_fuerza_potencia": _jugador.fis_fuerza_potencia,
      "_fis_cuerpoacuerpo": _jugador.fis_cuerpoacuerpo,
      "_fis_capacidaddesalto": _jugador.fis_capacidaddesalto,
      "_fis_explosividad": _jugador.fis_explosividad,
      "_fis_potenciadesaltolateralyvertical": _jugador.fis_potenciadesaltolateralyvertical,
      "_fis_resistencia_idayvuelta": _jugador.fis_resistencia_idayvuelta,
      "_fis_cambioderitmo": _jugador.fis_cambioderitmo,
      "_psic_liderazgo": _jugador.psic_liderazgo,
      "_psic_comunicacion": _jugador.psic_comunicacion,
      "_psic_seguridad": _jugador.psic_seguridad,
      "_psic_tomadedecisiones": _jugador.psic_tomadedecisiones,
      "_psic_agresividad": _jugador.psic_agresividad,
      "_psic_polivalencia": _jugador.psic_polivalencia,
      "_psic_competitividad": _jugador.psic_competitividad,
      "_psic_agresividad_contundencia": _jugador.psic_agresividad_contundencia,
      "_psic_noasumeriesgosextremos": _jugador.psic_noasumeriesgosextremos,
      "_psic_entendimientodeljuego_inteligencia": _jugador.psic_entendimientodeljuego_inteligencia,
      "_psic_creatividad": _jugador.psic_creatividad,
      "_psic_confianza": _jugador.psic_confianza,
      "_psic_compromiso": _jugador.psic_compromiso,
      "_psic_valentia": _jugador.psic_valentia,
      "_psic_oportunismo": _jugador.psic_oportunismo,
      "_def_acoso_presionsobreeloponente": _jugador.def_acoso_presionsobreeloponente,
      "_def_actituddefensiva": _jugador.def_actituddefensiva,
      "_def_activaciondelosmecanismosdepresion": _jugador.def_activaciondelosmecanismosdepresion,
      "_def_anticipacion": _jugador.def_anticipacion,
      "_def_ayudaspermanentesallateral": _jugador.def_ayudaspermanentesallateral,
      "_def_capacidaddemarcaje": _jugador.def_capacidaddemarcaje,
      "_def_capacidadparataparcentros": _jugador.def_capacidadparataparcentros,
      "_def_cerrarelladodebil_basculaciones": _jugador.def_cerrarelladodebil_basculaciones,
      "_def_cierralineasdepase": _jugador.def_cierralineasdepase,
      "_def_coberturadecentrales": _jugador.def_coberturadecentrales,
      "_def_coberturas": _jugador.def_coberturas,
      "_def_colocacion": _jugador.def_colocacion,
      "_def_comportamientofueradezona": _jugador.def_comportamientofueradezona,
      "_def_correctabasculacion": _jugador.def_correctabasculacion,
      "_def_correctabasculacion_distanciadeintervalos": _jugador.def_correctabasculacion_distanciadeintervalos,
      "_def_correctoperfilamiento": _jugador.def_correctoperfilamiento,
      "_def_cruces": _jugador.def_cruces,
      "_def_destrezaantecentroslaterales": _jugador.def_destrezaantecentroslaterales,
      "_def_dificildesuperarenel1vs1": _jugador.def_dificildesuperarenel1vs1,
      "_def_dominiodelaszonasderechace": _jugador.def_dominiodelaszonasderechace,
      "_def_duelosaereos": _jugador.def_duelosaereos,
      "_def_duelosdefensivos": _jugador.def_duelosdefensivos,
      "_def_evitarecepcionesentrelineas": _jugador.def_evitarecepcionesentrelineas,
      "_def_evitaserdesbordado": _jugador.def_evitaserdesbordado,
      "_def_interceptaciondetiro": _jugador.def_interceptaciondetiro,
      "_def_mantenerlalineadefensiva": _jugador.def_mantenerlalineadefensiva,
      "_def_marcajeproximoaoponentedirecto": _jugador.def_marcajeproximoaoponentedirecto,
      "_def_ocupaespaciosdecompanerossuperados": _jugador.def_ocupaespaciosdecompanerossuperados,
      "_def_perfilamientos": _jugador.def_perfilamientos,
      "_def_permiteelgiro": _jugador.def_permiteelgiro,
      "_def_presiontrasperdida": _jugador.def_presiontrasperdida,
      "_def_resolucionanteparedesrivales": _jugador.def_resolucionanteparedesrivales,
      "_def_sabecuidarsuespalda": _jugador.def_sabecuidarsuespalda,
      "_def_vigilayreferenciaalrival_enfaseofensiva": _jugador.def_vigilayreferenciaalrival_enfaseofensiva,
      "_def_vigilanciassobrelateralrival": _jugador.def_vigilanciassobrelateralrival,
      "_def_blocaje": _jugador.def_blocaje,
      "_def_juegoaereolateral": _jugador.def_juegoaereolateral,
      "_def_juegoaereofrontal": _jugador.def_juegoaereofrontal,
      "_def_habilidadenel1vs1": _jugador.def_habilidadenel1vs1,
      "_def_despeje": _jugador.def_despeje,
      "_def_anticipacion_intuicion": _jugador.def_anticipacion_intuicion,
      "_def_coberturadelineadefensiva": _jugador.def_coberturadelineadefensiva,
      "_def_abps": _jugador.def_abps,
      "_def_penaltis": _jugador.def_penaltis,
    }).then((res) {
      print('Transaction  committed.${_jugador.jugador} ${_jugador.equipo}');

    }).catchError((err) {
      print(err);
    });
  }



  updateJugadorIAScoutDorsal(Jugador _jugador, bool jugadores) async {
    String pathJugadores="jugadores/${_jugador.id}";
    String pathTemporadas="temporadas/${BBDDService().getUserScout().temporada}/paises/${_jugador.pais}/"
        "categorias/${_jugador.categoria}/"
        "equipos/${_jugador.equipo}/jugadores/${_jugador.id}";
    String path2=jugadores==true?pathJugadores:pathTemporadas;
    // String path2 ="jugadores/${_jugador.id}";
    // Write a message to the database
    //print(path2);
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path2);
    print(path2.toString());
    await  dbRef.update({
      "_dorsal" : _jugador.dorsal,
    }).then((res) {
      print('Transaction  committed.${_jugador.jugador} ${_jugador.equipo}');

    }).catchError((err) {
      print(err);
    });
  }

  deleteJugadorIAScout(Jugador _jugador){
    String nodeName =
        "temporadas/${BBDDService().getUserScout().temporada}/paises/${_jugador.pais}/categorias/${_jugador.categoria}/equipos/${_jugador.equipo}/jugadores";

    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(nodeName);
    print("DELETE:$nodeName/${_jugador.id}");
    dbRef.child("${_jugador.id}").remove();
  }

  getAllJugadoresFire(String pais, String categoria, String equipo) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM JUGADOR WHERE "
        "JUGADOR.PAIS = '$pais' and JUGADOR.CATEGORIA='$categoria' "
        "and JUGADOR.EQUIPO LIKE '$equipo%' ORDER BY JUGADOR.JUGADOR");

    List<Jugador> list =
    res.isNotEmpty ? res.map((c) => Jugador.fromMap(c)).toList() : [];
    return list;
  }

  getJugadoresPutuacionesEquipo(String categoria, String equipo) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(""
        "SELECT * FROM PUNTUACIONES WHERE "
        "CATEGORIA='$categoria' and EQUIPO='$equipo'");

    List<Player> list =
    res.isNotEmpty ? res.map((c) => Player.fromMapBBDDPuntuaciones(c)).toList() : [];
    return list;
  }

  getJugadores(Equipo _equipo)  async {
    List<EquipoCloud> equipos= await getDataCollectionEquipos("rAeKFLQSry7l1x0WVW01");
    List<Jugador> lista = new List();
    print("getJugadores");

    for(var d in equipos) {
      String path2 =
          "temporadas/2021-2022/paises/${_equipo.pais}/categorias/${_equipo
          .categoria}/equipos/${d.nombre}/jugadores";
      print(path2);
      FirebaseDatabase.instance.reference().child(
          path2).once().then((snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        //print(values.toString());
        values.forEach((k, v) {
          Jugador jugador = Jugador.fromJson(k, v);
          //print(jugador.jugador);
          //print(jugador.equipo);
          print("${v["jugador"]}:${v["equipo"]}");
          lista.add(jugador);
        });
      });
    }
    return lista;
  }





  Future <List<EquipoCloud>> getDataCollectionEquipos(String categoria) async{
    List<EquipoCloud> equipos=List();

    Stream<QuerySnapshot> q= _db.
    collection("temporadas").doc("BuJNv17ghCPGnq37P2ev").
    collection("paises").doc("FmUmyJV68ACrLHozX3oa").
    collection("categorias").doc(categoria).
    collection("equipos").
    orderBy("equipo", descending: false).snapshots();


    q.forEach((element) {
      element.docs.forEach((element) {
        EquipoCloud eq=new EquipoCloud();
          eq.nombre=element.data()["equipo"];
          eq.key=element.id;
          equipos.add(eq);
      });

    });
    return equipos;

  }

 /* Future<String> getImagen(String id, String imagen) async {
    final ref = FirebaseStorage.instance.ref().child('jugadores/${id}');
    // no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    //print(url);
    imagen=url;
    return url;
  }*/

  eliminarTodoTemporadas() async {
    String path2 = "temporadas/2021-2022";
    // Write a message to the database
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(path2);
    dbRef.remove().then((res) {
      //print('Transaction  committed.');
    }).catchError((err) {
      //print(err);
    });
  }

  eliminarTodoJugadores() async {
    String path2 = "jugadores${BBDDService().getUserScout().temporada}";
    // Write a message to the database
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path2);
    dbRef.remove().then((res) {
      //print('Transaction  committed.');
    }).catchError((err) {
      //print(err);
    });
  }

}



