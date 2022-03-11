import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/service/BBDDService.dart';

class Jugador {

  String _email;
  String _fecha;
  String _nombre;
  Color colorNivel;
  String key;
  String _id;
  String _jugador;
  String _equipo;
  String _categoria;
  String _pais;
  String _posicion;
  String _posicion2;
  String _imagen;
  String _nivel;
  String _nivel2;
  String _nivel3;
  String _nivel4;
  String _tipo;
  int _dorsal;
  String _fechaContrato="";
  String _peso;
  String _altura;
  String _valor;
  String _paisNacimiento="";
  String _contrato;
  String _ccaa="";
  String _nacionalidad="";
  String _posicionalternativa="";
  String _temporada;

  String _veredicto;
  String _prestamo="";
  String _lateral;

  String _foto;

  String _observaciones_1 = "";
  String _observaciones_2 = "";
  String _observaciones_3 = "";
  String _observaciones_4 = "";
  String _fechaNacimiento;
  bool _ofe_niveltecnico=false;
  bool _ofe_profundidad=false;
  bool _ofe_capacidaddegenerarbuenoscentrosalarea=false;
  bool _ofe_capacidaddeasociacion=false;
  bool _ofe_desborde=false;
  bool _ofe_superioridadpordentro=false;
  bool _ofe_finalizacion=false;
  bool _ofe_saquedebanda_longitud=false;
  bool _ofe_lanzadordeabps=false;
  bool _ofe_salidadebalon=false;
  bool _ofe_paselargo_medio=false;
  bool _ofe_cambiosdeorientacion=false;
  bool _ofe_batelineasconpaseinterior=false;
  bool _ofe_conduccionparadividir=false;
  bool _ofe_primerpasetrasrecuperacion=false;
  bool _ofe_intervieneenabps=false;
  bool _ofe_velocidadeneljuego=false;
  bool _ofe_incorporacionazonasderemate=false;
  bool _ofe_amplitud=false;
  bool _ofe_desmarquesdeapoyo=false;
  bool _ofe_desmarquesderuptura=false;
  bool _ofe_capacidaddegenerarbuenoscentroslateralesalarea=false;
  bool _ofe_habilidad1vs1=false;
  bool _ofe_realizaciondelultimopase=false;
  bool _ofe_goleador=false;
  bool _ofe_explotaciondeespacios=false;
  bool _ofe_duelosaereos=false;
  bool _ofe_desbordeporvelocidad=false;
  bool _ofe_dominiode2vs1_pared=false;
  bool _ofe_ambidextro=false;
  bool _ofe_juegodecara=false;
  bool _ofe_protecciondelbalon=false;
  bool _ofe_caidasabanda=false;
  bool _ofe_prolongacionesaereas=false;
  bool _ofe_dominiodelarea=false;
  bool _ofe_llegadaaposicionesderemate=false;
  bool _ofe_juegoesespacioreducido=false;
  bool _ofe_definidor_anteelportero=false;
  bool _ofe_rematador_finalizador=false;
  bool _ofe_capacidadasociativa_apoyosalalineadefensiva=false;
  bool _ofe_desplazamientoenlargo=false;
  bool _fis_velocidaddereaccion=false;
  bool _fis_velocidaddedesplazamiento=false;
  bool _fis_agilidad=false;
  bool _fis_fuerza_potencia=false;
  bool _fis_cuerpoacuerpo=false;
  bool _fis_capacidaddesalto=false;
  bool _fis_explosividad=false;
  bool _fis_potenciadesaltolateralyvertical=false;
  bool _fis_resistencia_idayvuelta=false;
  bool _fis_cambioderitmo=false;
  String _fis_envergadura="";
  bool _psic_liderazgo=false;
  bool _psic_comunicacion=false;
  bool _psic_seguridad=false;
  bool _psic_tomadedecisiones=false;
  bool _psic_agresividad=false;
  bool _psic_polivalencia=false;
  bool _psic_competitividad=false;
  bool _psic_agresividad_contundencia=false;
  bool _psic_noasumeriesgosextremos=false;
  bool _psic_entendimientodeljuego_inteligencia=false;
  bool _psic_creatividad=false;
  bool _psic_confianza=false;
  bool _psic_compromiso=false;
  bool _psic_valentia=false;
  bool _psic_oportunismo=false;
  bool _def_acoso_presionsobreeloponente=false;
  bool _def_actituddefensiva=false;
  bool _def_activaciondelosmecanismosdepresion=false;
  bool _def_anticipacion=false;
  bool _def_ayudaspermanentesallateral=false;
  bool _def_capacidaddemarcaje=false;
  bool _def_capacidadparataparcentros=false;
  bool _def_cerrarelladodebil_basculaciones=false;
  bool _def_cierralineasdepase=false;
  bool _def_coberturadecentrales=false;
  bool _def_coberturas=false;
  bool _def_colocacion=false;
  bool _def_comportamientofueradezona=false;
  bool _def_correctabasculacion=false;
  bool _def_correctabasculacion_distanciadeintervalos=false;
  bool _def_correctoperfilamiento=false;
  bool _def_cruces=false;
  bool _def_destrezaantecentroslaterales=false;
  bool _def_dificildesuperarenel1vs1=false;
  bool _def_dominiodelaszonasderechace=false;
  bool _def_duelosaereos=false;
  bool _def_duelosdefensivos=false;
  bool _def_evitarecepcionesentrelineas=false;
  bool _def_evitaserdesbordado=false;
  bool _def_interceptaciondetiro=false;
  bool _def_mantenerlalineadefensiva=false;
  bool _def_marcajeproximoaoponentedirecto=false;
  bool _def_ocupaespaciosdecompanerossuperados=false;
  bool _def_perfilamientos=false;
  bool _def_permiteelgiro=false;
  bool _def_presiontrasperdida=false;
  bool _def_resolucionanteparedesrivales=false;
  bool _def_sabecuidarsuespalda=false;
  bool _def_vigilayreferenciaalrival_enfaseofensiva=false;
  bool _def_vigilanciassobrelateralrival=false;
  bool _def_blocaje=false;
  bool _def_juegoaereolateral=false;
  bool _def_juegoaereofrontal=false;
  bool _def_habilidadenel1vs1=false;
  bool _def_despeje=false;
  bool _def_anticipacion_intuicion=false;
  bool _def_coberturadelineadefensiva=false;
  bool _def_abps=false;
  bool _def_penaltis=false;
  int _edadRange1;
  int _edadRange2;

  String idCategoria="";
  String idTemporada="";
  String idPais="";
  String idEquipo="";

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }

  Image image;

  Jugador(this._jugador, this._equipo, this._categoria, this._pais,
      this._posicion,
      this._imagen, {id});

  Jugador.fromMap(dynamic obj) {
    this.key = obj['id'];
    this.id = obj['id'];
    this._categoria = obj['CATEGORIA'];
    this._equipo = obj['EQUIPO'];
    this._imagen = obj['IMAGEN'];
    this._jugador = obj['JUGADOR'];
    this._fechaNacimiento = obj['FECHANACIMIENTO'];
    this._nivel = obj['NIVEL'].toString();
    this._tipo = obj['tipo'].toString();

    this._fechaContrato =obj['FECHACONTRATO'];
    this._dorsal =obj['DORSAL'];
    this._peso= obj['PESO'].toString();
    this._altura= obj['ALTURA'].toString();
    this._valor= obj['VALOR'].toString();
    this._paisNacimiento= obj['LUGAR_NACIMIENTO'];
    this._contrato= obj['contrato'];

    this._veredicto= obj['VEREDICTO'];
    this._prestamo= obj['PRESTAMO'];
    this._lateral= obj['LATERAL'];

    this._ccaa= obj['CCAA'];
    this._nacionalidad =obj['NACIONALIDAD'];
    this._posicionalternativa =obj['POSICION_ALTERNATIVA'];


    this._observaciones_1 = obj['OBSERVAIONES_1'];
    this._pais = obj['PAIS'];
    this._posicion = obj['POSICION'];
    this._posicion2 = obj['posicion2'];
    this._ofe_niveltecnico = obj['_ofe_niveltecnico'] == 1 ? true : false;
    this._ofe_profundidad = obj['_ofe_profundidad'] == 1 ? true : false;
    this._ofe_capacidaddegenerarbuenoscentrosalarea =
    obj['_ofe_capacidaddegenerarbuenoscentrosalarea'] == 1 ? true : false;
    this._ofe_capacidaddeasociacion =
    obj['_ofe_capacidaddeasociacion'] == 1 ? true : false;
    this._ofe_desborde = obj['_ofe_desborde'] == 1 ? true : false;
    this._ofe_superioridadpordentro =
    obj['_ofe_superioridadpordentro'] == 1 ? true : false;
    this._ofe_finalizacion = obj['_ofe_finalizacion'] == 1 ? true : false;
    this._ofe_saquedebanda_longitud =
    obj['_ofe_saquedebanda_longitud'] == 1 ? true : false;
    this._ofe_lanzadordeabps = obj['_ofe_lanzadordeabps'] == 1 ? true : false;
    this._ofe_salidadebalon = obj['_ofe_salidadebalon'] == 1 ? true : false;
    this._ofe_paselargo_medio = obj['_ofe_paselargo_medio'] == 1 ? true : false;
    this._ofe_cambiosdeorientacion =
    obj['_ofe_cambiosdeorientacion'] == 1 ? true : false;
    this._ofe_batelineasconpaseinterior =
    obj['_ofe_batelineasconpaseinterior'] == 1 ? true : false;
    this._ofe_conduccionparadividir =
    obj['_ofe_conduccionparadividir'] == 1 ? true : false;
    this._ofe_primerpasetrasrecuperacion =
    obj['_ofe_primerpasetrasrecuperacion'] == 1 ? true : false;
    this._ofe_intervieneenabps =
    obj['_ofe_intervieneenabps'] == 1 ? true : false;
    this._ofe_velocidadeneljuego =
    obj['_ofe_velocidadeneljuego'] == 1 ? true : false;
    this._ofe_incorporacionazonasderemate =
    obj['_ofe_incorporacionazonasderemate'] == 1 ? true : false;
    this._ofe_amplitud = obj['_ofe_amplitud'] == 1 ? true : false;
    this._ofe_desmarquesdeapoyo =
    obj['_ofe_desmarquesdeapoyo'] == 1 ? true : false;
    this._ofe_desmarquesderuptura =
    obj['_ofe_desmarquesderuptura'] == 1 ? true : false;
    this._ofe_capacidaddegenerarbuenoscentroslateralesalarea =
    obj['_ofe_capacidaddegenerarbuenoscentroslateralesalarea'] == 1
        ? true
        : false;
    this._ofe_habilidad1vs1 = obj['_ofe_habilidad1vs1'] == 1 ? true : false;
    this._ofe_realizaciondelultimopase =
    obj['_ofe_realizaciondelultimopase'] == 1 ? true : false;
    this._ofe_goleador = obj['_ofe_goleador'] == 1 ? true : false;
    this._ofe_explotaciondeespacios =
    obj['_ofe_explotaciondeespacios'] == 1 ? true : false;
    this._ofe_duelosaereos = obj['_ofe_duelosaereos'] == 1 ? true : false;
    this._ofe_desbordeporvelocidad =
    obj['_ofe_desbordeporvelocidad'] == 1 ? true : false;
    this._ofe_dominiode2vs1_pared =
    obj['_ofe_dominiode2vs1_pared'] == 1 ? true : false;
    this._ofe_ambidextro = obj['_ofe_ambidextro'] == 1 ? true : false;
    this._ofe_juegodecara = obj['_ofe_juegodecara'] == 1 ? true : false;
    this._ofe_protecciondelbalon =
    obj['_ofe_protecciondelbalon'] == 1 ? true : false;
    this._ofe_caidasabanda = obj['_ofe_caidasabanda'] == 1 ? true : false;
    this._ofe_prolongacionesaereas =
    obj['_ofe_prolongacionesaereas'] == 1 ? true : false;
    this._ofe_dominiodelarea = obj['_ofe_dominiodelarea'] == 1 ? true : false;
    this._ofe_llegadaaposicionesderemate =
    obj['_ofe_llegadaaposicionesderemate'] == 1 ? true : false;
    this._ofe_juegoesespacioreducido =
    obj['_ofe_juegoesespacioreducido'] == 1 ? true : false;
    this._ofe_definidor_anteelportero =
    obj['_ofe_definidor_anteelportero'] == 1 ? true : false;
    this._ofe_rematador_finalizador =
    obj['_ofe_rematador_finalizador'] == 1 ? true : false;
    this._ofe_capacidadasociativa_apoyosalalineadefensiva =
    obj['_ofe_capacidadasociativa_apoyosalalineadefensiva'] == 1 ? true : false;
    this._ofe_desplazamientoenlargo =
    obj['_ofe_desplazamientoenlargo'] == 1 ? true : false;
    this._fis_velocidaddereaccion =
    obj['_fis_velocidaddereaccion'] == 1 ? true : false;
    this._fis_velocidaddedesplazamiento =
    obj['_fis_velocidaddedesplazamiento'] == 1 ? true : false;
    this._fis_agilidad = obj['_fis_agilidad'] == 1 ? true : false;
    this._fis_velocidaddereaccion =
    obj['_fis_velocidaddereaccion'] == 1 ? true : false;
    this._fis_fuerza_potencia = obj['_fis_fuerza_potencia'] == 1 ? true : false;
    this._fis_cuerpoacuerpo = obj['_fis_cuerpoacuerpo'] == 1 ? true : false;
    this._fis_capacidaddesalto =
    obj['_fis_capacidaddesalto'] == 1 ? true : false;
    this._fis_explosividad = obj['_fis_explosividad'] == 1 ? true : false;
    this._fis_potenciadesaltolateralyvertical =
    obj['_fis_potenciadesaltolateralyvertical'] == 1 ? true : false;
    this._fis_resistencia_idayvuelta =
    obj['_fis_resistencia_idayvuelta'] == 1 ? true : false;
    this._fis_cambioderitmo = obj['_fis_cambioderitmo'] == 1 ? true : false;
    this._fis_envergadura = obj['_fis_envergadura'];
    this._psic_liderazgo = obj['_psic_liderazgo'] == 1 ? true : false;
    this._psic_comunicacion = obj['_psic_comunicacion'] == 1 ? true : false;
    this._psic_seguridad = obj['_psic_seguridad'] == 1 ? true : false;
    this._psic_tomadedecisiones =
    obj['_psic_tomadedecisiones'] == 1 ? true : false;
    this._psic_agresividad = obj['_psic_agresividad'] == 1 ? true : false;
    this._psic_polivalencia = obj['_psic_polivalencia'] == 1 ? true : false;
    this._psic_competitividad = obj['_psic_competitividad'] == 1 ? true : false;
    this._psic_agresividad_contundencia =
    obj['_psic_agresividad_contundencia'] == 1 ? true : false;
    this._psic_noasumeriesgosextremos =
    obj['_psic_noasumeriesgosextremos'] == 1 ? true : false;
    this._psic_entendimientodeljuego_inteligencia =
    obj['_psic_entendimientodeljuego_inteligencia'] == 1 ? true : false;
    this._psic_creatividad = obj['_psic_creatividad'] == 1 ? true : false;
    this._psic_confianza = obj['_psic_confianza'] == 1 ? true : false;
    this._psic_compromiso = obj['_psic_compromiso'] == 1 ? true : false;
    this._psic_valentia = obj['_psic_valentia'] == 1 ? true : false;
    this._psic_oportunismo = obj['_psic_oportunismo'] == 1 ? true : false;
    this._def_acoso_presionsobreeloponente =
    obj['_def_acoso_presionsobreeloponente'] == 1 ? true : false;
    this._def_actituddefensiva =
    obj['_def_actituddefensiva'] == 1 ? true : false;
    this._def_activaciondelosmecanismosdepresion =
    obj['_def_activaciondelosmecanismosdepresion'] == 1 ? true : false;
    this._def_anticipacion = obj['_def_anticipacion'] == 1 ? true : false;
    this._def_ayudaspermanentesallateral =
    obj['_def_ayudaspermanentesallateral'] == 1 ? true : false;
    this._def_capacidaddemarcaje =
    obj['_def_capacidaddemarcaje'] == 1 ? true : false;
    this._def_capacidadparataparcentros =
    obj['_def_capacidadparataparcentros'] == 1 ? true : false;
    this._def_cerrarelladodebil_basculaciones =
    obj['_def_cerrarelladodebil_basculaciones'] == 1 ? true : false;
    this._def_cierralineasdepase =
    obj['_def_cierralineasdepase'] == 1 ? true : false;
    this._def_coberturadecentrales =
    obj['_def_coberturadecentrales'] == 1 ? true : false;
    this._def_coberturas = obj['_def_coberturas'] == 1 ? true : false;
    this._def_colocacion = obj['_def_colocacion'] == 1 ? true : false;
    this._def_comportamientofueradezona =
    obj['_def_comportamientofueradezona'] == 1 ? true : false;
    this._def_correctabasculacion =
    obj['_def_correctabasculacion'] == 1 ? true : false;
    this._def_correctabasculacion_distanciadeintervalos =
    obj['_def_correctabasculacion_distanciadeintervalos'] == 1 ? true : false;
    this._def_correctoperfilamiento =
    obj['_def_correctoperfilamiento'] == 1 ? true : false;
    this._def_cruces = obj['_def_cruces'] == 1 ? true : false;
    this._def_destrezaantecentroslaterales =
    obj['_def_destrezaantecentroslaterales'] == 1 ? true : false;
    this._def_dificildesuperarenel1vs1 =
    obj['_def_dificildesuperarenel1vs1'] == 1 ? true : false;
    this._def_dominiodelaszonasderechace =
    obj['_def_dominiodelaszonasderechace'] == 1 ? true : false;
    this._def_duelosaereos = obj['_def_duelosaereos'] == 1 ? true : false;
    this._def_duelosdefensivos =
    obj['_def_duelosdefensivos'] == 1 ? true : false;
    this._def_evitarecepcionesentrelineas =
    obj['_def_evitarecepcionesentrelineas'] == 1 ? true : false;
    this._def_evitaserdesbordado =
    obj['_def_evitaserdesbordado'] == 1 ? true : false;
    this._def_interceptaciondetiro =
    obj['_def_interceptaciondetiro'] == 1 ? true : false;
    this._def_mantenerlalineadefensiva =
    obj['_def_mantenerlalineadefensiva'] == 1 ? true : false;
    this._def_marcajeproximoaoponentedirecto =
    obj['_def_marcajeproximoaoponentedirecto'] == 1 ? true : false;
    this._def_ocupaespaciosdecompanerossuperados =
    obj['_def_ocupaespaciosdecompanerossuperados'] == 1 ? true : false;
    this._def_perfilamientos = obj['_def_perfilamientos'] == 1 ? true : false;
    this._def_permiteelgiro = obj['_def_permiteelgiro'] == 1 ? true : false;
    this._def_presiontrasperdida =
    obj['_def_presiontrasperdida'] == 1 ? true : false;
    this._def_resolucionanteparedesrivales =
    obj['_def_resolucionanteparedesrivales'] == 1 ? true : false;
    this._def_sabecuidarsuespalda =
    obj['_def_sabecuidarsuespalda'] == 1 ? true : false;
    this._def_vigilayreferenciaalrival_enfaseofensiva =
    obj['_def_vigilayreferenciaalrival_enfaseofensiva'] == 1 ? true : false;
    this._def_vigilanciassobrelateralrival =
    obj['_def_vigilanciassobrelateralrival'] == 1 ? true : false;
    this._def_blocaje = obj['_def_blocaje'] == 1 ? true : false;
    this._def_juegoaereolateral =
    obj['_def_juegoaereolateral'] == 1 ? true : false;
    this._def_juegoaereofrontal =
    obj['_def_juegoaereofrontal'] == 1 ? true : false;
    this._def_habilidadenel1vs1 =
    obj['_def_habilidadenel1vs1'] == 1 ? true : false;
    this._def_despeje = obj['_def_despeje'] == 1 ? true : false;
    this._def_anticipacion_intuicion =
    obj['_def_anticipacion_intuicion'] == 1 ? true : false;
    this._def_coberturadelineadefensiva =
    obj['_def_coberturadelineadefensiva'] == 1 ? true : false;
    this._def_abps = obj['_def_abps'] == 1 ? true : false;
    this._def_penaltis = obj['_def_penaltis'] == 1 ? true : false;
  }

  /*Jugador.fromJson(this.key, Map data){
    pais = data['pais'];
    if(pais == null){
      pais = 'nadaaa';
    }
  }*/


  Jugador.fromSnapshot(DataSnapshot obj) {
      this.key = obj.key;
    this._id = obj.key;
    this._categoria = obj.value['categoria'];
    this._equipo = obj.value['equipo'];

    this._imagen = obj.value['imagen'];
    this._jugador = obj.value['jugador'];
    this._fechaNacimiento = obj.value['fechaNacimiento'];

    this._nivel = obj.value['nivel'];
    this._nivel2 = obj.value['nivel2'];
    this._nivel3 = obj.value['nivel3'];
    this._nivel4 = obj.value['nivel4'];
    this._tipo = obj.value['tipo'];

    this._fechaContrato =obj.value['_fechaContrato'];
    this._dorsal=obj.value['_dorsal'] is int?obj.value['_dorsal']:int.parse(obj.value['_dorsal']);
    this._peso= obj.value['_peso'];
    this._altura= obj.value['_altura'];
    this._valor= obj.value['_valor'];
    this._paisNacimiento= obj.value['_paisNacimiento'];
    this._contrato= obj.value['_contrato'];

    this._veredicto= obj.value['_veredicto']==null?"":obj.value['_veredicto'];
    this._prestamo= obj.value['_prestamo']==null?"no":obj.value['_prestamo'];
    this._lateral= obj.value['_lateral'];
    this._ccaa= obj.value['ccaa']==null?"":obj.value['ccaa'];
    this._nacionalidad =obj.value['nacionalidad']==null?"":obj.value['nacionalidad'];
    this._posicionalternativa =obj.value['posicionalternativa']==null?"":obj.value['posicionalternativa'];



    this._observaciones_1 = obj.value['observaciones_1'];
    this._observaciones_2 = obj.value['observaciones_2'];
    this._observaciones_3 = obj.value['observaciones_3'];
    this._observaciones_4 = obj.value['observaciones_4'];
    this._pais = obj.value['pais'];
    this._posicion = obj.value['posicion'];
    this._posicion2 = obj.value['posicion2'];
    this._ofe_niveltecnico = obj.value['_ofe_niveltecnico'];
    this._ofe_profundidad = obj.value['_ofe_profundidad'];
    this._ofe_capacidaddegenerarbuenoscentrosalarea =
    obj.value['_ofe_capacidaddegenerarbuenoscentrosalarea'];
    this._ofe_capacidaddeasociacion = obj.value['_ofe_capacidaddeasociacion'];
    this._ofe_desborde = obj.value['_ofe_desborde'];
    this._ofe_superioridadpordentro = obj.value['_ofe_superioridadpordentro'];
    this._ofe_finalizacion = obj.value['_ofe_finalizacion'];
    this._ofe_saquedebanda_longitud = obj.value['_ofe_saquedebanda_longitud'];
    this._ofe_lanzadordeabps = obj.value['_ofe_lanzadordeabps'];
    this._ofe_salidadebalon = obj.value['_ofe_salidadebalon'];
    this._ofe_paselargo_medio = obj.value['_ofe_paselargo_medio'];
    this._ofe_cambiosdeorientacion = obj.value['_ofe_cambiosdeorientacion'];
    this._ofe_batelineasconpaseinterior =
    obj.value['_ofe_batelineasconpaseinterior'];
    this._ofe_conduccionparadividir = obj.value['_ofe_conduccionparadividir'];
    this._ofe_primerpasetrasrecuperacion =
    obj.value['_ofe_primerpasetrasrecuperacion'];
    this._ofe_intervieneenabps = obj.value['_ofe_intervieneenabps'];
    this._ofe_velocidadeneljuego = obj.value['_ofe_velocidadeneljuego'];
    this._ofe_incorporacionazonasderemate =
    obj.value['_ofe_incorporacionazonasderemate'];
    this._ofe_amplitud = obj.value['_ofe_amplitud'];
    this._ofe_desmarquesdeapoyo = obj.value['_ofe_desmarquesdeapoyo'];
    this._ofe_desmarquesderuptura = obj.value['_ofe_desmarquesderuptura'];
    this._ofe_capacidaddegenerarbuenoscentroslateralesalarea =
    obj.value['_ofe_capacidaddegenerarbuenoscentroslateralesalarea'];
    this._ofe_habilidad1vs1 = obj.value['_ofe_habilidad1vs1'];
    this._ofe_realizaciondelultimopase =
    obj.value['_ofe_realizaciondelultimopase'];
    this._ofe_goleador = obj.value['_ofe_goleador'];
    this._ofe_explotaciondeespacios = obj.value['_ofe_explotaciondeespacios'];
    this._ofe_duelosaereos = obj.value['_ofe_duelosaereos'];
    this._ofe_desbordeporvelocidad = obj.value['_ofe_desbordeporvelocidad'];
    this._ofe_dominiode2vs1_pared = obj.value['_ofe_dominiode2vs1_pared'];
    this._ofe_ambidextro = obj.value['_ofe_ambidextro'];
    this._ofe_juegodecara = obj.value['_ofe_juegodecara'];
    this._ofe_protecciondelbalon = obj.value['_ofe_protecciondelbalon'];
    this._ofe_caidasabanda = obj.value['_ofe_caidasabanda'];
    this._ofe_prolongacionesaereas = obj.value['_ofe_prolongacionesaereas'];
    this._ofe_dominiodelarea = obj.value['_ofe_dominiodelarea'];
    this._ofe_llegadaaposicionesderemate =
    obj.value['_ofe_llegadaaposicionesderemate'];
    this._ofe_juegoesespacioreducido = obj.value['_ofe_juegoesespacioreducido'];
    this._ofe_definidor_anteelportero =
    obj.value['_ofe_definidor_anteelportero'];
    this._ofe_rematador_finalizador = obj.value['_ofe_rematador_finalizador'];
    this._ofe_capacidadasociativa_apoyosalalineadefensiva =
    obj.value['_ofe_capacidadasociativa_apoyosalalineadefensiva'];
    this._ofe_desplazamientoenlargo = obj.value['_ofe_desplazamientoenlargo'];
    this._fis_velocidaddereaccion = obj.value['_fis_velocidaddereaccion'];
    this._fis_velocidaddedesplazamiento =
    obj.value['_fis_velocidaddedesplazamiento'];
    this._fis_agilidad = obj.value['_fis_agilidad'];
    this._fis_fuerza_potencia = obj.value['_fis_fuerza_potencia'];
    this._fis_cuerpoacuerpo = obj.value['_fis_cuerpoacuerpo'];
    this._fis_capacidaddesalto = obj.value['_fis_capacidaddesalto'];
    this._fis_explosividad = obj.value['_fis_explosividad'];
    this._fis_potenciadesaltolateralyvertical =
    obj.value['_fis_potenciadesaltolateralyvertical'];
    this._fis_resistencia_idayvuelta = obj.value['_fis_resistencia_idayvuelta'];
    this._fis_cambioderitmo = obj.value['_fis_cambioderitmo'];
    this._fis_envergadura = obj.value['_fis_envergadura'];
    this._psic_liderazgo = obj.value['_psic_liderazgo'];
    this._psic_comunicacion = obj.value['_psic_comunicacion'];
    this._psic_seguridad = obj.value['_psic_seguridad'];
    this._psic_tomadedecisiones = obj.value['_psic_tomadedecisiones'];
    this._psic_agresividad = obj.value['_psic_agresividad'];
    this._psic_polivalencia = obj.value['_psic_polivalencia'];
    this._psic_competitividad = obj.value['_psic_competitividad'];
    this._psic_agresividad_contundencia =
    obj.value['_psic_agresividad_contundencia'];
    this._psic_noasumeriesgosextremos =
    obj.value['_psic_noasumeriesgosextremos'];
    this._psic_entendimientodeljuego_inteligencia =
    obj.value['_psic_entendimientodeljuego_inteligencia'];
    this._psic_creatividad = obj.value['_psic_creatividad'];
    this._psic_confianza = obj.value['_psic_confianza'];
    this._psic_compromiso = obj.value['_psic_compromiso'];
    this._psic_valentia = obj.value['_psic_valentia'];
    this._psic_oportunismo = obj.value['_psic_oportunismo'];
    this._def_acoso_presionsobreeloponente =
    obj.value['_def_acoso_presionsobreeloponente'];
    this._def_actituddefensiva = obj.value['_def_actituddefensiva'];
    this._def_activaciondelosmecanismosdepresion =
    obj.value['_def_activaciondelosmecanismosdepresion'];
    this._def_anticipacion = obj.value['_def_anticipacion'];
    this._def_ayudaspermanentesallateral =
    obj.value['_def_ayudaspermanentesallateral'];
    this._def_capacidaddemarcaje = obj.value['_def_capacidaddemarcaje'];
    this._def_capacidadparataparcentros =
    obj.value['_def_capacidadparataparcentros'];
    this._def_cerrarelladodebil_basculaciones =
    obj.value['_def_cerrarelladodebil_basculaciones'];
    this._def_cierralineasdepase = obj.value['_def_cierralineasdepase'];
    this._def_coberturadecentrales = obj.value['_def_coberturadecentrales'];
    this._def_coberturas = obj.value['_def_coberturas'];
    this._def_colocacion = obj.value['_def_colocacion'];
    this._def_comportamientofueradezona =
    obj.value['_def_comportamientofueradezona'];
    this._def_correctabasculacion = obj.value['_def_correctabasculacion'];
    this._def_correctabasculacion_distanciadeintervalos =
    obj.value['_def_correctabasculacion_distanciadeintervalos'];
    this._def_correctoperfilamiento = obj.value['_def_correctoperfilamiento'];
    this._def_cruces = obj.value['_def_cruces'];
    this._def_destrezaantecentroslaterales =
    obj.value['_def_destrezaantecentroslaterales'];
    this._def_dificildesuperarenel1vs1 =
    obj.value['_def_dificildesuperarenel1vs1'];
    this._def_dominiodelaszonasderechace =
    obj.value['_def_dominiodelaszonasderechace'];
    this._def_duelosaereos = obj.value['_def_duelosaereos'];
    this._def_duelosdefensivos = obj.value['_def_duelosdefensivos'];
    this._def_evitarecepcionesentrelineas =
    obj.value['_def_evitarecepcionesentrelineas'];
    this._def_evitaserdesbordado = obj.value['_def_evitaserdesbordado'];
    this._def_interceptaciondetiro = obj.value['_def_interceptaciondetiro'];
    this._def_mantenerlalineadefensiva =
    obj.value['_def_mantenerlalineadefensiva'];
    this._def_marcajeproximoaoponentedirecto =
    obj.value['_def_marcajeproximoaoponentedirecto'];
    this._def_ocupaespaciosdecompanerossuperados =
    obj.value['_def_ocupaespaciosdecompanerossuperados'];
    this._def_perfilamientos = obj.value['_def_perfilamientos'];
    this._def_permiteelgiro = obj.value['_def_permiteelgiro'];
    this._def_presiontrasperdida = obj.value['_def_presiontrasperdida'];
    this._def_resolucionanteparedesrivales =
    obj.value['_def_resolucionanteparedesrivales'];
    this._def_sabecuidarsuespalda = obj.value['_def_sabecuidarsuespalda'];
    this._def_vigilayreferenciaalrival_enfaseofensiva =
    obj.value['_def_vigilayreferenciaalrival_enfaseofensiva'];
    this._def_vigilanciassobrelateralrival =
    obj.value['_def_vigilanciassobrelateralrival'];
    this._def_blocaje = obj.value['_def_blocaje'];
    this._def_juegoaereolateral = obj.value['_def_juegoaereolateral'];
    this._def_juegoaereofrontal = obj.value['_def_juegoaereofrontal'];
    this._def_habilidadenel1vs1 = obj.value['_def_habilidadenel1vs1'];
    this._def_despeje = obj.value['_def_despeje'];
    this._def_anticipacion_intuicion = obj.value['_def_anticipacion_intuicion'];
    this._def_coberturadelineadefensiva =
    obj.value['_def_coberturadelineadefensiva'];
    this._def_abps = obj.value['_def_abps'];
    this._def_penaltis = obj.value['_def_penaltis'];
    //JugadorDao dao = JugadorDao();
    //dao.getImagen(this.id, this.imagen);
    imagen =null;
   // "https://firebasestorage.googleapis.com/v0/b/iascout.appspot.com/o/jugadores%2F${this
    //    .id}?alt=media";
  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["key"] = key;
    map["categoria"] = _categoria;
    map["equipo"] = _equipo;
    map["jugador"] = _jugador;
    map["fechaNacimiento"] = _fechaNacimiento;

    map["nivel"] = _nivel;
    map["nivel2"] = _nivel2;
    map["nivel3"] = _nivel3;
    map["nivel4"] = _nivel4;
    map["tipo"] = _tipo;


     map["_fechaContrato"]=_fechaContrato;
     map["_dorsal"]=_dorsal;
     map["_peso"]= _peso;
     map["_altura"]= _altura;
     map["_valor"]= _valor;
    map["_paisNacimiento"]= _paisNacimiento;
    map["_contrato"]= _contrato;

    map["_veredicto"]= _veredicto;
    map["_prestamo"]= _prestamo;
    map["_lateral"]= _lateral;
    map['_ccaa']=_ccaa;
    map['_nacionalidad']=_nacionalidad;
    map['_posicionalternativa']=_posicionalternativa;

    map["observaciones_1"] = _observaciones_1 == null ? "" : observaciones_1;
    map["observaciones_2"] = _observaciones_2 == null ? "" : observaciones_2;
    map["observaciones_3"] = _observaciones_3 == null ? "" : observaciones_3;
    map["observaciones_4"] = _observaciones_4 == null ? "" : observaciones_4;
    map["pais"] = _pais;
    map["posicion"] = _posicion;
    map["posicion2"] = _posicion2;
    map['_ofe_niveltecnico'] = _ofe_niveltecnico;
    map['_ofe_profundidad'] = _ofe_profundidad;
    map['_ofe_capacidaddegenerarbuenoscentrosalarea'] =
        _ofe_capacidaddegenerarbuenoscentrosalarea;
    map['_ofe_capacidaddeasociacion'] = _ofe_capacidaddeasociacion;
    map['_ofe_desborde'] = _ofe_desborde;
    map['_ofe_superioridadpordentro'] = _ofe_superioridadpordentro;
    map['_ofe_finalizacion'] = _ofe_finalizacion;
    map['_ofe_saquedebanda_longitud'] = _ofe_saquedebanda_longitud;
    map['_ofe_lanzadordeabps'] = _ofe_lanzadordeabps;
    map['_ofe_salidadebalon'] = _ofe_salidadebalon;
    map['_ofe_paselargo_medio'] = _ofe_paselargo_medio;
    map['_ofe_cambiosdeorientacion'] = _ofe_cambiosdeorientacion;
    map['_ofe_batelineasconpaseinterior'] = _ofe_batelineasconpaseinterior;
    map['_ofe_conduccionparadividir'] = _ofe_conduccionparadividir;
    map['_ofe_primerpasetrasrecuperacion'] = _ofe_primerpasetrasrecuperacion;
    map['_ofe_intervieneenabps'] = _ofe_intervieneenabps;
    map['_ofe_velocidadeneljuego'] = _ofe_velocidadeneljuego;
    map['_ofe_incorporacionazonasderemate'] = _ofe_incorporacionazonasderemate;
    map['_ofe_amplitud'] = _ofe_amplitud;
    map['_ofe_desmarquesdeapoyo'] = _ofe_desmarquesdeapoyo;
    map['_ofe_desmarquesderuptura'] = _ofe_desmarquesderuptura;
    map['_ofe_capacidaddegenerarbuenoscentroslateralesalarea'] =
        _ofe_capacidaddegenerarbuenoscentroslateralesalarea;
    map['_ofe_habilidad1vs1'] = _ofe_habilidad1vs1;
    map['_ofe_realizaciondelultimopase'] = _ofe_realizaciondelultimopase;
    map['_ofe_goleador'] = _ofe_goleador;
    map['_ofe_explotaciondeespacios'] = _ofe_explotaciondeespacios;
    map['_ofe_duelosaereos'] = _ofe_duelosaereos;
    map['_ofe_desbordeporvelocidad'] = _ofe_desbordeporvelocidad;
    map['_ofe_dominiode2vs1_pared'] = _ofe_dominiode2vs1_pared;
    map['_ofe_ambidextro'] = _ofe_ambidextro;
    map['_ofe_juegodecara'] = _ofe_juegodecara;
    map['_ofe_protecciondelbalon'] = _ofe_protecciondelbalon;
    map['_ofe_caidasabanda'] = _ofe_caidasabanda;
    map['_ofe_prolongacionesaereas'] = _ofe_prolongacionesaereas;
    map['_ofe_dominiodelarea'] = _ofe_dominiodelarea;
    map['_ofe_llegadaaposicionesderemate'] = _ofe_llegadaaposicionesderemate;
    map['_ofe_juegoesespacioreducido'] = _ofe_juegoesespacioreducido;
    map['_ofe_definidor_anteelportero'] = _ofe_definidor_anteelportero;
    map['_ofe_rematador_finalizador'] = _ofe_rematador_finalizador;
    map['_ofe_capacidadasociativa_apoyosalalineadefensiva'] =
        _ofe_capacidadasociativa_apoyosalalineadefensiva;
    map['_ofe_desplazamientoenlargo'] = _ofe_desplazamientoenlargo;
    map['_fis_velocidaddereaccion'] = _fis_velocidaddereaccion;
    map['_fis_velocidaddedesplazamiento'] = _fis_velocidaddedesplazamiento;
    map['_fis_agilidad'] = _fis_agilidad;
    map['_fis_velocidaddereaccion'] = _fis_velocidaddereaccion;
    map['_fis_fuerza_potencia'] = _fis_fuerza_potencia;
    map['_fis_cuerpoacuerpo'] = _fis_cuerpoacuerpo;
    map['_fis_capacidaddesalto'] = _fis_capacidaddesalto;
    map['_fis_explosividad'] = _fis_explosividad;
    map['_fis_potenciadesaltolateralyvertical'] =
        _fis_potenciadesaltolateralyvertical;
    map['_fis_resistencia_idayvuelta'] = _fis_resistencia_idayvuelta;
    map['_fis_cambioderitmo'] = _fis_cambioderitmo;
    map['_fis_envergadura'] = _fis_envergadura;
    map['_psic_liderazgo'] = _psic_liderazgo;
    map['_psic_comunicacion'] = _psic_comunicacion;
    map['_psic_seguridad'] = _psic_seguridad;
    map['_psic_tomadedecisiones'] = _psic_tomadedecisiones;
    map['_psic_agresividad'] = _psic_agresividad;
    map['_psic_polivalencia'] = _psic_polivalencia;
    map['_psic_competitividad'] = _psic_competitividad;
    map['_psic_agresividad_contundencia'] = _psic_agresividad_contundencia;
    map['_psic_noasumeriesgosextremos'] = _psic_noasumeriesgosextremos;
    map['_psic_entendimientodeljuego_inteligencia'] =
        _psic_entendimientodeljuego_inteligencia;
    map['_psic_creatividad'] = _psic_creatividad;
    map['_psic_confianza'] = _psic_confianza;
    map['_psic_compromiso'] = _psic_compromiso;
    map['_psic_valentia'] = _psic_valentia;
    map['_psic_oportunismo'] = _psic_oportunismo;
    map['_def_acoso_presionsobreeloponente'] =
        _def_acoso_presionsobreeloponente;
    map['_def_actituddefensiva'] = _def_actituddefensiva;
    map['_def_activaciondelosmecanismosdepresion'] =
        _def_activaciondelosmecanismosdepresion;
    map['_def_anticipacion'] = _def_anticipacion;
    map['_def_ayudaspermanentesallateral'] = _def_ayudaspermanentesallateral;
    map['_def_capacidaddemarcaje'] = _def_capacidaddemarcaje;
    map['_def_capacidadparataparcentros'] = _def_capacidadparataparcentros;
    map['_def_cerrarelladodebil_basculaciones'] =
        _def_cerrarelladodebil_basculaciones;
    map['_def_cierralineasdepase'] = _def_cierralineasdepase;
    map['_def_coberturadecentrales'] = _def_coberturadecentrales;
    map['_def_coberturas'] = _def_coberturas;
    map['_def_colocacion'] = _def_colocacion;
    map['_def_comportamientofueradezona'] = _def_comportamientofueradezona;
    map['_def_correctabasculacion'] = _def_correctabasculacion;
    map['_def_correctabasculacion_distanciadeintervalos'] =
        _def_correctabasculacion_distanciadeintervalos;
    map['_def_correctoperfilamiento'] = _def_correctoperfilamiento;
    map['_def_cruces'] = _def_cruces;
    map['_def_destrezaantecentroslaterales'] =
        _def_destrezaantecentroslaterales;
    map['_def_dificildesuperarenel1vs1'] = _def_dificildesuperarenel1vs1;
    map['_def_dominiodelaszonasderechace'] = _def_dominiodelaszonasderechace;
    map['_def_duelosaereos'] = _def_duelosaereos;
    map['_def_duelosdefensivos'] = _def_duelosdefensivos;
    map['_def_evitarecepcionesentrelineas'] = _def_evitarecepcionesentrelineas;
    map['_def_evitaserdesbordado'] = _def_evitaserdesbordado;
    map['_def_interceptaciondetiro'] = _def_interceptaciondetiro;
    map['_def_mantenerlalineadefensiva'] = _def_mantenerlalineadefensiva;
    map['_def_marcajeproximoaoponentedirecto'] =
        _def_marcajeproximoaoponentedirecto;
    map['_def_ocupaespaciosdecompanerossuperados'] =
        _def_ocupaespaciosdecompanerossuperados;
    map['_def_perfilamientos'] = _def_perfilamientos;
    map['_def_permiteelgiro'] = _def_permiteelgiro;
    map['_def_presiontrasperdida'] = _def_presiontrasperdida;
    map['_def_resolucionanteparedesrivales'] =
        _def_resolucionanteparedesrivales;
    map['_def_sabecuidarsuespalda'] = _def_sabecuidarsuespalda;
    map['_def_vigilayreferenciaalrival_enfaseofensiva'] =
        _def_vigilayreferenciaalrival_enfaseofensiva;
    map['_def_vigilanciassobrelateralrival'] =
        _def_vigilanciassobrelateralrival;
    map['_def_blocaje'] = _def_blocaje;
    map['_def_juegoaereolateral'] = _def_juegoaereolateral;
    map['_def_juegoaereofrontal'] = _def_juegoaereofrontal;
    map['_def_habilidadenel1vs1'] = _def_habilidadenel1vs1;
    map['_def_despeje'] = _def_despeje;
    map['_def_anticipacion_intuicion'] = _def_anticipacion_intuicion;
    map['_def_coberturadelineadefensiva'] = _def_coberturadelineadefensiva;
    map['_def_abps'] = _def_abps;
    map['_def_penaltis'] = _def_penaltis;

    return map;
  }

  static Uint8List decode(File imagen) {
    Uint8List aux = imagen.readAsBytesSync();
    //var thumbnail =copyResize(imagen, width: 500)
    //print("DECODE:"+imagen.path);
    //print("DECODE2:"+imagen.readAsBytesSync().toString());
    return aux;

    /* Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    var thumbnail = copyResize(image, width: 500);

    // Save the thumbnail as a PNG.
    File('thumbnail.png').writeAsBytesSync(encodePng(thumbnail));
    return imagen;*/
  }

  Jugador.fromJson(this.key, Map obj) {
    print(obj['jugador']);
    int dorsal=-99;
    try {
      dorsal = int.parse(obj['_dorsal']);
    }
    catch(e){
      dorsal=99;
    }
    this._categoria = obj['categoria'];
    this._equipo = obj['equipo'];
    this._imagen = obj['imagen'];
    this._jugador = obj['jugador'];
    this._fechaNacimiento = obj['fechaNacimiento'];
    this._nivel = obj['nivel'].toString();
    this._nivel2 = obj['nivel2'].toString();
    this._nivel3 = obj['nivel3'].toString();
    this._nivel4 = obj['nivel4'].toString();
    this._tipo = obj['tipo'].toString();

    this._fechaContrato =obj['_fechaContrato'];
    this._dorsal =dorsal;
    this._peso= obj['_peso'];
    this._altura= obj['_altura'];
    this._valor= obj['_valor'];
    this._paisNacimiento= obj['_paisNacimiento'];
    this._contrato= obj['_contrato'];

    this._veredicto= obj['_veredicto'];
    this._prestamo= obj['_prestamo'];
    this._lateral= obj['_lateral'];

    this._ccaa= obj['ccaa'];
    this._nacionalidad =obj['nacionalidad'];
    this._posicionalternativa =obj['posicionalternativa'];

    this._observaciones_1 = obj['observaciones_1'];
    this._observaciones_2 = obj['observaciones_2'];
    this._observaciones_3 = obj['observaciones_3'];
    this._observaciones_4 = obj['observaciones_4'];
    this._pais = obj['pais'];
    this._posicion = obj['posicion'];
    this._posicion2 = obj['posicion2'];
    this._ofe_niveltecnico = obj['_ofe_niveltecnico'];
    this._ofe_profundidad = obj['_ofe_profundidad'];
    this._ofe_capacidaddegenerarbuenoscentrosalarea =
    obj['_ofe_capacidaddegenerarbuenoscentrosalarea'];
    this._ofe_capacidaddeasociacion =
    obj['_ofe_capacidaddeasociacion'];
    this._ofe_desborde = obj['_ofe_desborde'];
    this._ofe_superioridadpordentro =
    obj['_ofe_superioridadpordentro'];
    this._ofe_finalizacion = obj['_ofe_finalizacion'];
    this._ofe_saquedebanda_longitud =
    obj['_ofe_saquedebanda_longitud'];
    this._ofe_lanzadordeabps = obj['_ofe_lanzadordeabps'];
    this._ofe_salidadebalon = obj['_ofe_salidadebalon'];
    this._ofe_paselargo_medio = obj['_ofe_paselargo_medio'];
    this._ofe_cambiosdeorientacion =
    obj['_ofe_cambiosdeorientacion'];
    this._ofe_batelineasconpaseinterior =
    obj['_ofe_batelineasconpaseinterior'];
    this._ofe_conduccionparadividir =
    obj['_ofe_conduccionparadividir'];
    this._ofe_primerpasetrasrecuperacion =
    obj['_ofe_primerpasetrasrecuperacion'];
    this._ofe_intervieneenabps =
    obj['_ofe_intervieneenabps'];
    this._ofe_velocidadeneljuego =
    obj['_ofe_velocidadeneljuego'];
    this._ofe_incorporacionazonasderemate =
    obj['_ofe_incorporacionazonasderemate'];
    this._ofe_amplitud = obj['_ofe_amplitud'];
    this._ofe_desmarquesdeapoyo =
    obj['_ofe_desmarquesdeapoyo'];
    this._ofe_desmarquesderuptura =
    obj['_ofe_desmarquesderuptura'];
    this._ofe_capacidaddegenerarbuenoscentroslateralesalarea =
    obj['_ofe_capacidaddegenerarbuenoscentroslateralesalarea'];
    this._ofe_habilidad1vs1 = obj['_ofe_habilidad1vs1'];
    this._ofe_realizaciondelultimopase =
    obj['_ofe_realizaciondelultimopase'];
    this._ofe_goleador = obj['_ofe_goleador'];
    this._ofe_explotaciondeespacios =
    obj['_ofe_explotaciondeespacios'];
    this._ofe_duelosaereos = obj['_ofe_duelosaereos'];
    this._ofe_desbordeporvelocidad =
    obj['_ofe_desbordeporvelocidad'];
    this._ofe_dominiode2vs1_pared =
    obj['_ofe_dominiode2vs1_pared'];
    this._ofe_ambidextro = obj['_ofe_ambidextro'];
    this._ofe_juegodecara = obj['_ofe_juegodecara'];
    this._ofe_protecciondelbalon =
    obj['_ofe_protecciondelbalon'];
    this._ofe_caidasabanda = obj['_ofe_caidasabanda'];
    this._ofe_prolongacionesaereas =
    obj['_ofe_prolongacionesaereas'];
    this._ofe_dominiodelarea = obj['_ofe_dominiodelarea'];
    this._ofe_llegadaaposicionesderemate =
    obj['_ofe_llegadaaposicionesderemate'];
    this._ofe_juegoesespacioreducido =
    obj['_ofe_juegoesespacioreducido'];
    this._ofe_definidor_anteelportero =
    obj['_ofe_definidor_anteelportero'];
    this._ofe_rematador_finalizador =
    obj['_ofe_rematador_finalizador'];
    this._ofe_capacidadasociativa_apoyosalalineadefensiva =
    obj['_ofe_capacidadasociativa_apoyosalalineadefensiva'];
    this._ofe_desplazamientoenlargo =
    obj['_ofe_desplazamientoenlargo'];
    this._fis_velocidaddereaccion =
    obj['_fis_velocidaddereaccion'];
    this._fis_velocidaddedesplazamiento =
    obj['_fis_velocidaddedesplazamiento'];
    this._fis_agilidad = obj['_fis_agilidad'];
    this._fis_velocidaddereaccion =
    obj['_fis_velocidaddereaccion'];
    this._fis_fuerza_potencia = obj['_fis_fuerza_potencia'];
    this._fis_cuerpoacuerpo = obj['_fis_cuerpoacuerpo'];
    this._fis_capacidaddesalto =
    obj['_fis_capacidaddesalto'];
    this._fis_explosividad = obj['_fis_explosividad'];
    this._fis_potenciadesaltolateralyvertical =
    obj['_fis_potenciadesaltolateralyvertical'];
    this._fis_resistencia_idayvuelta =
    obj['_fis_resistencia_idayvuelta'];
    this._fis_cambioderitmo = obj['_fis_cambioderitmo'];
    this._fis_envergadura = obj['_fis_envergadura']==null?"":obj['_fis_envergadura'];
    this._psic_liderazgo = obj['_psic_liderazgo'];
    this._psic_comunicacion = obj['_psic_comunicacion'];
    this._psic_seguridad = obj['_psic_seguridad'];
    this._psic_tomadedecisiones =
    obj['_psic_tomadedecisiones'];
    this._psic_agresividad = obj['_psic_agresividad'];
    this._psic_polivalencia = obj['_psic_polivalencia'];
    this._psic_competitividad = obj['_psic_competitividad'];
    this._psic_agresividad_contundencia =
    obj['_psic_agresividad_contundencia'];
    this._psic_noasumeriesgosextremos =
    obj['_psic_noasumeriesgosextremos'];
    this._psic_entendimientodeljuego_inteligencia =
    obj['_psic_entendimientodeljuego_inteligencia'];
    this._psic_creatividad = obj['_psic_creatividad'];
    this._psic_confianza = obj['_psic_confianza'];
    this._psic_compromiso = obj['_psic_compromiso'];
    this._psic_valentia = obj['_psic_valentia'];
    this._psic_oportunismo = obj['_psic_oportunismo'];
    this._def_acoso_presionsobreeloponente =
    obj['_def_acoso_presionsobreeloponente'];
    this._def_actituddefensiva =
    obj['_def_actituddefensiva'];
    this._def_activaciondelosmecanismosdepresion =
    obj['_def_activaciondelosmecanismosdepresion'];
    this._def_anticipacion = obj['_def_anticipacion'];
    this._def_ayudaspermanentesallateral =
    obj['_def_ayudaspermanentesallateral'];
    this._def_capacidaddemarcaje =
    obj['_def_capacidaddemarcaje'];
    this._def_capacidadparataparcentros =
    obj['_def_capacidadparataparcentros'];
    this._def_cerrarelladodebil_basculaciones =
    obj['_def_cerrarelladodebil_basculaciones'];
    this._def_cierralineasdepase =
    obj['_def_cierralineasdepase'];
    this._def_coberturadecentrales =
    obj['_def_coberturadecentrales'];
    this._def_coberturas = obj['_def_coberturas'];
    this._def_colocacion = obj['_def_colocacion'];
    this._def_comportamientofueradezona =
    obj['_def_comportamientofueradezona'];
    this._def_correctabasculacion =
    obj['_def_correctabasculacion'];
    this._def_correctabasculacion_distanciadeintervalos =
    obj['_def_correctabasculacion_distanciadeintervalos'];
    this._def_correctoperfilamiento =
    obj['_def_correctoperfilamiento'];
    this._def_cruces = obj['_def_cruces'];
    this._def_destrezaantecentroslaterales =
    obj['_def_destrezaantecentroslaterales'];
    this._def_dificildesuperarenel1vs1 =
    obj['_def_dificildesuperarenel1vs1'];
    this._def_dominiodelaszonasderechace =
    obj['_def_dominiodelaszonasderechace'];
    this._def_duelosaereos = obj['_def_duelosaereos'];
    this._def_duelosdefensivos =
    obj['_def_duelosdefensivos'];
    this._def_evitarecepcionesentrelineas =
    obj['_def_evitarecepcionesentrelineas'];
    this._def_evitaserdesbordado =
    obj['_def_evitaserdesbordado'];
    this._def_interceptaciondetiro =
    obj['_def_interceptaciondetiro'];
    this._def_mantenerlalineadefensiva =
    obj['_def_mantenerlalineadefensiva'];
    this._def_marcajeproximoaoponentedirecto =
    obj['_def_marcajeproximoaoponentedirecto'];
    this._def_ocupaespaciosdecompanerossuperados =
    obj['_def_ocupaespaciosdecompanerossuperados'];
    this._def_perfilamientos = obj['_def_perfilamientos'];
    this._def_permiteelgiro = obj['_def_permiteelgiro'];
    this._def_presiontrasperdida =
    obj['_def_presiontrasperdida'];
    this._def_resolucionanteparedesrivales =
    obj['_def_resolucionanteparedesrivales'];
    this._def_sabecuidarsuespalda =
    obj['_def_sabecuidarsuespalda'];
    this._def_vigilayreferenciaalrival_enfaseofensiva =
    obj['_def_vigilayreferenciaalrival_enfaseofensiva'];
    this._def_vigilanciassobrelateralrival =
    obj['_def_vigilanciassobrelateralrival'];
    this._def_blocaje = obj['_def_blocaje'];
    this._def_juegoaereolateral =
    obj['_def_juegoaereolateral'];
    this._def_juegoaereofrontal =
    obj['_def_juegoaereofrontal'];
    this._def_habilidadenel1vs1 =
    obj['_def_habilidadenel1vs1'];
    this._def_despeje = obj['_def_despeje'];
    this._def_anticipacion_intuicion =
    obj['_def_anticipacion_intuicion'];
    this._def_coberturadelineadefensiva =
    obj['_def_coberturadelineadefensiva'];
    this._def_abps = obj['_def_abps'];
    this._def_penaltis = obj['_def_penaltis'];
    this.key = id;
  }
  //flutter: {name: edwdw, email: sdsdsdwd@1.com, mobileNo: 1234567789, feedback: wede}
  // Method to make GET parameters._key ,_jugador, _categoria, _equipo
  Map toJson() =>
      {
        "name": id,
  "key": key,
  "categoria" :  _categoria,
  "equipo" :  _equipo,
  "jugador" :  _jugador,
  "fechaNacimiento" :  _fechaNacimiento,
        "_temporada" :_temporada,
        "nivel" :  _nivel,
        "nivel2" :  _nivel2,
        "nivel3" :  _nivel3,
        "nivel4" :  _nivel4,
        "tipo" :  _tipo,
  "_fechaContrato":_fechaContrato,
  "_dorsal":_dorsal,
  "_peso": _peso,
  "_altura": _altura,
  "_valor": _valor,
  "_paisNacimiento": _paisNacimiento,
  "_contrato": _contrato,

  "_veredicto": _veredicto,
  "_prestamo": _prestamo,
  "_lateral": _lateral,
  "ccaa":_ccaa,
  "nacionalidad":_nacionalidad,
  "posicionalternativa":_posicionalternativa,

  "observaciones_1" :  _observaciones_1 == null ? "" : observaciones_1,
  "pais" :  _pais,
  "posicion" :  _posicion,
        "posicion2" :  _posicion2,
        '_ofe_niveltecnico' :  _ofe_niveltecnico,
  '_ofe_profundidad' :  _ofe_profundidad,
  '_ofe_capacidaddegenerarbuenoscentrosalarea' :
  _ofe_capacidaddegenerarbuenoscentrosalarea,
  '_ofe_capacidaddeasociacion' :  _ofe_capacidaddeasociacion,
  '_ofe_desborde' :  _ofe_desborde,
  '_ofe_superioridadpordentro' :  _ofe_superioridadpordentro,
  '_ofe_finalizacion' :  _ofe_finalizacion,
  '_ofe_saquedebanda_longitud' :  _ofe_saquedebanda_longitud,
  '_ofe_lanzadordeabps' :  _ofe_lanzadordeabps,
  '_ofe_salidadebalon' :  _ofe_salidadebalon,
  '_ofe_paselargo_medio' :  _ofe_paselargo_medio,
  '_ofe_cambiosdeorientacion' :  _ofe_cambiosdeorientacion,
  '_ofe_batelineasconpaseinterior' :  _ofe_batelineasconpaseinterior,
  '_ofe_conduccionparadividir' :  _ofe_conduccionparadividir,
  '_ofe_primerpasetrasrecuperacion' :  _ofe_primerpasetrasrecuperacion,
  '_ofe_intervieneenabps' :  _ofe_intervieneenabps,
  '_ofe_velocidadeneljuego' :  _ofe_velocidadeneljuego,
  '_ofe_incorporacionazonasderemate' :  _ofe_incorporacionazonasderemate,
  '_ofe_amplitud' :  _ofe_amplitud,
  '_ofe_desmarquesdeapoyo' :  _ofe_desmarquesdeapoyo,
  '_ofe_desmarquesderuptura' :  _ofe_desmarquesderuptura,
  '_ofe_capacidaddegenerarbuenoscentroslateralesalarea' :
  _ofe_capacidaddegenerarbuenoscentroslateralesalarea,
  '_ofe_habilidad1vs1' :  _ofe_habilidad1vs1,
  '_ofe_realizaciondelultimopase' :  _ofe_realizaciondelultimopase,
  '_ofe_goleador' :  _ofe_goleador,
  '_ofe_explotaciondeespacios' :  _ofe_explotaciondeespacios,
  '_ofe_duelosaereos' :  _ofe_duelosaereos,
  '_ofe_desbordeporvelocidad' :  _ofe_desbordeporvelocidad,
  '_ofe_dominiode2vs1_pared' :  _ofe_dominiode2vs1_pared,
  '_ofe_ambidextro' :  _ofe_ambidextro,
  '_ofe_juegodecara' :  _ofe_juegodecara,
  '_ofe_protecciondelbalon' :  _ofe_protecciondelbalon,
  '_ofe_caidasabanda' :  _ofe_caidasabanda,
  '_ofe_prolongacionesaereas' :  _ofe_prolongacionesaereas,
  '_ofe_dominiodelarea' :  _ofe_dominiodelarea,
  '_ofe_llegadaaposicionesderemate' :  _ofe_llegadaaposicionesderemate,
  '_ofe_juegoesespacioreducido' :  _ofe_juegoesespacioreducido,
  '_ofe_definidor_anteelportero' :  _ofe_definidor_anteelportero,
  '_ofe_rematador_finalizador' :  _ofe_rematador_finalizador,
  '_ofe_capacidadasociativa_apoyosalalineadefensiva' :
  _ofe_capacidadasociativa_apoyosalalineadefensiva,
  '_ofe_desplazamientoenlargo' :  _ofe_desplazamientoenlargo,
  '_fis_velocidaddereaccion' :  _fis_velocidaddereaccion,
  '_fis_velocidaddedesplazamiento' :  _fis_velocidaddedesplazamiento,
  '_fis_agilidad' :  _fis_agilidad,
  '_fis_velocidaddereaccion' :  _fis_velocidaddereaccion,
  '_fis_fuerza_potencia' :  _fis_fuerza_potencia,
  '_fis_cuerpoacuerpo' :  _fis_cuerpoacuerpo,
  '_fis_capacidaddesalto' :  _fis_capacidaddesalto,
  '_fis_explosividad' :  _fis_explosividad,
  '_fis_potenciadesaltolateralyvertical' :
  _fis_potenciadesaltolateralyvertical,
  '_fis_resistencia_idayvuelta' :  _fis_resistencia_idayvuelta,
  '_fis_cambioderitmo' :  _fis_cambioderitmo,
  '_fis_envergadura' :  _fis_envergadura,
  '_psic_liderazgo' :  _psic_liderazgo,
  '_psic_comunicacion' :  _psic_comunicacion,
  '_psic_seguridad' :  _psic_seguridad,
  '_psic_tomadedecisiones' :  _psic_tomadedecisiones,
  '_psic_agresividad' :  _psic_agresividad,
  '_psic_polivalencia' :  _psic_polivalencia,
  '_psic_competitividad' :  _psic_competitividad,
  '_psic_agresividad_contundencia' :  _psic_agresividad_contundencia,
  '_psic_noasumeriesgosextremos' :  _psic_noasumeriesgosextremos,
  '_psic_entendimientodeljuego_inteligencia' :
  _psic_entendimientodeljuego_inteligencia,
  '_psic_creatividad' :  _psic_creatividad,
  '_psic_confianza' :  _psic_confianza,
  '_psic_compromiso' :  _psic_compromiso,
  '_psic_valentia' :  _psic_valentia,
  '_psic_oportunismo' :  _psic_oportunismo,
  '_def_acoso_presionsobreeloponente' :
  _def_acoso_presionsobreeloponente,
  '_def_actituddefensiva' :  _def_actituddefensiva,
  '_def_activaciondelosmecanismosdepresion' :
  _def_activaciondelosmecanismosdepresion,
  '_def_anticipacion' :  _def_anticipacion,
  '_def_ayudaspermanentesallateral' :  _def_ayudaspermanentesallateral,
  '_def_capacidaddemarcaje' :  _def_capacidaddemarcaje,
  '_def_capacidadparataparcentros' :  _def_capacidadparataparcentros,
  '_def_cerrarelladodebil_basculaciones' :
  _def_cerrarelladodebil_basculaciones,
  '_def_cierralineasdepase' :  _def_cierralineasdepase,
  '_def_coberturadecentrales' :  _def_coberturadecentrales,
  '_def_coberturas' :  _def_coberturas,
  '_def_colocacion' :  _def_colocacion,
  '_def_comportamientofueradezona' :  _def_comportamientofueradezona,
  '_def_correctabasculacion' :  _def_correctabasculacion,
  '_def_correctabasculacion_distanciadeintervalos' :
  _def_correctabasculacion_distanciadeintervalos,
  '_def_correctoperfilamiento' :  _def_correctoperfilamiento,
  '_def_cruces' :  _def_cruces,
  '_def_destrezaantecentroslaterales' :
  _def_destrezaantecentroslaterales,
  '_def_dificildesuperarenel1vs1' :  _def_dificildesuperarenel1vs1,
  '_def_dominiodelaszonasderechace' :  _def_dominiodelaszonasderechace,
  '_def_duelosaereos' :  _def_duelosaereos,
  '_def_duelosdefensivos' :  _def_duelosdefensivos,
  '_def_evitarecepcionesentrelineas' :  _def_evitarecepcionesentrelineas,
  '_def_evitaserdesbordado' :  _def_evitaserdesbordado,
  '_def_interceptaciondetiro' :  _def_interceptaciondetiro,
  '_def_mantenerlalineadefensiva' :  _def_mantenerlalineadefensiva,
  '_def_marcajeproximoaoponentedirecto' :
  _def_marcajeproximoaoponentedirecto,
  '_def_ocupaespaciosdecompanerossuperados' :
  _def_ocupaespaciosdecompanerossuperados,
  '_def_perfilamientos' :  _def_perfilamientos,
  '_def_permiteelgiro' :  _def_permiteelgiro,
  '_def_presiontrasperdida' :  _def_presiontrasperdida,
  '_def_resolucionanteparedesrivales' :
  _def_resolucionanteparedesrivales,
  '_def_sabecuidarsuespalda' :  _def_sabecuidarsuespalda,
  '_def_vigilayreferenciaalrival_enfaseofensiva' :
  _def_vigilayreferenciaalrival_enfaseofensiva,
  '_def_vigilanciassobrelateralrival' :
  _def_vigilanciassobrelateralrival,
  '_def_blocaje' :  _def_blocaje,
  '_def_juegoaereolateral' :  _def_juegoaereolateral,
  '_def_juegoaereofrontal' :  _def_juegoaereofrontal,
  '_def_habilidadenel1vs1' :  _def_habilidadenel1vs1,
  '_def_despeje' :  _def_despeje,
  '_def_anticipacion_intuicion' :  _def_anticipacion_intuicion,
  '_def_coberturadelineadefensiva' :  _def_coberturadelineadefensiva,
  '_def_abps' :  _def_abps,
  '_def_penaltis' :  _def_penaltis,
  'nombre' : BBDDService().getUserScout().name,
        'email' : BBDDService().getUserScout().email,
      };


  String get id {
    return _temporada==2020-2021?
     (_jugador + _posicion).toUpperCase()
        .replaceAll(" ", "")
        .replaceAll("É", "E")
        .replaceAll("Í", "I")
        .replaceAll("Ó", "O")
        .replaceAll("Ú", "U")
        .replaceAll("Á", "A")
        .replaceAll(".", "")
        .replaceAll("n", "N"):
    (_jugador + _equipo).toUpperCase()
        .replaceAll(" ", "")
        .replaceAll("É", "E")
        .replaceAll("Í", "I")
        .replaceAll("Ó", "O")
        .replaceAll("Ú", "U")
        .replaceAll("Á", "A")
        .replaceAll(".", "")
        .replaceAll("n", "N");
    ;
  }



  set id(String value) {
    this._id = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }


  int puntacionNivel(String nivelAux){
    if (nivelAux == "Superlativo") return 6;//0,176,80
    if (nivelAux == "Superior") return 5;//172,243,13
    if (nivelAux == "Destacado") return 4;//Colors.blue;//245,234,11
    if (nivelAux == "Intermedio") return 3;//Colors.yellow;//246,128,10
    if (nivelAux == "Dudoso") return 2;//Colors.orange;//248,25,8
    if (nivelAux == "Discreto") return 1;//Colors.red[900];//193,20,7
    if (nivelAux == "N/A") return 0;//Colors.red[900];//193,20,7
    return -1;//Colors.red[900];//193,20,7
  }

  Color getColor() {
    List<int> niveles=List();
    niveles.add(puntacionNivel(_nivel));
    niveles.add(puntacionNivel(_nivel2));
    niveles.add(puntacionNivel(_nivel3));
    niveles.add(puntacionNivel(_nivel4));
    niveles.sort();
    int nivelColor=niveles.last;
    if (nivelColor == 6) return Color.fromRGBO(0, 176, 80, 1);//0,176,80
    if (nivelColor == 5) return Color.fromRGBO(172, 243, 13, 1);;//172,243,13
    if (nivelColor == 4) return Color.fromRGBO(245, 234, 11, 1);//Colors.blue;//245,234,11
    if (nivelColor == 3) return Color.fromRGBO(246, 128, 10, 1);//Colors.yellow;//246,128,10
    if (nivelColor == 2) return Color.fromRGBO(248, 25, 8, 1);//Colors.orange;//248,25,8
    if (nivelColor == 1) return Color.fromRGBO(193, 20, 7, 1);//Colors.red[900];//193,20,7
    if (nivelColor == 0) return Color.fromRGBO(189, 243, 249, 1);//Colors.red[900];//193,20,7
    if (nivelColor == -1) return  Colors.grey;;//Colors.red[900];//193,20,7

    return Colors.grey;//Colors.grey;//189,243,249
  }

  static Color nivelColor(String nivelAux) {
    if (nivelAux == "Superlativo") return Color.fromRGBO(0, 176, 80, 1);//0,176,80
    if (nivelAux == "Superior") return Color.fromRGBO(172, 243, 13, 1);;//172,243,13
    if (nivelAux == "Destacado") return Color.fromRGBO(245, 234, 11, 1);//Colors.blue;//245,234,11
    if (nivelAux == "Intermedio") return Color.fromRGBO(246, 128, 10, 1);//Colors.yellow;//246,128,10
    if (nivelAux == "Dudoso") return Color.fromRGBO(248, 25, 8, 1);//Colors.orange;//248,25,8
    if (nivelAux == "Discreto") return Color.fromRGBO(193, 20, 7, 1);//Colors.red[900];//193,20,7
    if (nivelAux == "N/A") return Color.fromRGBO(189, 243, 249, 1);//Colors.red[900];//193,20,7

    return Colors.grey;//Colors.grey;//189,243,249
  }


  Map<String, dynamic> toGsheets() {
    DateTime today = new DateTime.now();
    String dateSlug = "${today.year.toString()}-${today.month.toString()
        .padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    return {
      "_id": _id,
      "_jugador": _jugador,
      "_equipo": _equipo,
      "_temporada": _temporada,
      "_categoria": _categoria,
      "_dorsal":_dorsal,
      "_lateral": _lateral,
      "_posicion": _posicion,
      "_posicion2": _posicionalternativa,
      "_posicionalternativa":_posicionalternativa,
      "_pais": _pais,
      "_fechaNacimiento": _fechaNacimiento,
      "_peso": _peso,
      "_altura": _altura,
      "_valor": _valor,
      "_paisNacimiento": _paisNacimiento,
      "_ccaa":_ccaa,
      "_nacionalidad":_nacionalidad,
      "_contrato": _contrato,
      "_fechaContrato":_fechaContrato,
      "_veredicto": _veredicto,
      "_prestamo": _prestamo,
      "_nivel": _nivel,
      "_nivel2": _nivel2,
      "_nivel3": _nivel3,
      "_nivel4": _nivel4,
      "_tipo": _tipo,
      "_observaciones_1": _observaciones_1 == null ? "" : _observaciones_1,
      "_ofe_niveltecnico": _ofe_niveltecnico,
      "_ofe_profundidad": _ofe_profundidad,
      "_ofe_capacidaddegenerarbuenoscentrosalarea": _ofe_capacidaddegenerarbuenoscentrosalarea,
      "_ofe_capacidaddeasociacion": _ofe_capacidaddeasociacion,
      "_ofe_desborde": _ofe_desborde,
      "_ofe_superioridadpordentro": _ofe_superioridadpordentro,
      "_ofe_finalizacion": _ofe_finalizacion,
      "_ofe_saquedebanda_longitud": _ofe_saquedebanda_longitud,
      "_ofe_lanzadordeabps": _ofe_lanzadordeabps,
      "_ofe_salidadebalon": _ofe_salidadebalon,
      "_ofe_paselargo_medio": _ofe_paselargo_medio,
      "_ofe_cambiosdeorientacion": _ofe_cambiosdeorientacion,
      "_ofe_batelineasconpaseinterior": _ofe_batelineasconpaseinterior,
      "_ofe_conduccionparadividir": _ofe_conduccionparadividir,
      "_ofe_primerpasetrasrecuperacion": _ofe_primerpasetrasrecuperacion,
      "_ofe_intervieneenabps": _ofe_intervieneenabps,
      "_ofe_velocidadeneljuego": _ofe_velocidadeneljuego,
      "_ofe_incorporacionazonasderemate": _ofe_incorporacionazonasderemate,
      "_ofe_amplitud": _ofe_amplitud,
      "_ofe_desmarquesdeapoyo": _ofe_desmarquesdeapoyo,
      "_ofe_desmarquesderuptura": _ofe_desmarquesderuptura,
      "_ofe_capacidaddegenerarbuenoscentroslateralesalarea": _ofe_capacidaddegenerarbuenoscentroslateralesalarea,
      "_ofe_habilidad1vs1": _ofe_habilidad1vs1,
      "_ofe_realizaciondelultimopase": _ofe_realizaciondelultimopase,
      "_ofe_goleador": _ofe_goleador,
      "_ofe_explotaciondeespacios": _ofe_explotaciondeespacios,
      "_ofe_duelosaereos": _ofe_duelosaereos,
      "_ofe_desbordeporvelocidad": _ofe_desbordeporvelocidad,
      "_ofe_dominiode2vs1_pared": _ofe_dominiode2vs1_pared,
      "_ofe_ambidextro": _ofe_ambidextro,
      "_ofe_juegodecara": _ofe_juegodecara,
      "_ofe_protecciondelbalon": _ofe_protecciondelbalon,
      "_ofe_caidasabanda": _ofe_caidasabanda,
      "_ofe_prolongacionesaereas": _ofe_prolongacionesaereas,
      "_ofe_dominiodelarea": _ofe_dominiodelarea,
      "_ofe_llegadaaposicionesderemate": _ofe_llegadaaposicionesderemate,
      "_ofe_juegoesespacioreducido": _ofe_juegoesespacioreducido,
      "_ofe_definidor_anteelportero": _ofe_definidor_anteelportero,
      "_ofe_rematador_finalizador": _ofe_rematador_finalizador,
      "_ofe_capacidadasociativa_apoyosalalineadefensiva": _ofe_capacidadasociativa_apoyosalalineadefensiva,
      "_ofe_desplazamientoenlargo": _ofe_desplazamientoenlargo,
      "_fis_velocidaddereaccion": _fis_velocidaddereaccion,
      "_fis_velocidaddedesplazamiento": _fis_velocidaddedesplazamiento,
      "_fis_agilidad": _fis_agilidad,
      "_fis_envergadura": _fis_envergadura,
      "_fis_fuerza_potencia": _fis_fuerza_potencia,
      "_fis_cuerpoacuerpo": _fis_cuerpoacuerpo,
      "_fis_capacidaddesalto": _fis_capacidaddesalto,
      "_fis_explosividad": _fis_explosividad,
      "_fis_potenciadesaltolateralyvertical": _fis_potenciadesaltolateralyvertical,
      "_fis_resistencia_idayvuelta": _fis_resistencia_idayvuelta,
      "_fis_cambioderitmo": _fis_cambioderitmo,
      "_psic_liderazgo": _psic_liderazgo,
      "_psic_comunicacion": _psic_comunicacion,
      "_psic_seguridad": _psic_seguridad,
      "_psic_tomadedecisiones": _psic_tomadedecisiones,
      "_psic_agresividad": _psic_agresividad,
      "_psic_polivalencia": _psic_polivalencia,
      "_psic_competitividad": _psic_competitividad,
      "_psic_agresividad_contundencia": _psic_agresividad_contundencia,
      "_psic_noasumeriesgosextremos": _psic_noasumeriesgosextremos,
      "_psic_entendimientodeljuego_inteligencia": _psic_entendimientodeljuego_inteligencia,
      "_psic_creatividad": _psic_creatividad,
      "_psic_confianza": _psic_confianza,
      "_psic_compromiso": _psic_compromiso,
      "_psic_valentia": _psic_valentia,
      "_psic_oportunismo": _psic_oportunismo,
      "_def_acoso_presionsobreeloponente": _def_acoso_presionsobreeloponente,
      "_def_actituddefensiva": _def_actituddefensiva,
      "_def_activaciondelosmecanismosdepresion": _def_activaciondelosmecanismosdepresion,
      "_def_anticipacion": _def_anticipacion,
      "_def_ayudaspermanentesallateral": _def_ayudaspermanentesallateral,
      "_def_capacidaddemarcaje": _def_capacidaddemarcaje,
      "_def_capacidadparataparcentros": _def_capacidadparataparcentros,
      "_def_cerrarelladodebil_basculaciones": _def_cerrarelladodebil_basculaciones,
      "_def_cierralineasdepase": _def_cierralineasdepase,
      "_def_coberturadecentrales": _def_coberturadecentrales,
      "_def_coberturas": _def_coberturas,
      "_def_colocacion": _def_colocacion,
      "_def_comportamientofueradezona": _def_comportamientofueradezona,
      "_def_correctabasculacion": _def_correctabasculacion,
      "_def_correctabasculacion_distanciadeintervalos": _def_correctabasculacion_distanciadeintervalos,
      "_def_correctoperfilamiento": _def_correctoperfilamiento,
      "_def_cruces": _def_cruces,
      "_def_destrezaantecentroslaterales": _def_destrezaantecentroslaterales,
      "_def_dificildesuperarenel1vs1": _def_dificildesuperarenel1vs1,
      "_def_dominiodelaszonasderechace": _def_dominiodelaszonasderechace,
      "_def_duelosaereos": _def_duelosaereos,
      "_def_duelosdefensivos": _def_duelosdefensivos,
      "_def_evitarecepcionesentrelineas": _def_evitarecepcionesentrelineas,
      "_def_evitaserdesbordado": _def_evitaserdesbordado,
      "_def_interceptaciondetiro": _def_interceptaciondetiro,
      "_def_mantenerlalineadefensiva": _def_mantenerlalineadefensiva,
      "_def_marcajeproximoaoponentedirecto": _def_marcajeproximoaoponentedirecto,
      "_def_ocupaespaciosdecompanerossuperados": _def_ocupaespaciosdecompanerossuperados,
      "_def_perfilamientos": _def_perfilamientos,
      "_def_permiteelgiro": _def_permiteelgiro,
      "_def_presiontrasperdida": _def_presiontrasperdida,
      "_def_resolucionanteparedesrivales": _def_resolucionanteparedesrivales,
      "_def_sabecuidarsuespalda": _def_sabecuidarsuespalda,
      "_def_vigilayreferenciaalrival_enfaseofensiva": _def_vigilayreferenciaalrival_enfaseofensiva,
      "_def_vigilanciassobrelateralrival": _def_vigilanciassobrelateralrival,
      "_def_blocaje": _def_blocaje,
      "_def_juegoaereolateral": _def_juegoaereolateral,
      "_def_juegoaereofrontal": _def_juegoaereofrontal,
      "_def_habilidadenel1vs1": _def_habilidadenel1vs1,
      "_def_despeje": _def_despeje,
      "_def_anticipacion_intuicion": _def_anticipacion_intuicion,
      "_def_coberturadelineadefensiva": _def_coberturadelineadefensiva,
      "_def_abps": _def_abps,
      "_def_penaltis": _def_penaltis,

      "nombre": BBDDService()
          .getUserScout()
          .name,
      "email": BBDDService()
          .getUserScout()
          .email,
      "fecha": dateSlug
    };
  }


  String get ccaa => _ccaa;

  set ccaa(String value) {
    _ccaa = value;
  }

  String get veredicto => _veredicto;

  set veredicto(String value) {
    _veredicto = value;
  }

  String get contrato => _contrato;

  set contrato(String value) {
    _contrato = value;
  }

  int get dorsal => _dorsal;

  set dorsal(int value) {
    _dorsal = value;
  }

  bool get def_ocupaespaciosdecompanerossuperados =>
      _def_ocupaespaciosdecompanerossuperados;

  set def_ocupaespaciosdecompanerossuperados(bool value) {
    _def_ocupaespaciosdecompanerossuperados = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  bool get fis_velocidaddereaccion => _fis_velocidaddereaccion;

  set fis_velocidaddereaccion(bool value) {
    _fis_velocidaddereaccion = value;
  }

  bool get fis_velocidaddedesplazamiento => _fis_velocidaddedesplazamiento;

  set fis_velocidaddedesplazamiento(bool value) {
    _fis_velocidaddedesplazamiento = value;
  }

  bool get fis_fuerza_potencia => _fis_fuerza_potencia;

  set fis_fuerza_potencia(bool value) {
    _fis_fuerza_potencia = value;
  }

  bool get fis_explosividad => _fis_explosividad;

  set fis_explosividad(bool value) {
    _fis_explosividad = value;
  }

  String get fis_envergadura => _fis_envergadura;

  set fis_envergadura(String value) {
    _fis_envergadura = value;
  }

  bool get fis_cuerpoacuerpo => _fis_cuerpoacuerpo;

  set fis_cuerpoacuerpo(bool value) {
    _fis_cuerpoacuerpo = value;
  }


  String get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(String value) {
    _fechaNacimiento = value;
  }

  bool get fis_capacidaddesalto => _fis_capacidaddesalto;

  set fis_capacidaddesalto(bool value) {
    _fis_capacidaddesalto = value;
  }


  bool get fis_agilidad => _fis_agilidad;

  set fis_agilidad(bool value) {
    _fis_agilidad = value;
  }

  String get jugador => _jugador;

  set jugador(String value) {
    _jugador = value;
  }

  String get equipo => _equipo;

  set equipo(String value) {
    _equipo = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get posicion => _posicion;

  set posicion(String value) {
    _posicion = value;
  }

  String get posicion2 => _posicion2;

  set posicion2(String value) {
    _posicion2 = value;
  }

  String get imagen => _imagen;

  set imagen(String value) {
    _imagen = value;
  }

  String get nivel => _nivel;

  set nivel(String value) {
    _nivel = value;
  }


  String get nivel2 => _nivel2;

  set nivel2(String value) {
    _nivel2 = value;
  }

  String get observaciones_1 => _observaciones_1;

  set observaciones_1(String value) {
    _observaciones_1 = value;
  }

  String get observaciones_2 => _observaciones_2;

  set observaciones_2(String value) {
    _observaciones_2 = value;
  }

  String get observaciones_3 => _observaciones_3;

  set observaciones_3(String value) {
    _observaciones_3 = value;
  }

  String get observaciones_4 => _observaciones_4;

  set observaciones_4(String value) {
    _observaciones_4 = value;
  }


  bool get psic_liderazgo => _psic_liderazgo;

  set psic_liderazgo(bool value) {
    _psic_liderazgo = value;
  }

  bool get def_acoso_presionsobreeloponente =>
      _def_acoso_presionsobreeloponente;

  set def_acoso_presionsobreeloponente(bool value) {
    _def_acoso_presionsobreeloponente = value;
  }

  bool get def_actituddefensiva => _def_actituddefensiva;

  set def_actituddefensiva(bool value) {
    _def_actituddefensiva = value;
  }

  bool get def_activaciondelosmecanismosdepresion =>
      _def_activaciondelosmecanismosdepresion;

  set def_activaciondelosmecanismosdepresion(bool value) {
    _def_activaciondelosmecanismosdepresion = value;
  }

  bool get def_anticipacion => _def_anticipacion;

  set def_anticipacion(bool value) {
    _def_anticipacion = value;
  }

  bool get def_ayudaspermanentesallateral => _def_ayudaspermanentesallateral;

  set def_ayudaspermanentesallateral(bool value) {
    _def_ayudaspermanentesallateral = value;
  }

  bool get def_capacidaddemarcaje => _def_capacidaddemarcaje;

  set def_capacidaddemarcaje(bool value) {
    _def_capacidaddemarcaje = value;
  }

  bool get def_capacidadparataparcentros => _def_capacidadparataparcentros;

  set def_capacidadparataparcentros(bool value) {
    _def_capacidadparataparcentros = value;
  }

  bool get def_cerrarelladodebil_basculaciones =>
      _def_cerrarelladodebil_basculaciones;

  set def_cerrarelladodebil_basculaciones(bool value) {
    _def_cerrarelladodebil_basculaciones = value;
  }

  bool get def_cierralineasdepase => _def_cierralineasdepase;

  set def_cierralineasdepase(bool value) {
    _def_cierralineasdepase = value;
  }

  bool get def_coberturadecentrales => _def_coberturadecentrales;

  set def_coberturadecentrales(bool value) {
    _def_coberturadecentrales = value;
  }

  bool get def_coberturas => _def_coberturas;

  set def_coberturas(bool value) {
    _def_coberturas = value;
  }

  bool get def_colocacion => _def_colocacion;

  set def_colocacion(bool value) {
    _def_colocacion = value;
  }

  bool get def_comportamientofueradezona => _def_comportamientofueradezona;

  set def_comportamientofueradezona(bool value) {
    _def_comportamientofueradezona = value;
  }

  bool get def_correctabasculacion => _def_correctabasculacion;

  set def_correctabasculacion(bool value) {
    _def_correctabasculacion = value;
  }

  bool get def_correctabasculacion_distanciadeintervalos =>
      _def_correctabasculacion_distanciadeintervalos;

  set def_correctabasculacion_distanciadeintervalos(bool value) {
    _def_correctabasculacion_distanciadeintervalos = value;
  }

  bool get def_correctoperfilamiento => _def_correctoperfilamiento;

  set def_correctoperfilamiento(bool value) {
    _def_correctoperfilamiento = value;
  }

  bool get def_cruces => _def_cruces;

  set def_cruces(bool value) {
    _def_cruces = value;
  }

  bool get def_destrezaantecentroslaterales =>
      _def_destrezaantecentroslaterales;

  set def_destrezaantecentroslaterales(bool value) {
    _def_destrezaantecentroslaterales = value;
  }

  bool get def_dificildesuperarenel1vs1 => _def_dificildesuperarenel1vs1;

  set def_dificildesuperarenel1vs1(bool value) {
    _def_dificildesuperarenel1vs1 = value;
  }

  bool get def_dominiodelaszonasderechace => _def_dominiodelaszonasderechace;

  set def_dominiodelaszonasderechace(bool value) {
    _def_dominiodelaszonasderechace = value;
  }

  bool get def_duelosaereos => _def_duelosaereos;

  set def_duelosaereos(bool value) {
    _def_duelosaereos = value;
  }

  bool get def_duelosdefensivos => _def_duelosdefensivos;

  set def_duelosdefensivos(bool value) {
    _def_duelosdefensivos = value;
  }

  bool get def_evitarecepcionesentrelineas => _def_evitarecepcionesentrelineas;

  set def_evitarecepcionesentrelineas(bool value) {
    _def_evitarecepcionesentrelineas = value;
  }

  bool get def_evitaserdesbordado => _def_evitaserdesbordado;

  set def_evitaserdesbordado(bool value) {
    _def_evitaserdesbordado = value;
  }

  bool get def_interceptaciondetiro => _def_interceptaciondetiro;

  set def_interceptaciondetiro(bool value) {
    _def_interceptaciondetiro = value;
  }

  bool get def_mantenerlalineadefensiva => _def_mantenerlalineadefensiva;

  set def_mantenerlalineadefensiva(bool value) {
    _def_mantenerlalineadefensiva = value;
  }

  bool get def_marcajeproximoaoponentedirecto =>
      _def_marcajeproximoaoponentedirecto;

  set def_marcajeproximoaoponentedirecto(bool value) {
    _def_marcajeproximoaoponentedirecto = value;
  }


  bool get def_perfilamientos => _def_perfilamientos;

  set def_perfilamientos(bool value) {
    _def_perfilamientos = value;
  }

  bool get def_permiteelgiro => _def_permiteelgiro;

  set def_permiteelgiro(bool value) {
    _def_permiteelgiro = value;
  }

  bool get def_presiontrasperdida => _def_presiontrasperdida;

  set def_presiontrasperdida(bool value) {
    _def_presiontrasperdida = value;
  }

  bool get def_resolucionanteparedesrivales =>
      _def_resolucionanteparedesrivales;

  set def_resolucionanteparedesrivales(bool value) {
    _def_resolucionanteparedesrivales = value;
  }

  bool get fis_potenciadesaltolateralyvertical =>
      _fis_potenciadesaltolateralyvertical;

  set fis_potenciadesaltolateralyvertical(bool value) {
    _fis_potenciadesaltolateralyvertical = value;
  }

  bool get def_sabecuidarsuespalda => _def_sabecuidarsuespalda;

  set def_sabecuidarsuespalda(bool value) {
    _def_sabecuidarsuespalda = value;
  }

  bool get def_vigilayreferenciaalrival_enfaseofensiva =>
      _def_vigilayreferenciaalrival_enfaseofensiva;

  set def_vigilayreferenciaalrival_enfaseofensiva(bool value) {
    _def_vigilayreferenciaalrival_enfaseofensiva = value;
  }

  bool get def_vigilanciassobrelateralrival =>
      _def_vigilanciassobrelateralrival;

  set def_vigilanciassobrelateralrival(bool value) {
    _def_vigilanciassobrelateralrival = value;
  }

  bool get ofe_niveltecnico => _ofe_niveltecnico;

  set ofe_niveltecnico(bool value) {
    _ofe_niveltecnico = value;
  }

  bool get ofe_profundidad => _ofe_profundidad;

  set ofe_profundidad(bool value) {
    _ofe_profundidad = value;
  }

  bool get ofe_capacidaddegenerarbuenoscentrosalarea =>
      _ofe_capacidaddegenerarbuenoscentrosalarea;

  set ofe_capacidaddegenerarbuenoscentrosalarea(bool value) {
    _ofe_capacidaddegenerarbuenoscentrosalarea = value;
  }

  bool get ofe_capacidaddeasociacion => _ofe_capacidaddeasociacion;

  set ofe_capacidaddeasociacion(bool value) {
    _ofe_capacidaddeasociacion = value;
  }

  bool get ofe_desborde => _ofe_desborde;

  set ofe_desborde(bool value) {
    _ofe_desborde = value;
  }

  bool get ofe_superioridadpordentro => _ofe_superioridadpordentro;

  set ofe_superioridadpordentro(bool value) {
    _ofe_superioridadpordentro = value;
  }

  bool get ofe_finalizacion => _ofe_finalizacion;

  set ofe_finalizacion(bool value) {
    _ofe_finalizacion = value;
  }

  bool get ofe_saquedebanda_longitud => _ofe_saquedebanda_longitud;

  set ofe_saquedebanda_longitud(bool value) {
    _ofe_saquedebanda_longitud = value;
  }

  bool get ofe_lanzadordeabps => _ofe_lanzadordeabps;

  set ofe_lanzadordeabps(bool value) {
    _ofe_lanzadordeabps = value;
  }

  bool get ofe_salidadebalon => _ofe_salidadebalon;

  set ofe_salidadebalon(bool value) {
    _ofe_salidadebalon = value;
  }

  bool get ofe_paselargo_medio => _ofe_paselargo_medio;

  set ofe_paselargo_medio(bool value) {
    _ofe_paselargo_medio = value;
  }

  bool get ofe_cambiosdeorientacion => _ofe_cambiosdeorientacion;

  set ofe_cambiosdeorientacion(bool value) {
    _ofe_cambiosdeorientacion = value;
  }

  bool get ofe_batelineasconpaseinterior => _ofe_batelineasconpaseinterior;

  set ofe_batelineasconpaseinterior(bool value) {
    _ofe_batelineasconpaseinterior = value;
  }

  bool get ofe_conduccionparadividir => _ofe_conduccionparadividir;

  set ofe_conduccionparadividir(bool value) {
    _ofe_conduccionparadividir = value;
  }

  bool get ofe_primerpasetrasrecuperacion => _ofe_primerpasetrasrecuperacion;

  set ofe_primerpasetrasrecuperacion(bool value) {
    _ofe_primerpasetrasrecuperacion = value;
  }

  bool get ofe_intervieneenabps => _ofe_intervieneenabps;

  set ofe_intervieneenabps(bool value) {
    _ofe_intervieneenabps = value;
  }

  bool get ofe_velocidadeneljuego => _ofe_velocidadeneljuego;

  set ofe_velocidadeneljuego(bool value) {
    _ofe_velocidadeneljuego = value;
  }

  bool get ofe_incorporacionazonasderemate => _ofe_incorporacionazonasderemate;

  set ofe_incorporacionazonasderemate(bool value) {
    _ofe_incorporacionazonasderemate = value;
  }

  bool get ofe_amplitud => _ofe_amplitud;

  set ofe_amplitud(bool value) {
    _ofe_amplitud = value;
  }

  bool get ofe_desmarquesdeapoyo => _ofe_desmarquesdeapoyo;

  set ofe_desmarquesdeapoyo(bool value) {
    _ofe_desmarquesdeapoyo = value;
  }

  bool get ofe_desmarquesderuptura => _ofe_desmarquesderuptura;

  set ofe_desmarquesderuptura(bool value) {
    _ofe_desmarquesderuptura = value;
  }

  bool get ofe_capacidaddegenerarbuenoscentroslateralesalarea =>
      _ofe_capacidaddegenerarbuenoscentroslateralesalarea;

  set ofe_capacidaddegenerarbuenoscentroslateralesalarea(bool value) {
    _ofe_capacidaddegenerarbuenoscentroslateralesalarea = value;
  }

  bool get ofe_habilidad1vs1 => _ofe_habilidad1vs1;

  set ofe_habilidad1vs1(bool value) {
    _ofe_habilidad1vs1 = value;
  }

  bool get ofe_realizaciondelultimopase => _ofe_realizaciondelultimopase;

  set ofe_realizaciondelultimopase(bool value) {
    _ofe_realizaciondelultimopase = value;
  }

  bool get ofe_goleador => _ofe_goleador;

  set ofe_goleador(bool value) {
    _ofe_goleador = value;
  }

  bool get ofe_explotaciondeespacios => _ofe_explotaciondeespacios;

  set ofe_explotaciondeespacios(bool value) {
    _ofe_explotaciondeespacios = value;
  }

  bool get ofe_duelosaereos => _ofe_duelosaereos;

  set ofe_duelosaereos(bool value) {
    _ofe_duelosaereos = value;
  }

  bool get ofe_desbordeporvelocidad => _ofe_desbordeporvelocidad;

  set ofe_desbordeporvelocidad(bool value) {
    _ofe_desbordeporvelocidad = value;
  }

  bool get ofe_dominiode2vs1_pared => _ofe_dominiode2vs1_pared;

  set ofe_dominiode2vs1_pared(bool value) {
    _ofe_dominiode2vs1_pared = value;
  }

  bool get ofe_ambidextro => _ofe_ambidextro;

  set ofe_ambidextro(bool value) {
    _ofe_ambidextro = value;
  }

  bool get ofe_juegodecara => _ofe_juegodecara;

  set ofe_juegodecara(bool value) {
    _ofe_juegodecara = value;
  }

  bool get ofe_protecciondelbalon => _ofe_protecciondelbalon;

  set ofe_protecciondelbalon(bool value) {
    _ofe_protecciondelbalon = value;
  }

  bool get ofe_caidasabanda => _ofe_caidasabanda;

  set ofe_caidasabanda(bool value) {
    _ofe_caidasabanda = value;
  }

  bool get ofe_prolongacionesaereas => _ofe_prolongacionesaereas;

  set ofe_prolongacionesaereas(bool value) {
    _ofe_prolongacionesaereas = value;
  }

  bool get ofe_dominiodelarea => _ofe_dominiodelarea;

  set ofe_dominiodelarea(bool value) {
    _ofe_dominiodelarea = value;
  }

  bool get ofe_llegadaaposicionesderemate => _ofe_llegadaaposicionesderemate;

  set ofe_llegadaaposicionesderemate(bool value) {
    _ofe_llegadaaposicionesderemate = value;
  }

  bool get ofe_juegoesespacioreducido => _ofe_juegoesespacioreducido;

  set ofe_juegoesespacioreducido(bool value) {
    _ofe_juegoesespacioreducido = value;
  }

  bool get ofe_definidor_anteelportero => _ofe_definidor_anteelportero;

  set ofe_definidor_anteelportero(bool value) {
    _ofe_definidor_anteelportero = value;
  }

  bool get ofe_rematador_finalizador => _ofe_rematador_finalizador;

  set ofe_rematador_finalizador(bool value) {
    _ofe_rematador_finalizador = value;
  }


  bool get def_blocaje => _def_blocaje;

  set def_blocaje(bool value) {
    _def_blocaje = value;
  }


  static bool dameElValor(String caracteristicas, Jugador jugador) {

  //  print("dameelvalor:${caracteristicas}");
    if (caracteristicas=="Nivel técnico") return jugador._ofe_niveltecnico;
    if (caracteristicas=="Profundidad") return jugador._ofe_profundidad;
    if (caracteristicas=="Capacidad de generar buenos centros al área") return jugador._ofe_capacidaddegenerarbuenoscentrosalarea;
    if (caracteristicas=="Capacidad de asociación") return jugador._ofe_capacidaddeasociacion;
    if (caracteristicas=="Desborde") return jugador._ofe_desborde;
    if (caracteristicas=="Superioridad por dentro") return jugador._ofe_superioridadpordentro;
    if (caracteristicas=="Finalización") return jugador._ofe_finalizacion;
    if (caracteristicas=="Saque de banda (longitud)") return jugador._ofe_saquedebanda_longitud;
    if (caracteristicas=="Lanzador de ABP´s") return jugador._ofe_lanzadordeabps;
    if (caracteristicas=="Salida de balón") return jugador._ofe_salidadebalon;
    if (caracteristicas=="Pase largo/medio") return jugador._ofe_paselargo_medio;
    if (caracteristicas=="Cambios de orientación") return jugador._ofe_cambiosdeorientacion;
    if (caracteristicas=="Bate líneas con pase interior") return jugador._ofe_batelineasconpaseinterior;
    if (caracteristicas=="Conducción para dividir") return jugador._ofe_conduccionparadividir;
    if (caracteristicas=="Primer pase tras recuperación") return jugador._ofe_primerpasetrasrecuperacion;
    if (caracteristicas=="Interviene en ABP´s") return jugador._ofe_intervieneenabps;
    if (caracteristicas=="Velocidad en el juego") return jugador._ofe_velocidadeneljuego;
    if (caracteristicas=="Incorporación a zonas de remate") return jugador._ofe_incorporacionazonasderemate;
    if (caracteristicas=="Amplitud") return jugador._ofe_amplitud;
    if (caracteristicas=="Desmarques de apoyo") return jugador._ofe_desmarquesdeapoyo;
    if (caracteristicas=="Desmarques de ruptura") return jugador._ofe_desmarquesderuptura;
    if (caracteristicas=="Capacidad de generar buenos centros laterales al área") return jugador._ofe_capacidaddegenerarbuenoscentroslateralesalarea;
    if (caracteristicas=="Habilidad 1 vs 1") return jugador._ofe_habilidad1vs1;
    if (caracteristicas=="Realización del último pase") return jugador._ofe_realizaciondelultimopase;
    if (caracteristicas=="Goleador") return jugador._ofe_goleador;
    if (caracteristicas=="Explotación de espacios") return jugador._ofe_explotaciondeespacios;
    if (caracteristicas=="Duelos aéreos") return jugador._ofe_duelosaereos;
    if (caracteristicas=="Desborde por velocidad") return jugador._ofe_desbordeporvelocidad;
    if (caracteristicas=="Dominio de 2vs1 (pared)") return jugador._ofe_dominiode2vs1_pared;
    if (caracteristicas=="Ambidextro") return jugador._ofe_ambidextro;
    if (caracteristicas=="Juego de cara") return jugador._ofe_juegodecara;
    if (caracteristicas=="Protección del balón") return jugador._ofe_protecciondelbalon;
    if (caracteristicas=="Caídas a banda") return jugador._ofe_caidasabanda;
    if (caracteristicas=="Prolongaciones aéreas") return jugador._ofe_prolongacionesaereas;
    if (caracteristicas=="Dominio del área") return jugador._ofe_dominiodelarea;
    if (caracteristicas=="Llegada a posiciones de remate") return jugador._ofe_llegadaaposicionesderemate;
    if (caracteristicas=="Juego en espacio reducido") return jugador._ofe_juegoesespacioreducido;
    if (caracteristicas=="Definidor (ante el portero)") return jugador._ofe_definidor_anteelportero;
    if (caracteristicas=="Rematador/Finalizador") return jugador._ofe_rematador_finalizador;
    if (caracteristicas=="Capacidad asociativa, apoyos a la línea defensiva") return jugador._ofe_capacidadasociativa_apoyosalalineadefensiva;
    if (caracteristicas=="Desplazamiento en largo") return jugador._ofe_desplazamientoenlargo;
    if (caracteristicas=="Velocidad de reacción") return jugador._fis_velocidaddereaccion;
    if (caracteristicas=="Velocidad de desplazamiento") return jugador._fis_velocidaddedesplazamiento;
    if (caracteristicas=="Agilidad") return jugador._fis_agilidad;
    if (caracteristicas=="Fuerza/Potencia") return jugador._fis_fuerza_potencia;
    if (caracteristicas=="Cuerpo a cuerpo") return jugador._fis_cuerpoacuerpo;
    if (caracteristicas=="Capacidad de salto") return jugador._fis_capacidaddesalto;
    if (caracteristicas=="Explosividad") return jugador._fis_explosividad;
    if (caracteristicas=="Potencia de salto lateral y vertical") return jugador._fis_potenciadesaltolateralyvertical;
    if (caracteristicas=="Resistencia (ida y vuelta)") return jugador._fis_resistencia_idayvuelta;
    if (caracteristicas=="Cambio de ritmo") return jugador._fis_cambioderitmo;
    if (caracteristicas=="Liderazgo") return jugador._psic_liderazgo;
    if (caracteristicas=="Comunicación") return jugador._psic_comunicacion;
    if (caracteristicas=="Seguridad") return jugador._psic_seguridad;
    if (caracteristicas=="Toma de decisiones") return jugador._psic_tomadedecisiones;
    if (caracteristicas=="Agresividad") return jugador._psic_agresividad;
    if (caracteristicas=="Polivalencia") return jugador._psic_polivalencia;
    if (caracteristicas=="Competitividad") return jugador._psic_competitividad;
    if (caracteristicas=="Agresividad/Contundencia") return jugador._psic_agresividad_contundencia;
    if (caracteristicas=="No asume riesgos extremos") return jugador._psic_noasumeriesgosextremos;
    if (caracteristicas=="Entendimiento del juego (inteligencia)") return jugador._psic_entendimientodeljuego_inteligencia;
    if (caracteristicas=="Creatividad") return jugador._psic_creatividad;
    if (caracteristicas=="Confianza") return jugador._psic_confianza;
    if (caracteristicas=="Compromiso") return jugador._psic_compromiso;
    if (caracteristicas=="Valentía") return jugador._psic_valentia;
    if (caracteristicas=="Oportunismo") return jugador._psic_oportunismo;
    if (caracteristicas=="Acoso-presión sobre el oponente") return jugador._def_acoso_presionsobreeloponente;
    if (caracteristicas=="Actitud defensiva") return jugador._def_actituddefensiva;
    if (caracteristicas=="Activación de los mecanismos de presión") return jugador._def_activaciondelosmecanismosdepresion;
    if (caracteristicas=="Anticipación") return jugador._def_anticipacion;
    if (caracteristicas=="Ayudas permanentes al lateral") return jugador._def_ayudaspermanentesallateral;
    if (caracteristicas=="Capacidad de marcaje") return jugador._def_capacidaddemarcaje;
    if (caracteristicas=="Capacidad para tapar centros") return jugador._def_capacidadparataparcentros;
    if (caracteristicas=="Cerrar el lado débil (basculaciones)") return jugador._def_cerrarelladodebil_basculaciones;
    if (caracteristicas=="Cierra líneas de pase") return jugador._def_cierralineasdepase;
    if (caracteristicas=="Cobertura de centrales") return jugador._def_coberturadecentrales;
    if (caracteristicas=="Coberturas") return jugador._def_coberturas;
    if (caracteristicas=="Colocación") return jugador._def_colocacion;
    if (caracteristicas=="Comportamiento fuera de zona") return jugador._def_comportamientofueradezona;
    if (caracteristicas=="Correcta basculación") return jugador._def_correctabasculacion;
    if (caracteristicas=="Correcta basculación (distancia de intervalos)") return jugador._def_correctabasculacion_distanciadeintervalos;
    if (caracteristicas=="Correcto perfilamiento") return jugador._def_correctoperfilamiento;
    if (caracteristicas=="Cruces") return jugador._def_cruces;
    if (caracteristicas=="Destreza ante centros laterales") return jugador._def_destrezaantecentroslaterales;
    if (caracteristicas=="Difícil de superar en el 1 vs 1") return jugador._def_dificildesuperarenel1vs1;
    if (caracteristicas=="Dominio de las zonas de rechace") return jugador._def_dominiodelaszonasderechace;
    if (caracteristicas=="Duelos aéreos") return jugador._def_duelosaereos;
    if (caracteristicas=="Duelos defensivos") return jugador._def_duelosdefensivos;
    if (caracteristicas=="Evita recepciones entre líneas") return jugador._def_evitarecepcionesentrelineas;
    if (caracteristicas=="Evita ser desbordado") return jugador._def_evitaserdesbordado;
    if (caracteristicas=="Interceptación de tiro") return jugador._def_interceptaciondetiro;
    if (caracteristicas=="Mantener la línea defensiva") return jugador._def_mantenerlalineadefensiva;
    if (caracteristicas=="Marcaje próximo a oponente directo") return jugador._def_marcajeproximoaoponentedirecto;
    if (caracteristicas=="Ocupa espacios de compañeros superados") return jugador._def_ocupaespaciosdecompanerossuperados;
    if (caracteristicas=="Perfilamientos") return jugador._def_perfilamientos;
    if (caracteristicas=="Permite el giro") return jugador._def_permiteelgiro;
    if (caracteristicas=="Presión tras pérdida") return jugador._def_presiontrasperdida;
    if (caracteristicas=="Resolución ante paredes rivales") return jugador._def_resolucionanteparedesrivales;
    if (caracteristicas=="Sabe cuidar su espalda") return jugador._def_sabecuidarsuespalda;
    if (caracteristicas=="Vigila y referencia al rival (en fase ofensiva)") return jugador._def_vigilayreferenciaalrival_enfaseofensiva;
    if (caracteristicas=="Vigilancias sobre lateral rival") return jugador._def_vigilanciassobrelateralrival;
    if (caracteristicas=="Blocaje") return jugador._def_blocaje;
    if (caracteristicas=="Juego aéreo lateral") return jugador._def_juegoaereolateral;
    if (caracteristicas=="Juego aéreo frontal") return jugador._def_juegoaereofrontal;
    if (caracteristicas=="Habilidad en el 1 vs 1") return jugador._def_habilidadenel1vs1;
    if (caracteristicas=="Despeje") return jugador._def_despeje;
    if (caracteristicas=="Anticipación (intuición)") return jugador._def_anticipacion_intuicion;
    if (caracteristicas=="Cobertura de línea defensiva") return jugador._def_coberturadelineadefensiva;
    if (caracteristicas=="ABP´s") return jugador._def_abps;
    if (caracteristicas=="Penaltis") return jugador._def_penaltis;
  }

  static poneElValor(String caracteristicas, bool value, Jugador jugador) {
    if (caracteristicas=="Nivel técnico")  jugador._ofe_niveltecnico=value;
    if (caracteristicas=="Profundidad")  jugador._ofe_profundidad=value;
    if (caracteristicas=="Capacidad de generar buenos centros al área")  jugador._ofe_capacidaddegenerarbuenoscentrosalarea=value;
    if (caracteristicas=="Capacidad de asociación")  jugador._ofe_capacidaddeasociacion=value;
    if (caracteristicas=="Desborde")  jugador._ofe_desborde=value;
    if (caracteristicas=="Superioridad por dentro")  jugador._ofe_superioridadpordentro=value;
    if (caracteristicas=="Finalización")  jugador._ofe_finalizacion=value;
    if (caracteristicas=="Saque de banda (longitud)")  jugador._ofe_saquedebanda_longitud=value;
    if (caracteristicas=="Lanzador de ABP´s")  jugador._ofe_lanzadordeabps=value;
    if (caracteristicas=="Salida de balón")  jugador._ofe_salidadebalon=value;
    if (caracteristicas=="Pase largo/medio")  jugador._ofe_paselargo_medio=value;
    if (caracteristicas=="Cambios de orientación")  jugador._ofe_cambiosdeorientacion=value;
    if (caracteristicas=="Bate líneas con pase interior")  jugador._ofe_batelineasconpaseinterior=value;
    if (caracteristicas=="Conducción para dividir")  jugador._ofe_conduccionparadividir=value;
    if (caracteristicas=="Primer pase tras recuperación")  jugador._ofe_primerpasetrasrecuperacion=value;
    if (caracteristicas=="Interviene en ABP´s")  jugador._ofe_intervieneenabps=value;
    if (caracteristicas=="Velocidad en el juego")  jugador._ofe_velocidadeneljuego=value;
    if (caracteristicas=="Incorporación a zonas de remate")  jugador._ofe_incorporacionazonasderemate=value;
    if (caracteristicas=="Amplitud")  jugador._ofe_amplitud=value;
    if (caracteristicas=="Desmarques de apoyo")  jugador._ofe_desmarquesdeapoyo=value;
    if (caracteristicas=="Desmarques de ruptura")  jugador._ofe_desmarquesderuptura=value;
    if (caracteristicas=="Capacidad de generar buenos centros laterales al área")  jugador._ofe_capacidaddegenerarbuenoscentroslateralesalarea=value;
    if (caracteristicas=="Habilidad 1 vs 1")  jugador._ofe_habilidad1vs1=value;
    if (caracteristicas=="Realización del último pase")  jugador._ofe_realizaciondelultimopase=value;
    if (caracteristicas=="Goleador")  jugador._ofe_goleador=value;
    if (caracteristicas=="Explotación de espacios")  jugador._ofe_explotaciondeespacios=value;
    if (caracteristicas=="Duelos aéreos")  jugador._ofe_duelosaereos=value;
    if (caracteristicas=="Desborde por velocidad")  jugador._ofe_desbordeporvelocidad=value;
    if (caracteristicas=="Dominio de 2vs1 (pared)")  jugador._ofe_dominiode2vs1_pared=value;
    if (caracteristicas=="Ambidextro")  jugador._ofe_ambidextro=value;
    if (caracteristicas=="Juego de cara")  jugador._ofe_juegodecara=value;
    if (caracteristicas=="Protección del balón")  jugador._ofe_protecciondelbalon=value;
    if (caracteristicas=="Caídas a banda")  jugador._ofe_caidasabanda=value;
    if (caracteristicas=="Prolongaciones aéreas")  jugador._ofe_prolongacionesaereas=value;
    if (caracteristicas=="Dominio del área")  jugador._ofe_dominiodelarea=value;
    if (caracteristicas=="Llegada a posiciones de remate")  jugador._ofe_llegadaaposicionesderemate=value;
    if (caracteristicas=="Juego en espacio reducido")  jugador._ofe_juegoesespacioreducido=value;
    if (caracteristicas=="Definidor (ante el portero)")  jugador._ofe_definidor_anteelportero=value;
    if (caracteristicas=="Rematador/Finalizador")  jugador._ofe_rematador_finalizador=value;
    if (caracteristicas=="Capacidad asociativa, apoyos a la línea defensiva")  jugador._ofe_capacidadasociativa_apoyosalalineadefensiva=value;
    if (caracteristicas=="Desplazamiento en largo")  jugador._ofe_desplazamientoenlargo=value;
    if (caracteristicas=="Velocidad de reacción")  jugador._fis_velocidaddereaccion=value;
    if (caracteristicas=="Velocidad de desplazamiento")  jugador._fis_velocidaddedesplazamiento=value;
    if (caracteristicas=="Agilidad")  jugador._fis_agilidad=value;
    if (caracteristicas=="Fuerza/Potencia")  jugador._fis_fuerza_potencia=value;
    if (caracteristicas=="Cuerpo a cuerpo")  jugador._fis_cuerpoacuerpo=value;
    if (caracteristicas=="Capacidad de salto")  jugador._fis_capacidaddesalto=value;
    if (caracteristicas=="Explosividad")  jugador._fis_explosividad=value;
    if (caracteristicas=="Potencia de salto lateral y vertical")  jugador._fis_potenciadesaltolateralyvertical=value;
    if (caracteristicas=="Resistencia (ida y vuelta)")  jugador._fis_resistencia_idayvuelta=value;
    if (caracteristicas=="Cambio de ritmo")  jugador._fis_cambioderitmo=value;
    if (caracteristicas=="Liderazgo")  jugador._psic_liderazgo=value;
    if (caracteristicas=="Comunicación")  jugador._psic_comunicacion=value;
    if (caracteristicas=="Seguridad")  jugador._psic_seguridad=value;
    if (caracteristicas=="Toma de decisiones")  jugador._psic_tomadedecisiones=value;
    if (caracteristicas=="Agresividad")  jugador._psic_agresividad=value;
    if (caracteristicas=="Polivalencia")  jugador._psic_polivalencia=value;
    if (caracteristicas=="Competitividad")  jugador._psic_competitividad=value;
    if (caracteristicas=="Agresividad/Contundencia")  jugador._psic_agresividad_contundencia=value;
    if (caracteristicas=="No asume riesgos extremos")  jugador._psic_noasumeriesgosextremos=value;
    if (caracteristicas=="Entendimiento del juego (inteligencia)")  jugador._psic_entendimientodeljuego_inteligencia=value;
    if (caracteristicas=="Creatividad")  jugador._psic_creatividad=value;
    if (caracteristicas=="Confianza")  jugador._psic_confianza=value;
    if (caracteristicas=="Compromiso")  jugador._psic_compromiso=value;
    if (caracteristicas=="Valentía")  jugador._psic_valentia=value;
    if (caracteristicas=="Oportunismo")  jugador._psic_oportunismo=value;
    if (caracteristicas=="Acoso-presión sobre el oponente")  jugador._def_acoso_presionsobreeloponente=value;
    if (caracteristicas=="Actitud defensiva")  jugador._def_actituddefensiva=value;
    if (caracteristicas=="Activación de los mecanismos de presión")  jugador._def_activaciondelosmecanismosdepresion=value;
    if (caracteristicas=="Anticipación")  jugador._def_anticipacion=value;
    if (caracteristicas=="Ayudas permanentes al lateral")  jugador._def_ayudaspermanentesallateral=value;
    if (caracteristicas=="Capacidad de marcaje")  jugador._def_capacidaddemarcaje=value;
    if (caracteristicas=="Capacidad para tapar centros")  jugador._def_capacidadparataparcentros=value;
    if (caracteristicas=="Cerrar el lado débil (basculaciones)")  jugador._def_cerrarelladodebil_basculaciones=value;
    if (caracteristicas=="Cierra líneas de pase")  jugador._def_cierralineasdepase=value;
    if (caracteristicas=="Cobertura de centrales")  jugador._def_coberturadecentrales=value;
    if (caracteristicas=="Coberturas")  jugador._def_coberturas=value;
    if (caracteristicas=="Colocación")  jugador._def_colocacion=value;
    if (caracteristicas=="Comportamiento fuera de zona")  jugador._def_comportamientofueradezona=value;
    if (caracteristicas=="Correcta basculación")  jugador._def_correctabasculacion=value;
    if (caracteristicas=="Correcta basculación (distancia de intervalos)")  jugador._def_correctabasculacion_distanciadeintervalos=value;
    if (caracteristicas=="Correcto perfilamiento")  jugador._def_correctoperfilamiento=value;
    if (caracteristicas=="Cruces")  jugador._def_cruces=value;
    if (caracteristicas=="Destreza ante centros laterales")  jugador._def_destrezaantecentroslaterales=value;
    if (caracteristicas=="Difícil de superar en el 1 vs 1")  jugador._def_dificildesuperarenel1vs1=value;
    if (caracteristicas=="Dominio de las zonas de rechace")  jugador._def_dominiodelaszonasderechace=value;
    if (caracteristicas=="Duelos aéreos")  jugador._def_duelosaereos=value;
    if (caracteristicas=="Duelos defensivos")  jugador._def_duelosdefensivos=value;
    if (caracteristicas=="Evita recepciones entre líneas")  jugador._def_evitarecepcionesentrelineas=value;
    if (caracteristicas=="Evita ser desbordado")  jugador._def_evitaserdesbordado=value;
    if (caracteristicas=="Interceptación de tiro")  jugador._def_interceptaciondetiro=value;
    if (caracteristicas=="Mantener la línea defensiva")  jugador._def_mantenerlalineadefensiva=value;
    if (caracteristicas=="Marcaje próximo a oponente directo")  jugador._def_marcajeproximoaoponentedirecto=value;
    if (caracteristicas=="Ocupa espacios de compañeros superados")  jugador._def_ocupaespaciosdecompanerossuperados=value;
    if (caracteristicas=="Perfilamientos")  jugador._def_perfilamientos=value;
    if (caracteristicas=="Permite el giro")  jugador._def_permiteelgiro=value;
    if (caracteristicas=="Presión tras pérdida")  jugador._def_presiontrasperdida=value;
    if (caracteristicas=="Resolución ante paredes rivales")  jugador._def_resolucionanteparedesrivales=value;
    if (caracteristicas=="Sabe cuidar su espalda")  jugador._def_sabecuidarsuespalda=value;
    if (caracteristicas=="Vigila y referencia al rival (en fase ofensiva)")  jugador._def_vigilayreferenciaalrival_enfaseofensiva=value;
    if (caracteristicas=="Vigilancias sobre lateral rival")  jugador._def_vigilanciassobrelateralrival=value;
    if (caracteristicas=="Blocaje")  jugador._def_blocaje=value;
    if (caracteristicas=="Juego aéreo lateral")  jugador._def_juegoaereolateral=value;
    if (caracteristicas=="Juego aéreo frontal")  jugador._def_juegoaereofrontal=value;
    if (caracteristicas=="Habilidad en el 1 vs 1")  jugador._def_habilidadenel1vs1=value;
    if (caracteristicas=="Despeje")  jugador._def_despeje=value;
    if (caracteristicas=="Anticipación (intuición)")  jugador._def_anticipacion_intuicion=value;
    if (caracteristicas=="Cobertura de línea defensiva")  jugador._def_coberturadelineadefensiva=value;
    if (caracteristicas=="ABP´s")  jugador._def_abps=value;
    if (caracteristicas=="Penaltis")  jugador._def_penaltis=value;
  }


  bool get def_juegoaereolateral => _def_juegoaereolateral;

  set def_juegoaereolateral(bool value) {
    _def_juegoaereolateral = value;
  }

  bool get def_juegoaereofrontal => _def_juegoaereofrontal;

  set def_juegoaereofrontal(bool value) {
    _def_juegoaereofrontal = value;
  }

  bool get def_habilidadenel1vs1 => _def_habilidadenel1vs1;

  set def_habilidadenel1vs1(bool value) {
    _def_habilidadenel1vs1 = value;
  }

  bool get def_despeje => _def_despeje;

  set def_despeje(bool value) {
    _def_despeje = value;
  }

  bool get def_anticipacion_intuicion => _def_anticipacion_intuicion;

  set def_anticipacion_intuicion(bool value) {
    _def_anticipacion_intuicion = value;
  }

  bool get def_coberturadelineadefensiva => _def_coberturadelineadefensiva;

  set def_coberturadelineadefensiva(bool value) {
    _def_coberturadelineadefensiva = value;
  }

  bool get def_abps => _def_abps;

  set def_abps(bool value) {
    _def_abps = value;
  }

  bool get def_penaltis => _def_penaltis;

  set def_penaltis(bool value) {
    _def_penaltis = value;
  }

  bool get ofe_capacidadasociativa_apoyosalalineadefensiva =>
      _ofe_capacidadasociativa_apoyosalalineadefensiva;

  set ofe_capacidadasociativa_apoyosalalineadefensiva(bool value) {
    _ofe_capacidadasociativa_apoyosalalineadefensiva = value;
  }

  bool get ofe_desplazamientoenlargo => _ofe_desplazamientoenlargo;

  set ofe_desplazamientoenlargo(bool value) {
    _ofe_desplazamientoenlargo = value;
  }

  bool get fis_resistencia_idayvuelta => _fis_resistencia_idayvuelta;

  set fis_resistencia_idayvuelta(bool value) {
    _fis_resistencia_idayvuelta = value;
  }

  bool get fis_cambioderitmo => _fis_cambioderitmo;

  set fis_cambioderitmo(bool value) {
    _fis_cambioderitmo = value;
  }

  bool get psic_comunicacion => _psic_comunicacion;

  set psic_comunicacion(bool value) {
    _psic_comunicacion = value;
  }

  bool get psic_seguridad => _psic_seguridad;

  set psic_seguridad(bool value) {
    _psic_seguridad = value;
  }

  bool get psic_tomadedecisiones => _psic_tomadedecisiones;

  set psic_tomadedecisiones(bool value) {
    _psic_tomadedecisiones = value;
  }

  bool get psic_agresividad => _psic_agresividad;

  set psic_agresividad(bool value) {
    _psic_agresividad = value;
  }

  bool get psic_polivalencia => _psic_polivalencia;

  set psic_polivalencia(bool value) {
    _psic_polivalencia = value;
  }

  bool get psic_competitividad => _psic_competitividad;

  set psic_competitividad(bool value) {
    _psic_competitividad = value;
  }

  bool get psic_agresividad_contundencia => _psic_agresividad_contundencia;

  set psic_agresividad_contundencia(bool value) {
    _psic_agresividad_contundencia = value;
  }

  bool get psic_noasumeriesgosextremos => _psic_noasumeriesgosextremos;

  set psic_noasumeriesgosextremos(bool value) {
    _psic_noasumeriesgosextremos = value;
  }

  bool get psic_entendimientodeljuego_inteligencia =>
      _psic_entendimientodeljuego_inteligencia;

  set psic_entendimientodeljuego_inteligencia(bool value) {
    _psic_entendimientodeljuego_inteligencia = value;
  }

  bool get psic_creatividad => _psic_creatividad;

  set psic_creatividad(bool value) {
    _psic_creatividad = value;
  }

  bool get psic_confianza => _psic_confianza;

  set psic_confianza(bool value) {
    _psic_confianza = value;
  }

  bool get psic_compromiso => _psic_compromiso;

  set psic_compromiso(bool value) {
    _psic_compromiso = value;
  }

  bool get psic_valentia => _psic_valentia;

  set psic_valentia(bool value) {
    _psic_valentia = value;
  }

  bool get psic_oportunismo => _psic_oportunismo;

  set psic_oportunismo(bool value) {
    _psic_oportunismo = value;
  }


  int get edadRange1 => _edadRange1;

  set edadRange1(int value) {
    _edadRange1 = value;
  }

  static List<String> centralDefensa = <String>
  [ 'Anticipación',
    'Coberturas',
    'Colocación',
    'Comportamiento fuera de zona',
    'Correcta basculación (distancia de intervalos)',
    'Correcto perfilamiento',
    'Cruces',
    'Destreza ante centros laterales',
    'Difícil de superar en el 1 vs 1',
    'Duelos aéreos',
    'Duelos defensivos',
    'Interceptación de tiro',
    'Mantener la línea defensiva',
    'Marcaje próximo a oponente directo',
    'Permite el giro',
    'Vigila y referencia al rival (en fase ofensiva)',
    ];


  static List<String> centralPsicologia = <String>
  ['Liderazgo',
    'Comunicación',
    'Toma de decisiones',
    'Polivalencia',
    'Competitividad',
    'Agresividad/Contundencia',
    'No asume riesgos extremos',
    ];


  static List<String> centralFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Agilidad',
    'Cuerpo a cuerpo',
    'Capacidad de salto',
  ];

  static List<String> centralOfensivas = <String>
  ['Nivel técnico',
    'Finalización',
    'Salida de balón',
    'Pase largo/medio',
    'Cambios de orientación',
    'Bate líneas con pase interior',
    'Conducción para dividir',
    'Primer pase tras recuperación',
    'Interviene en ABP´s'
    ];


  static List<String> lateralDefensa = <String>
  ['Acoso-presión sobre el oponente',
    'Capacidad de marcaje',
    'Capacidad para tapar centros',
    'Cerrar el lado débil (basculaciones)',
    'Cobertura de centrales',
    'Duelos aéreos',
    'Duelos defensivos',
    'Mantener la línea defensiva',
    'Perfilamientos',
    'Resolución ante paredes rivales',
    'Sabe cuidar su espalda',

   ];


  static List<String> lateralPsicologia = <String>
  ['Liderazgo',
    'Toma de decisiones',
    'Agresividad',
    'Polivalencia'
  ];


  static List<String> lateralFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Fuerza/Potencia',
    'Resistencia (ida y vuelta)',
   ];

  static List<String> lateralOfensivas = <String>
  ['Nivel técnico',
    'Profundidad',
    'Capacidad de generar buenos centros al área',
    'Capacidad de asociación',
    'Desborde',
    'Superioridad por dentro',
    'Finalización',
    'Saque de banda (longitud)',
    'Lanzador de ABP´s',
    ];

  static List<String> carrileroDefensa = <String>
  ['Acoso-presión sobre el oponente',
    'Capacidad de marcaje',
    'Capacidad para tapar centros',
    'Cerrar el lado débil (basculaciones)',
    'Cobertura de centrales',
    'Duelos aéreos',
    'Duelos defensivos',
    'Mantener la línea defensiva',
    'Resolución ante paredes rivales',
    'Sabe cuidar su espalda',

  ];


  static List<String> carrileroPsicologia = <String>
  ['Liderazgo',
    'Toma de decisiones',
    'Agresividad',
    'Polivalencia',
  ];


  static List<String> carrileroFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Fuerza/Potencia',
    'Resistencia (ida y vuelta)',
  ];

  static List<String> carrileroOfensivas = <String>
  ['Nivel técnico',
    'Profundidad',
    'Capacidad de generar buenos centros al área',
    'Capacidad de asociación',
    'Habilidad 1 vs 1',
    'Finalización',
    'Saque de banda (longitud)',
    'Interviene en ABP´s',
  ];

  static List<String> medioDefensa = <String>
  ['Acoso-presión sobre el oponente',
    'Ayudas permanentes al lateral',
    'Activación de los mecanismos de presión',
    'Cierra líneas de pase',
    'Coberturas',
    'Colocación',
    'Correcta basculación',
    'Difícil de superar en el 1 vs 1',
    'Dominio de las zonas de rechace',
    'Duelos aéreos',
    'Duelos defensivos',
    'Evita recepciones entre líneas',
    'Marcaje próximo a oponente directo',
    'Presión tras pérdida',
    'Resolución ante paredes rivales',
    'Vigila y referencia al rival (en fase ofensiva)'];


  static List<String> medioPsicologia = <String>
  ['Liderazgo',
    'Comunicación',
    'Toma de decisiones',
    'Polivalencia',
    'Competitividad',
    'Agresividad/Contundencia',
    'No asume riesgos extremos',
    'Entendimiento del juego (inteligencia)',
    'Creatividad'];


  static List<String> medioFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Agilidad',
    'Capacidad de salto',
    'Explosividad',
    'Fuerza/Potencia'];

  static List<String> medioOfensivas = <String>
  [
    'Amplitud',
    'Bate líneas con pase interior',
    'Cambios de orientación',
    'Capacidad de asociación',
    'Capacidad de generar buenos centros laterales al área',
    'Conducción para dividir',
    'Desmarques de apoyo',
    'Desmarques de ruptura',
    'Finalización',
    'Habilidad 1 vs 1',
    'Incorporación a zonas de remate',
    'Interviene en ABP´s',
    'Nivel técnico',
    'Pase largo/medio',
    'Primer pase tras recuperación',
    'Realización del último pase',
    'Rematador/Finalizador',
    'Salida de balón',
    'Velocidad en el juego',];


  static List<String> porteroDefensa = <String>
  ['Colocación',
    'Blocaje',
    'Juego aéreo lateral',
    'Juego aéreo frontal',
    'Habilidad en el 1 vs 1',
    'Despeje',
    'Anticipación (intuición)',
    'Cobertura de línea defensiva',
    'ABP´s',
    'Penaltis'];


  static List<String> porteroPsicologia = <String>
  ['Liderazgo',
    'Comunicación',
    'Seguridad',
    'Toma de decisiones',
];


  static List<String> porteroFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Potencia de salto lateral y vertical',
    'Agilidad',
    ];

  static List<String> porteroOfensivas = <String>
  [
    'Capacidad asociativa, apoyos a la línea defensiva',
    'Desplazamiento en largo'
  ];

  static List<String> sino = <String>
  [
    'Si',
    'No'
  ];





  static List<String> delanteroDefensa = <String>
  [
    'Actitud defensiva',
    'Activación de los mecanismos de presión',
    'Cierra líneas de pase',
    'Dominio de las zonas de rechace',
    'Evita ser desbordado',
    'Ocupa espacios de compañeros superados',
    'Presión tras pérdida',
   ];


  static List<String> delanteroPsicologia = <String>
  ['Liderazgo',
    'Toma de decisiones',
    'Polivalencia',
    'Competitividad',
    'Creatividad',
    'Confianza',
    'Compromiso',
    'Valentía',
    'Oportunismo'];


  static List<String> delanteroFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Agilidad',
    'Fuerza/Potencia',
    'Explosividad',
    'Cambio de ritmo'];

  static List<String> delanteroOfensivas = <String>
  [
    'Ambidextro',
    'Caídas a banda',
    'Capacidad de asociación',
    'Definidor (ante el portero)',
    'Desborde por velocidad',
    'Desmarques de apoyo',
    'Desmarques de ruptura',
    'Dominio del área',
    'Duelos aéreos',
    'Explotación de espacios',
    'Goleador',
    'Habilidad 1 vs 1',
    'Interviene en ABP´s',
    'Juego de cara',
    'Juego en espacio reducido',
    'Nivel técnico',
     'Prolongaciones aéreas',
    'Protección del balón',
    'Realización del último pase',
    'Rematador/Finalizador',
    ];

  static List<String> extremoDefensa = <String>
  [
    'Actitud defensiva',
    'Activación de los mecanismos de presión',
    'Cierra líneas de pase',
    'Correcta basculación',
    'Dominio de las zonas de rechace',
    'Evita ser desbordado',
    'Presión tras pérdida',
    'Vigilancias sobre lateral rival',
 ];


  static List<String> extremoPsicologia = <String>
  ['Liderazgo',
    'Toma de decisiones',
    'Polivalencia',
    'Competitividad',
    'Entendimiento del juego (inteligencia)',
    'Creatividad',
    'Confianza',
    'Compromiso',
    'Valentía',
    ];


  static List<String> extremoFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Agilidad',
    'Explosividad',
    'Cambio de ritmo'];

  static List<String> extremoOfensivas = <String>
  [
    'Ambidextro',
    'Amplitud',
    'Capacidad de asociación',
    'Capacidad de generar buenos centros laterales al área',
    'Desborde por velocidad',
    'Desmarques de apoyo',
    'Desmarques de ruptura',
    'Dominio de 2vs1 (pared)',
    'Duelos aéreos',
    'Explotación de espacios',
    'Finalización',
    'Goleador',
    'Habilidad 1 vs 1',
    'Incorporación a zonas de remate',
    'Interviene en ABP´s',
    'Nivel técnico',
    'Realización del último pase',
    ];


  static List<String> todosDefensa = <String>
  ['Acoso-presión sobre el oponente',
    'Actitud defensiva',
    'Activación de los mecanismos de presión',
    'Anticipación',
    'Ayudas permanentes al lateral',
    'Capacidad de marcaje',
    'Capacidad para tapar centros',
    'Cerrar el lado débil (basculaciones)',
    'Cierra líneas de pase',
    'Cobertura de centrales',
    'Coberturas',
    'Colocación',
    'Comportamiento fuera de zona',
    'Correcta basculación',
    'Correcta basculación (distancia de intervalos)',
    'Correcto perfilamiento',
    'Cruces',
    'Destreza ante centros laterales',
    'Difícil de superar en el 1 vs 1',
    'Dominio de las zonas de rechace',
    'Duelos aéreos',
    'Duelos defensivos',
    'Evita recepciones entre líneas',
    'Evita ser desbordado',
    'Interceptación de tiro',
    'Mantener la línea defensiva',
    'Marcaje próximo a oponente directo',
    'Ocupa espacios de compañeros superados',
    'Perfilamientos',
    'Permite el giro',
    'Presión tras pérdida',
    'Resolución ante paredes rivales',
    'Sabe cuidar su espalda',
    'Vigila y referencia al rival (en fase ofensiva)',
    'Vigilancias sobre lateral rival',
    'Blocaje',
    'Juego aéreo lateral',
    'Juego aéreo frontal',
    'Habilidad en el 1 vs 1',
    'Despeje',
    'Anticipación (intuición)',
    'Cobertura de línea defensiva',
    'ABP´s',
    'Penaltis'];


  static List<String> todosPsicologia = <String>
  ['Liderazgo',
    'Comunicación',
    'Seguridad',
    'Toma de decisiones',
    'Agresividad',
    'Polivalencia',
    'Competitividad',
    'Agresividad/Contundencia',
    'No asume riesgos extremos',
    'Entendimiento del juego (inteligencia)',
    'Creatividad',
    'Confianza',
    'Compromiso',
    'Valentía',
    'Oportunismo'];


  static List<String> todosFisico = <String>
  ['Velocidad de reacción',
    'Velocidad de desplazamiento',
    'Agilidad',
    'Resistencia (ida y vuelta)',
    'Cuerpo a cuerpo',
    'Capacidad de salto',
    'Explosividad',
    'Cambio de ritmo'];

  static List<String> todosOfensivas = <String>
  [
    'Ambidextro',
    'Amplitud',
    'Bate líneas con pase interior',
    'Caídas a banda',
    'Cambios de orientación',
    'Capacidad asociativa, apoyos a la línea defensiva',
    'Capacidad de asociación',
    'Capacidad de generar buenos centros al área',
    'Capacidad de generar buenos centros laterales al área',
    'Conducción para dividir',
    'Definidor (ante el portero)',
    'Desborde por velocidad',
    'Desborde',
    'Desmarques de apoyo',
    'Desmarques de ruptura',
    'Desplazamiento en largo',
    'Dominio de 2vs1 (pared)',
    'Dominio del área',
    'Duelos aéreos',
    'Explotación de espacios',
    'Finalización',
    'Goleador',
    'Habilidad 1 vs 1',
    'Incorporación a zonas de remate',
    'Interviene en ABP´s',
    'Juego de cara',
    'Juego en espacio reducido',
    'Lanzador de ABP´s',
    'Llegada a posiciones de remate',
    'Nivel técnico',
    'Pase largo/medio',
    'Primer pase tras recuperación',
    'Profundidad',
    'Prolongaciones aéreas',
    'Protección del balón',
    'Realización del último pase',
    'Rematador/Finalizador',
    'Salida de balón',
    'Saque de banda (longitud)',
    'Superioridad por dentro',
    'Velocidad en el juego'];


static List<String> tipoPortero = <String>
['TIPO A: Estático bajo portería de grandes reflejos con juego asociativo',
  'TIPO B: Estático bajo portería de grandes reflejos con escasa capacidad para el juego con los pies.',
  'TIPO C: Dominador de zona de área con juego asociativo.',
  'TIPO D: Dominador de zona de área con escasa capacidad para el juego con los pies.',
  'TIPO E: De grandes reflejos bajo la portería, dominador de zona de área y con juego asociativo.',
];

  static List<String> tipoLateral = <String>
  ['TIPO A: Con correctos conceptos defensivos pero las cualidades de su juego son más ofensivas.',
    'TIPO B: Priman sus cualidades defensivas sobre las ofensivas donde sin obviarlas su rendimiento es simplemente aceptable.',
    'TIPO C: Capacidades tanto ofensivas como defensivas notables.',
    'TIPO D: De mucha envergadura con capacidades para poder ser central, defensivamente muy potente,limita su participación a la faceta defensiva, en el apartado ofensivo escaso aporte y presenta dificultades.',
  ];
  static List<String> tipoCarrilero = <String>
  ['TIPO A: Con correctos conceptos defensivos pero las cualidades de su juego son más ofensivas.',
  'TIPO B: Priman sus cualidades defensivas sobre las ofensivas donde sin obviarlas su rendimiento es simplemente aceptable.',
  'TIPO C: Capacidades tanto ofensivas como defensivas notables.'
  ];

  static List<String> tipoCentral = <String>
  ['TIPO A: Jugador en el que prima lo físico y buenos conceptos defensivos con dificultades con el balón en los pies.',
  'TIPO B: Jugador de mediana envergadura con buenos conceptos defensivos, pero destaca en su comportamiento con balón.',
  'TIPO C: Buenas capacidades físicas y con destrezas tanto ofensivas como defensivas notables.',
  'TIPO D: Con mejores condiciones para ocupar la demarcación de lateral.'
  ];

  static List<String> tipoMedio = <String>
  ['TIPO A: Pivote defensivo con capacidad de recuperación del balón y correcta salida de balón. Incrustado entre la línea de medios y defensiva ocupando él solo ese espacio central.',
  'TIPO B: Mediocentro organizador, cumple labores defensivas y ofensivas pero su característica es la distribución correcta del balón.',
  'TIPO C: Mediocentro de contención, agresividad, presión al rival, dominador de espacios y cobertura, todo ello como prioridad a las destrezas ofensivas.',
  'TIPO D: Box-to-box. Alta intensidad y resistencia, participación en todas las fases del juego, poder de marcaje, cualidades en el apoyo.',
  'TIPO E: Interior, jugador de banda con posibilidad de jugar por dentro con destrezas tanto ofensivas como defensivas.',
  'TIPO F: Media punta, enganche entre la delantera y centro del campo con capacidad para filtrar balones y de gran destreza técnica.'
  ];
  static List<String> tipoDelantero= <String>
  ['TIPO A: Referencia, de gran poderío físico, juego aéreo y de espaldas como virtudes.',
  'TIPO B: Con gran capacidad de asociación, desborde en el 1 vs 1 y búsqueda de espacios a la espalda de los medios centros y centrales. Normalmente en posiciones detrás del delantero tipo A.',
  'TIPO C: Falso 9. Actúa entre las líneas de medios y defensa rival. Salir de la referencia de ataque para buscar de frente el ataque, movilidad, atacar espacios, desmarque, asistencia y último pase.',
  'TIPO D: De velocidad al espacio de la línea defensiva en continuos desmarques de ruptura.',
  'TIPO E: No participa en el juego, fijador de los centrales oponentes y capacidad de estar en el lugar adecuado para la finalización.'
  ];

  static List<String> tipoExtremo= <String>
  ['TIPO A: Predominante a pierna cambiada con tendencia a salir por dentro.',
  'TIPO B: Predominante a pierna natural con tendencia a buscar la profundidad y posterior centro.',
  'TIPO C: Interviene de manera satisfactoria en ambos perfiles.'];

  static List<String> tipoPorteroLetra = <String>
  ['A',
    'B',
    'C',
    'D',
    'E',
  ];

  static List<String> tipoLateralLetra = <String>
  ['A',
    'B',
    'C',
    'D',
  ];
  static List<String> tipoCarrileroLetra = <String>
  ['A',
    'B',
    'C',
  ];

  static List<String> tipoCentralLetra = <String>
  ['A',
    'B',
    'C',
    'D',
  ];

  static List<String> tipoMedioLetra = <String>
  ['A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];
  static List<String> tipoDelanteroLetra= <String>
  ['A',
    'B',
    'C',
    'D',
    'E',
  ];

  static List<String> tipoExtremoLetra= <String>
  ['A',
    'B',
    'C',
  ];

  static listaTiposPosicion(String posicionAux) {

    if(posicionAux.contains("PORTERO"))
      return Jugador.tipoPorteroLetra;
    else  if(posicionAux.contains("LATERAL"))
      return Jugador.tipoLateralLetra;
    else  if(posicionAux.contains("CARRILERO"))
      return Jugador.tipoCarrileroLetra;
    else if(posicionAux.contains("DEFENSA"))
      return Jugador.tipoCentralLetra;
    else if(posicionAux.contains("CENTRAL"))
      return Jugador.tipoCentralLetra;
    else  if(posicionAux.contains("MEDIO"))
      return Jugador.tipoMedioLetra;
    else  if(posicionAux.contains("INTERIOR"))
      return Jugador.tipoMedioLetra;
    else  if(posicionAux.contains("VOLANTE"))
      return Jugador.tipoMedioLetra;
    else  if(posicionAux.contains("CENTROCAMPISTA"))
      return Jugador.tipoMedioLetra;
    else  if(posicionAux.contains("PIVOTE"))
      return Jugador.tipoMedioLetra;
    else  if(posicionAux.contains("DELANTERO"))
      return Jugador.tipoDelanteroLetra;
    else  if(posicionAux.contains("PUNTA"))
      return Jugador.tipoMedioLetra;
    else  if(posicionAux.contains("EXTREMO"))
      return Jugador.tipoExtremoLetra;
    else
      return Jugador.tipoPorteroLetra;
  }

static int indiceTipo(String tipo){
  if (tipo=="A") return 0;
  if (tipo=="B") return 1;
  if (tipo=="C") return 2;
  if (tipo=="D") return 3;
  if (tipo=="E") return 4;
  if (tipo=="F") return 5;
}

static String tipoJugador(String posicion, String tipo){
  try {
    int i = indiceTipo(tipo);
    if (posicion.toUpperCase().contains("PORTERO"))
      return Jugador.tipoPortero[i];
    if (posicion.toUpperCase().contains("LATERAL"))
      return Jugador.tipoLateral[i];

    if (posicion.toUpperCase().contains("CARRILERO"))
      return Jugador.tipoCarrilero[i];

    if (posicion.toUpperCase().contains("DEFENSA"))
      return Jugador.tipoCentral[i];

    if (posicion.toUpperCase().contains("CENTRAL"))
      return Jugador.tipoCentral[i];

    if (posicion.toUpperCase().contains("MEDIO")) return Jugador.tipoMedio[i];

    if (posicion.toUpperCase().contains("INTERIOR"))
      return Jugador.tipoMedio[i];

    if (posicion.toUpperCase().contains("CENTROCAMPISTA"))
      return Jugador.tipoMedio[i];

    if (posicion.toUpperCase().contains("PIVOTE")) return Jugador.tipoMedio[i];

    if (posicion.toUpperCase().contains("VOLANTE")) return Jugador.tipoMedio[i];

    if (posicion.toUpperCase().contains("DELANTERO"))
      return Jugador.tipoDelantero[i];

    if (posicion.toUpperCase().contains("PUNTA")) return Jugador.tipoMedio[i];

    if (posicion.toUpperCase().contains("EXTREMO"))
      return Jugador.tipoExtremo[i];
  }catch(e){
    return "";
  }
  
}

  String get fechaContrato => _fechaContrato;

  set fechaContrato(String value) {
    _fechaContrato = value;
  }

  String get peso => _peso;

  set peso(String value) {
    _peso = value;
  }

  String get altura => _altura;

  set altura(String value) {
    _altura = value;
  }

  String get valor => _valor;

  set valor(String value) {
    _valor = value;
  }

  String get paisNacimiento => _paisNacimiento;

  set paisNacimiento(String value) {
    _paisNacimiento = value;
  }

  String get prestamo => _prestamo;

  set prestamo(String value) {
    _prestamo = value;
  }

  String get lateral => _lateral;

  set lateral(String value) {
    _lateral = value;
  }

  String get nacionalidad => _nacionalidad;

  set nacionalidad(String value) {
    _nacionalidad = value;
  }

  String get posicionalternativa => _posicionalternativa;

  set posicionalternativa(String value) {
    _posicionalternativa = value;
  }

  String get temporada => _temporada;

  set temporada(String value) {
    _temporada = value;
  }

  String get nivel3 => _nivel3;

  set nivel3(String value) {
    _nivel3 = value;
  }

  String get nivel4 => _nivel4;

  set nivel4(String value) {
    _nivel4 = value;
  }


  int get edadRange2 => _edadRange2;

  set edadRange2(int value) {
    _edadRange2 = value;
  }
}