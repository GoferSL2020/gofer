import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';

import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class Entrenador {
  String key;
  String _email="";
  String _fecha="";
  String _temporada="";
  String _pais="";
  String _categoria="";
  String _equipo="";
  String _entrenador="";
  String _fechaNacimiento="";
  String _fechaFichaje="";
  String _fechaFinContrato="";
  String _nacionalidad = "";
  String _paisNacimiento="";
  String _ccaa = "";
  String _scout="";
  String _activo = "";
  String _observaciones = "";
  bool _con_1442 = false;
  bool _con_14411 = false;
  bool _con_14231 = false;
  bool _con_14141 = false;
  bool _con_1343 = false;
  bool _con_1352 = false;
  bool _con_13421 = false;
  bool _con_1532 = false;
  bool _con_1451 = false;
  bool _con_1541 = false;
  bool _con_1433 = false;
  bool _con_ofensivo = false;
  bool _con_equilibrado = false;
  bool _con_defensivo = false;
  bool _con_organizada_o_prevista = false;
  bool _con_libre_o_imprevista = false;
  bool _con_de_ajuste_o_gran_variabilidad = false;
  bool _con_plan_unico_o_baja_variabilidad = false;

  bool _for_amplitud_ofensiva = false;
  bool _for_amplitud_defensiva = false;
  bool _for_profundidad_ofensiva = false;
  bool _for_profundidad_defensiva = false;
  bool _for_densidad_ofensiva = false;
  bool _for_densidad_defensiva = false;
  bool _for_def_bloque_bajo = false;
  bool _for_def_bloque_medio = false;
  bool _for_def_bloque_alto = false;
  bool _for_ofe_bloque_bajo = false;
  bool _for_ofe_bloque_medio = false;
  bool _for_ofe_bloque_alto = false;
  bool _for_perifericos = false;
  bool _for_centralizados = false;
  bool _for_fija = false;
  bool _for_variable = false;
  String _for_variante_defensiva = "";
  String _for_variante_ofensiva = "";
  bool _fun_en_corto = false;
  bool _fun_ofe_mixta = false;
  bool _fun_en_largo = false;
  bool _fun_combinativa_mixta = false;
  bool _fun_directa = false;
  bool _fun_presion_conjunta = false;
  bool _fun_presion_orientada_al_poseedor_rival_repliegue = false;
  bool _fun_repliegue = false;

  bool _fun_contencion = false;
  bool _fun_presionante = false;
  bool _fun_def_mixta = false;
  bool _fun_juego_directo = false;
  bool _fun_contraataque = false;
  bool _fun_ataque_organizado = false;
  bool _fun_velocidad_de_circulacion = false;
  bool _fun_progresion_del_balon = false;
  bool _fun_velocidad_de_recuperacion = false;
  bool _fun_amplio = false;
  bool _fun_moderado = false;
  bool _fun_reducido = false;
  bool _fun_amplia = false;
  bool _fun_moderada = false;
  bool _fun_reducida = false;


  Image image;

  Entrenador();

  String foto() {
    return
      this._entrenador.replaceAll("à", "a")
          .replaceAll("è", "e")
          .replaceAll("ì", "i")
          .replaceAll("ò", "o")
          .replaceAll("ù", "u")
          .replaceAll("Á", "A")
          .replaceAll("É", "E")
          .replaceAll("Í", "I")
          .replaceAll("Ó", "O")
          .replaceAll("Ú", "U")
          .replaceAll("ñ", "n")
          .replaceAll("á", "a")
          .replaceAll("é", "e")
          .replaceAll("í", "i")
          .replaceAll("ó", "o").replaceAll(" ", "");
  }

  Entrenador.fromJsonJugador(Entrenador e) {
    this.key=e.key;
    this._email=e.email;
    this._fecha=e.fecha;
    this._temporada=e.temporada;
    this._pais=e.pais;
    this._categoria=e.categoria;
    this._equipo=e.equipo;
    this._entrenador=e.entrenador;
    this._fechaNacimiento=e.fechaNacimiento;
    this._fechaFichaje=e.fechaFichaje;
    this._fechaFinContrato=e.fechaFinContrato;
    this._nacionalidad=e.nacionalidad;
    this._paisNacimiento=e.paisNacimiento;
    this._ccaa=e.ccaa;
    this._scout=e.scout;
    this._activo=e.activo;
    this._observaciones = e.observaciones;
    this._con_1442=e.con_1442;
    this._con_14411=e.con_14411;
    this._con_14231=e.con_14231;
    this._con_14141=e.con_14141;
    this._con_1343=e.con_1343;
    this._con_1352=e.con_1352;
    this._con_13421=e.con_13421;
    this._con_1532=e.con_1532;
    this._con_1451=e.con_1451;
    this._con_1541=e.con_1541;
    this._con_1433=e.con_1433;
    this._con_ofensivo=e.con_ofensivo;
    this._con_equilibrado=e.con_equilibrado;
    this._con_defensivo=e.con_defensivo;
    this._con_organizada_o_prevista=e.con_organizada_o_prevista;
    this._con_libre_o_imprevista=e.con_libre_o_imprevista;
    this. _con_de_ajuste_o_gran_variabilidad=this. _con_de_ajuste_o_gran_variabilidad;
    this. _con_plan_unico_o_baja_variabilidad=this. _con_plan_unico_o_baja_variabilidad;
    this. _for_amplitud_ofensiva=this. _for_amplitud_ofensiva;
    this. _for_amplitud_defensiva=this. _for_amplitud_defensiva;
    this. _for_profundidad_ofensiva=this. _for_profundidad_ofensiva;
    this. _for_profundidad_defensiva=this. _for_profundidad_defensiva;
    this. _for_densidad_ofensiva=this. _for_densidad_ofensiva;
    this. _for_densidad_defensiva=this. _for_densidad_defensiva;
    this. _for_def_bloque_bajo=this. _for_def_bloque_bajo;
    this. _for_def_bloque_medio=this. _for_def_bloque_medio;
    this. _for_def_bloque_alto=this. _for_def_bloque_alto;
    this. _for_ofe_bloque_bajo=this. _for_ofe_bloque_bajo;
    this. _for_ofe_bloque_medio=this. _for_ofe_bloque_medio;
    this. _for_ofe_bloque_alto=this. _for_ofe_bloque_alto;
    this. _for_perifericos=this. _for_perifericos;
    this. _for_centralizados=this. _for_centralizados;
    this. _for_fija=this. _for_fija;
    this. _for_variable=this. _for_variable;
    this._for_variante_defensiva=e.for_variante_defensiva;
    this._for_variante_ofensiva=e.for_variante_ofensiva;
    this._fun_en_corto=e.fun_en_corto;
    this._fun_ofe_mixta=e.fun_ofe_mixta;
    this._fun_en_largo=e.fun_en_largo;
    this._fun_combinativa_mixta=e.fun_combinativa_mixta;
    this._fun_directa=e.fun_directa;
    this._fun_presion_conjunta=e.fun_presion_conjunta;
    this._fun_presion_orientada_al_poseedor_rival_repliegue=e.fun_presion_orientada_al_poseedor_rival_repliegue;
    this._fun_repliegue=e.fun_repliegue;
    this._fun_contencion=e.fun_contencion;
    this._fun_presionante=e.fun_presionante;
    this._fun_def_mixta=e.fun_def_mixta;
    this._fun_juego_directo=e.fun_juego_directo;
    this._fun_contraataque=e.fun_contraataque;
    this._fun_ataque_organizado=e.fun_ataque_organizado;
    this._fun_velocidad_de_circulacion=e.fun_velocidad_de_circulacion;
    this._fun_progresion_del_balon=e.fun_progresion_del_balon;
    this._fun_velocidad_de_recuperacion=e.fun_velocidad_de_recuperacion;
    this._fun_amplio=e.fun_amplio;
    this._fun_moderado=e.fun_moderado;
    this._fun_reducido=e.fun_reducido;
    this._fun_amplia=e.fun_amplia;
    this._fun_moderada=e.fun_moderada;
    this._fun_reducida=e.fun_reducida;
  }


  Entrenador.fromSnapshot(DataSnapshot obj) {
    this.key=obj.value['key'];
    this._email=obj.value['email'];
    this._fecha=obj.value['fecha'];
    this._temporada=obj.value['temporada'];
    this._pais=obj.value['pais'];
    this._categoria=obj.value['categoria'];
    this._equipo=obj.value['equipo'];
    this._entrenador=obj.value['entrenador'];
    this._fechaNacimiento=obj.value['fechaNacimiento'];
    this._fechaFichaje=obj.value['fechaFichaje'];
    this._fechaFinContrato=obj.value['fechaFinContrato'];
    this._nacionalidad=obj.value['nacionalidad'];
    this._paisNacimiento=obj.value['paisNacimiento'];
    this._ccaa=obj.value['ccaa'];
    this._scout=obj.value['scout'];
    this._activo=obj.value['activo'];
    this._observaciones = obj.value['observaciones'];
    this._con_1442=obj.value['con_1442'];
    this._con_14411=obj.value['con_14411'];
    this._con_14231=obj.value['con_14231'];
    this._con_14141=obj.value['con_14141'];
    this._con_1343=obj.value['con_1343'];
    this._con_1352=obj.value['con_1352'];
    this._con_13421=obj.value['con_13421'];
    this._con_1532=obj.value['con_1532'];
    this._con_1451=obj.value['con_1451'];
    this._con_1541=obj.value['con_1541'];
    this._con_1433=obj.value['con_1433'];
    this._con_ofensivo=obj.value['con_ofensivo'];
    this._con_equilibrado=obj.value['con_equilibrado'];
    this._con_defensivo=obj.value['con_defensivo'];
    this._con_organizada_o_prevista=obj.value['con_organizada_o_prevista'];
    this._con_libre_o_imprevista=obj.value['con_libre_o_imprevista'];
    this. _con_de_ajuste_o_gran_variabilidad=obj.value['con_de_ajuste_o_gran_variabilidad'];
    this. _con_plan_unico_o_baja_variabilidad=obj.value['con_plan_unico_o_baja_variabilidad'];
    this. _for_amplitud_ofensiva=obj.value['for_amplitud_ofensiva'];
    this. _for_amplitud_defensiva=obj.value['for_amplitud_defensiva'];
    this. _for_profundidad_ofensiva=obj.value['for_profundidad_ofensiva'];
    this. _for_profundidad_defensiva=obj.value['for_profundidad_defensiva'];
    this. _for_densidad_ofensiva=obj.value['for_densidad_ofensiva'];
    this. _for_densidad_defensiva=obj.value['for_densidad_defensiva'];
    this. _for_def_bloque_bajo=obj.value['for_def_bloque_bajo'];
    this. _for_def_bloque_medio=obj.value['for_def_bloque_medio'];
    this. _for_def_bloque_alto=obj.value['for_def_bloque_alto'];
    this. _for_ofe_bloque_bajo=obj.value['for_ofe_bloque_bajo'];
    this. _for_ofe_bloque_medio=obj.value['for_ofe_bloque_medio'];
    this. _for_ofe_bloque_alto=obj.value['for_ofe_bloque_alto'];
    this. _for_perifericos=obj.value['for_perifericos'];
    this. _for_centralizados=obj.value['for_centralizados'];
    this. _for_fija=obj.value['for_fija'];
    this. _for_variable=obj.value['for_variable'];
    this._for_variante_defensiva=obj.value['for_variante_defensiva'];
    this._for_variante_ofensiva=obj.value['for_variante_ofensiva'];
    this._fun_en_corto=obj.value['fun_en_corto'];
    this._fun_ofe_mixta=obj.value['fun_ofe_mixta'];
    this._fun_en_largo=obj.value['fun_en_largo'];
    this._fun_combinativa_mixta=obj.value['fun_combinativa_mixta'];
    this._fun_directa=obj.value['fun_directa'];
    this._fun_presion_conjunta=obj.value['fun_presion_conjunta'];
    this._fun_presion_orientada_al_poseedor_rival_repliegue=obj.value['fun_presion_orientada_al_poseedor_rival_repliegue'];
    this._fun_repliegue=obj.value['fun_repliegue'];
    this._fun_contencion=obj.value['fun_contencion'];
    this._fun_presionante=obj.value['fun_presionante'];
    this._fun_def_mixta=obj.value['fun_def_mixta'];
    this._fun_juego_directo=obj.value['fun_juego_directo'];
    this._fun_contraataque=obj.value['fun_contraataque'];
    this._fun_ataque_organizado=obj.value['fun_ataque_organizado'];
    this._fun_velocidad_de_circulacion=obj.value['fun_velocidad_de_circulacion'];
    this._fun_progresion_del_balon=obj.value['fun_progresion_del_balon'];
    this._fun_velocidad_de_recuperacion=obj.value['fun_velocidad_de_recuperacion'];
    this._fun_amplio=obj.value['fun_amplio'];
    this._fun_moderado=obj.value['fun_moderado'];
    this._fun_reducido=obj.value['fun_reducido'];
    this._fun_amplia=obj.value['fun_amplia'];
    this._fun_moderada=obj.value['fun_moderada'];
    this._fun_reducida=obj.value['fun_reducida'];
  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["key"]= key;
    map["email"]= _email;
    map["fecha"]= _fecha;
    map["temporada"]= _temporada;
    map["pais"]= _pais;
    map["categoria"]= _categoria;
    map["equipo"]= _equipo;
    map["entrenador"]= _entrenador;
    map["fechaNacimiento"]= _fechaNacimiento;
    map["fechaFichaje"]= _fechaFichaje;
    map["fechaFinContrato"]= _fechaFinContrato;
    map["nacionalidad"]= _nacionalidad;
    map["paisNacimiento"]= _paisNacimiento;
    map["ccaa"]= _ccaa;
    map["scout"]= _scout;
    map["activo"]= _activo;
    map["observaciones"]=_observaciones;
    map["con_1442"]= _con_1442;
    map["con_14411"]= _con_14411;
    map["con_14231"]= _con_14231;
    map["con_14141"]= _con_14141;
    map["con_1343"]= _con_1343;
    map["con_1352"]= _con_1352;
    map["con_13421"]= _con_13421;
    map["con_1532"]= _con_1532;
    map["con_1451"]= _con_1451;
    map["con_1541"]= _con_1541;
    map["con_1433"]= _con_1433;
    map["con_ofensivo"]= _con_ofensivo;
    map["con_equilibrado"]= _con_equilibrado;
    map["con_defensivo"]= _con_defensivo;
    map["con_organizada_o_prevista"]= _con_organizada_o_prevista;
    map["con_libre_o_imprevista"]= _con_libre_o_imprevista;
    map["con_de_ajuste_o_gran_variabilidad"]=_con_de_ajuste_o_gran_variabilidad;
    map["con_plan_unico_o_baja_variabilidad"]=_con_plan_unico_o_baja_variabilidad;
    map["for_amplitud_ofensiva"]=_for_amplitud_ofensiva;
    map["for_amplitud_defensiva"]=_for_amplitud_defensiva;
    map["for_profundidad_ofensiva"]=_for_profundidad_ofensiva;
    map["for_profundidad_defensiva"]=_for_profundidad_defensiva;
    map["for_densidad_ofensiva"]=_for_densidad_ofensiva;
    map["for_densidad_defensiva"]=_for_densidad_defensiva;
    map["for_def_bloque_bajo"]=_for_def_bloque_bajo;
    map["for_def_bloque_medio"]=_for_def_bloque_medio;
    map["for_def_bloque_alto"]=_for_def_bloque_alto;
    map["for_ofe_bloque_bajo"]=_for_ofe_bloque_bajo;
    map["for_ofe_bloque_medio"]=_for_ofe_bloque_medio;
    map["for_ofe_bloque_alto"]=_for_ofe_bloque_alto;
    map["for_perifericos"]=_for_perifericos;
    map["for_centralizados"]=_for_centralizados;
    map["for_fija"]=_for_fija;
    map["for_variable"]=_for_variable;
    map["for_variante_defensiva"]= _for_variante_defensiva;
    map["for_variante_ofensiva"]= _for_variante_ofensiva;
    map["fun_en_corto"]= _fun_en_corto;
    map["fun_ofe_mixta"]= _fun_ofe_mixta;
    map["fun_en_largo"]= _fun_en_largo;
    map["fun_combinativa_mixta"]= _fun_combinativa_mixta;
    map["fun_directa"]= _fun_directa;
    map["fun_presion_conjunta"]= _fun_presion_conjunta;
    map["fun_presion_orientada_al_poseedor_rival_repliegue"]= _fun_presion_orientada_al_poseedor_rival_repliegue;
    map["fun_repliegue"]= _fun_repliegue;
    map["fun_contencion"]= _fun_contencion;
    map["fun_presionante"]= _fun_presionante;
    map["fun_def_mixta"]= _fun_def_mixta;
    map["fun_juego_directo"]= _fun_juego_directo;
    map["fun_contraataque"]= _fun_contraataque;
    map["fun_ataque_organizado"]= _fun_ataque_organizado;
    map["fun_velocidad_de_circulacion"]= _fun_velocidad_de_circulacion;
    map["fun_progresion_del_balon"]= _fun_progresion_del_balon;
    map["fun_velocidad_de_recuperacion"]= _fun_velocidad_de_recuperacion;
    map["fun_amplio"]= _fun_amplio;
    map["fun_moderado"]= _fun_moderado;
    map["fun_reducido"]= _fun_reducido;
    map["fun_amplia"]= _fun_amplia;
    map["fun_moderada"]= _fun_moderada;
    map["fun_reducida"]= _fun_reducida;
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

  Entrenador.fromMap(dynamic obj) {
    print(obj);
    this._temporada=obj['TEMPORADA'];
    this._pais=obj['PAIS'];
    this._categoria=obj['CATEGORIA'];
    this._equipo=obj['EQUIPO'];
    this._entrenador=obj['ENTRENADOR'];
    this._fechaNacimiento=obj['FECHANACIMIENTO'];
    this._fechaFichaje=obj['FICHAJE'];
    this._fechaFinContrato=obj['FECHAFINCONTRATO'];
    this._nacionalidad=obj['NACIONALIDAD'];
    this._paisNacimiento=obj['LUGAR_NACIMIENTO'];
    this._ccaa=obj['CCAA'];
    this._scout=obj['SCOUT'];
    this._activo=obj['ACTIVO'];
    this._con_1442=false;
    this._con_14411=false; //['con_14411'];
    this._con_14231=false; //['con_14231'];
    this._con_14141=false; //['con_14141'];
    this._con_1343=false; //['con_1343'];
    this._con_1352=false; //['con_1352'];
    this._con_13421=false; //['con_13421'];
    this._con_1532=false; //['con_1532'];
    this._con_1451=false; //['con_1451'];
    this._con_1541=false; //['con_1541'];
    this._con_1433=false; //['con_1433'];
    this._con_ofensivo=false; //['con_ofensivo'];
    this._con_equilibrado=false; //['con_equilibrado'];
    this._con_defensivo=false; //['con_defensivo'];
    this._con_organizada_o_prevista=false; //['con_organizada_o_prevista'];
    this._con_libre_o_imprevista=false; //['con_libre_o_imprevista'];
    this. _con_de_ajuste_o_gran_variabilidad=false; //['con_de_ajuste_o_gran_variabilidad'];
    this. _con_plan_unico_o_baja_variabilidad=false; //['con_plan_unico_o_baja_variabilidad'];
    this. _for_amplitud_ofensiva=false; //['for_amplitud_ofensiva'];
    this. _for_amplitud_defensiva=false; //['for_amplitud_defensiva'];
    this. _for_profundidad_ofensiva=false; //['for_profundidad_ofensiva'];
    this. _for_profundidad_defensiva=false; //['for_profundidad_defensiva'];
    this. _for_densidad_ofensiva=false; //['for_densidad_ofensiva'];
    this. _for_densidad_defensiva=false; //['for_densidad_defensiva'];
    this. _for_def_bloque_bajo=false; //['for_def_bloque_bajo'];
    this. _for_def_bloque_medio=false; //['for_def_bloque_medio'];
    this. _for_def_bloque_alto=false; //['for_def_bloque_alto'];
    this. _for_ofe_bloque_bajo=false; //['for_ofe_bloque_bajo'];
    this. _for_ofe_bloque_medio=false; //['for_ofe_bloque_medio'];
    this. _for_ofe_bloque_alto=false; //['for_ofe_bloque_alto'];
    this. _for_perifericos=false; //['for_perifericos'];
    this. _for_centralizados=false; //['for_centralizados'];
    this. _for_fija=false; //['for_fija'];
    this. _for_variable=false; //['for_variable'];
    this._for_variante_defensiva=""; //['for_variante_defensiva'];
    this._for_variante_ofensiva=""; //['for_variante_ofensiva'];
    this._fun_en_corto=false; //['fun_en_corto'];
    this._fun_ofe_mixta=false; //['fun_ofe_mixta'];
    this._fun_en_largo=false; //['fun_en_largo'];
    this._fun_combinativa_mixta=false; //['fun_combinativa_mixta'];
    this._fun_directa=false; //['fun_directa'];
    this._fun_presion_conjunta=false; //['fun_presion_conjunta'];
    this._fun_presion_orientada_al_poseedor_rival_repliegue=false; //['fun_presion_orientada_al_poseedor_rival_repliegue'];
    this._fun_repliegue=false; //['fun_repliegue'];
    this._fun_contencion=false; //['fun_contencion'];
    this._fun_presionante=false; //['fun_presionante'];
    this._fun_def_mixta=false; //['fun_def_mixta'];
    this._fun_juego_directo=false; //['fun_juego_directo'];
    this._fun_contraataque=false; //['fun_contraataque'];
    this._fun_ataque_organizado=false; //['fun_ataque_organizado'];
    this._fun_velocidad_de_circulacion=false; //['fun_velocidad_de_circulacion'];
    this._fun_progresion_del_balon=false; //['fun_progresion_del_balon'];
    this._fun_velocidad_de_recuperacion=false; //['fun_velocidad_de_recuperacion'];
    this._fun_amplio=false; //['fun_amplio'];
    this._fun_moderado=false; //['fun_moderado'];
    this._fun_reducido=false; //['fun_reducido'];
    this._fun_amplia=false; //['fun_amplio'];
    this._fun_moderada=false; //['fun_moderado'];
    this._fun_reducida=false; //['fun_reducido'];
  }

  Entrenador.fromJson(this.key, Map obj) {
    print(key);
    key = this.key;
    this._email=obj['email'];
    this._fecha=obj['fecha'];
    this._temporada=obj['temporada'];
    this._pais=obj['pais'];
    this._categoria=obj['categoria'];
    this._equipo=obj['equipo'];
    this._entrenador=obj['entrenador'];
    this._fechaNacimiento=obj['fechaNacimiento'];
    this._fechaFichaje=obj['fechaFichaje'];
    this._fechaFinContrato=obj['fechaFinContrato'];
    this._nacionalidad=obj['nacionalidad'];
    this._paisNacimiento=obj['paisNacimiento'];
    this._ccaa=obj['ccaa'];
    this._scout=obj['scout'];
    this._activo=obj['activo'];
    this._observaciones = obj['observaciones'];
    this._con_1442=obj['con_1442'];
    this._con_14411=obj['con_14411'];
    this._con_14231=obj['con_14231'];
    this._con_14141=obj['con_14141'];
    this._con_1343=obj['con_1343'];
    this._con_1352=obj['con_1352'];
    this._con_13421=obj['con_13421'];
    this._con_1532=obj['con_1532'];
    this._con_1451=obj['con_1451'];
    this._con_1541=obj['con_1541'];
    this._con_1433=obj['con_1433'];
    this._con_ofensivo=obj['con_ofensivo'];
    this._con_equilibrado=obj['con_equilibrado'];
    this._con_defensivo=obj['con_defensivo'];
    this._con_organizada_o_prevista=obj['con_organizada_o_prevista'];
    this._con_libre_o_imprevista=obj['con_libre_o_imprevista'];
    this. _con_de_ajuste_o_gran_variabilidad=obj['con_de_ajuste_o_gran_variabilidad'];
    this. _con_plan_unico_o_baja_variabilidad=obj['con_plan_unico_o_baja_variabilidad'];
    this. _for_amplitud_ofensiva=obj['for_amplitud_ofensiva'];
    this. _for_amplitud_defensiva=obj['for_amplitud_defensiva'];
    this. _for_profundidad_ofensiva=obj['for_profundidad_ofensiva'];
    this. _for_profundidad_defensiva=obj['for_profundidad_defensiva'];
    this. _for_densidad_ofensiva=obj['for_densidad_ofensiva'];
    this. _for_densidad_defensiva=obj['for_densidad_defensiva'];
    this. _for_def_bloque_bajo=obj['for_def_bloque_bajo'];
    this. _for_def_bloque_medio=obj['for_def_bloque_medio'];
    this. _for_def_bloque_alto=obj['for_def_bloque_alto'];
    this. _for_ofe_bloque_bajo=obj['for_ofe_bloque_bajo'];
    this. _for_ofe_bloque_medio=obj['for_ofe_bloque_medio'];
    this. _for_ofe_bloque_alto=obj['for_ofe_bloque_alto'];
    this. _for_perifericos=obj['for_perifericos'];
    this. _for_centralizados=obj['for_centralizados'];
    this. _for_fija=obj['for_fija'];
    this. _for_variable=obj['for_variable'];
    this._for_variante_defensiva=obj['for_variante_defensiva'];
    this._for_variante_ofensiva=obj['for_variante_ofensiva'];
    this._fun_en_corto=obj['fun_en_corto'];
    this._fun_ofe_mixta=obj['fun_ofe_mixta'];
    this._fun_en_largo=obj['fun_en_largo'];
    this._fun_combinativa_mixta=obj['fun_combinativa_mixta'];
    this._fun_directa=obj['fun_directa'];
    this._fun_presion_conjunta=obj['fun_presion_conjunta'];
    this._fun_presion_orientada_al_poseedor_rival_repliegue=obj['fun_presion_orientada_al_poseedor_rival_repliegue'];
    this._fun_repliegue=obj['fun_repliegue'];
    this._fun_contencion=obj['fun_contencion'];
    this._fun_presionante=obj['fun_presionante'];
    this._fun_def_mixta=obj['fun_def_mixta'];
    this._fun_juego_directo=obj['fun_juego_directo'];
    this._fun_contraataque=obj['fun_contraataque'];
    this._fun_ataque_organizado=obj['fun_ataque_organizado'];
    this._fun_velocidad_de_circulacion=obj['fun_velocidad_de_circulacion'];
    this._fun_progresion_del_balon=obj['fun_progresion_del_balon'];
    this._fun_velocidad_de_recuperacion=obj['fun_velocidad_de_recuperacion'];
    this._fun_amplio=obj['fun_amplio'];
    this._fun_moderado=obj['fun_moderado'];
    this._fun_reducido=obj['fun_reducido'];
    this._fun_amplia=obj['fun_amplia'];
    this._fun_moderada=obj['fun_moderada'];
    this._fun_reducida=obj['fun_reducida'];
  }

  //flutter: {name: edwdw, email: sdsdsdwd@1.com, mobileNo: 1234567789, feedback: wede}
  // Method to make GET parameters._key ,_jugador, _categoria, _equipo
  Map<String, dynamic> toJson() =>
      {
        "key": key,
        "email": _email,
        "fecha": _fecha,
        "temporada": _temporada,
        "pais": _pais,
        "categoria": _categoria,
        "equipo": _equipo,
        "entrenador": _entrenador,
        "fechaNacimiento": _fechaNacimiento,
        "fechaFichaje": _fechaFichaje,
        "fechaFinContrato": _fechaFinContrato,
        "nacionalidad": _nacionalidad,
        "paisNacimiento": _paisNacimiento,
        "ccaa": _ccaa,
        "scout": _scout,
        "activo": _activo,
        "observaciones" : _observaciones,
        "con_1442": _con_1442,
        "con_14411": _con_14411,
        "con_14231": _con_14231,
        "con_14141": _con_14141,
        "con_1343": _con_1343,
        "con_1352": _con_1352,
        "con_13421": _con_13421,
        "con_1532": _con_1532,
        "con_1451": _con_1451,
        "con_1541": _con_1541,
        "con_1433": _con_1433,
        "con_ofensivo": _con_ofensivo,
        "con_equilibrado": _con_equilibrado,
        "con_defensivo": _con_defensivo,
        "con_organizada_o_prevista": _con_organizada_o_prevista,
        "con_libre_o_imprevista": _con_libre_o_imprevista,
        "con_de_ajuste_o_gran_variabilidad" :con_de_ajuste_o_gran_variabilidad,
        "con_plan_unico_o_baja_variabilidad" :con_plan_unico_o_baja_variabilidad,
        "for_amplitud_ofensiva" :for_amplitud_ofensiva,
        "for_amplitud_defensiva" :for_amplitud_defensiva,
        "for_profundidad_ofensiva" :for_profundidad_ofensiva,
        "for_profundidad_defensiva" :for_profundidad_defensiva,
        "for_densidad_ofensiva" :for_densidad_ofensiva,
        "for_densidad_defensiva" :for_densidad_defensiva,
        "for_def_bloque_bajo" :for_def_bloque_bajo,
        "for_def_bloque_medio" :for_def_bloque_medio,
        "for_def_bloque_alto" :for_def_bloque_alto,
        "for_ofe_bloque_bajo" :for_ofe_bloque_bajo,
        "for_ofe_bloque_medio" :for_ofe_bloque_medio,
        "for_ofe_bloque_alto" :for_ofe_bloque_alto,
        "for_perifericos" :for_perifericos,
        "for_centralizados" :for_centralizados,
        "for_fija" :for_fija,
        "for_variable" :for_variable,
        "for_variante_defensiva": _for_variante_defensiva,
        "for_variante_ofensiva": _for_variante_ofensiva,
        "fun_en_corto": _fun_en_corto,
        "fun_ofe_mixta": _fun_ofe_mixta,
        "fun_en_largo": _fun_en_largo,
        "fun_combinativa_mixta": _fun_combinativa_mixta,
        "fun_directa": _fun_directa,
        "fun_presion_conjunta": _fun_presion_conjunta,
        "fun_presion_orientada_al_poseedor_rival_repliegue": _fun_presion_orientada_al_poseedor_rival_repliegue,
        "fun_repliegue": _fun_repliegue,
        "fun_contencion": _fun_contencion,
        "fun_presionante": _fun_presionante,
        "fun_def_mixta": _fun_def_mixta,
        "fun_juego_directo": _fun_juego_directo,
        "fun_contraataque": _fun_contraataque,
        "fun_ataque_organizado": _fun_ataque_organizado,
        "fun_velocidad_de_circulacion": _fun_velocidad_de_circulacion,
        "fun_progresion_del_balon": _fun_progresion_del_balon,
        "fun_velocidad_de_recuperacion": _fun_velocidad_de_recuperacion,
        "fun_amplio": _fun_amplio,
        "fun_moderado": _fun_moderado,
        "fun_reducido": _fun_reducido,
        "fun_amplia": _fun_amplia,
        "fun_moderada": _fun_moderada,
        "fun_reducida": _fun_reducida,
        'nombre': BBDDService()
            .getUserScout()
            .name,
        'email': BBDDService()
            .getUserScout()
            .email,
      };





  static bool dameElValor(String caracteristicas, Entrenador e) {
      print("dameelvalor:${caracteristicas}");
    if (caracteristicas == "1442")  return e._con_1442;
    if (caracteristicas == "14411")  return e._con_14411;
    if (caracteristicas == "14231")  return e._con_14231;
    if (caracteristicas == "14141")  return e._con_14141;
    if (caracteristicas == "1343")  return e._con_1343;
    if (caracteristicas == "1352")  return e._con_1352;
    if (caracteristicas == "13421")  return e._con_13421;
    if (caracteristicas == "1532")  return e._con_1532;
    if (caracteristicas == "1451")  return e._con_1451;
    if (caracteristicas == "1541")  return e._con_1541;
    if (caracteristicas == "1433")  return e._con_1433;
    if (caracteristicas == "Ofensivo")  return e._con_ofensivo;
    if (caracteristicas == "Equilibrado")  return e._con_equilibrado;
    if (caracteristicas == "Defensivo")  return e._con_defensivo;
    if (caracteristicas == "Organizada o prevista")  return e._con_organizada_o_prevista;
    if (caracteristicas == "Libre o imprevista")  return e._con_libre_o_imprevista;
    if (caracteristicas == "De ajuste o gran variabilidad")  return e._con_de_ajuste_o_gran_variabilidad;
    if (caracteristicas == "Plan único o baja variabilidad")  return e._con_plan_unico_o_baja_variabilidad;
    if (caracteristicas == "Amplitud ofensiva")  return e._for_amplitud_ofensiva;
    if (caracteristicas == "Amplitud defensiva")  return e._for_amplitud_defensiva;
    if (caracteristicas == "Profundidad ofensiva")  return e._for_profundidad_ofensiva;
    if (caracteristicas == "Profundidad defensiva")  return e._for_profundidad_defensiva;
    if (caracteristicas == "Densidad ofensiva")  return e._for_densidad_ofensiva;
    if (caracteristicas == "Densidad defensiva")  return e._for_densidad_defensiva;
      if (caracteristicas == "(D) Bloque bajo") return  e._for_def_bloque_bajo;
      if (caracteristicas == "(D) Bloque medio") return  e._for_def_bloque_medio;
      if (caracteristicas == "(D) Bloque alto")  return e._for_def_bloque_alto;
      if (caracteristicas == "(O) Bloque bajo")  return e._for_ofe_bloque_bajo;
      if (caracteristicas == "(O) Bloque medio") return  e._for_ofe_bloque_medio;
      if (caracteristicas == "(O) Bloque alto") return  e._for_ofe_bloque_alto;
      if (caracteristicas == "Perifericos")  return e._for_perifericos;
    if (caracteristicas == "Centralizados")  return e._for_centralizados;
    if (caracteristicas == "Fija") return  e._for_fija;
    if (caracteristicas == "Variable")  return e._for_variable;
    if (caracteristicas == "En corto")  return e._fun_en_corto;
    if (caracteristicas == "Ofe mixta")  return e._fun_ofe_mixta;
    if (caracteristicas == "En largo")  return e._fun_en_largo;
    if (caracteristicas == "Combinativa mixta")  return e._fun_combinativa_mixta;
    if (caracteristicas == "Directa")  return e._fun_directa;
    if (caracteristicas == "Presión conjunta")  return e._fun_presion_conjunta;
    if (caracteristicas == "Presión orientada al poseedor rival repliegue")  return e._fun_presion_orientada_al_poseedor_rival_repliegue;
    if (caracteristicas == "Repliegue")  return e._fun_repliegue;
    if (caracteristicas == "Contencion")  return e._fun_contencion;
    if (caracteristicas == "Presionante")  return e._fun_presionante;
    if (caracteristicas == "Def mixta")  return e._fun_def_mixta;
    if (caracteristicas == "Juego directo")  return e._fun_juego_directo;
    if (caracteristicas == "Contraataque")  return e._fun_contraataque;
    if (caracteristicas == "Ataque organizado")  return e._fun_ataque_organizado;
    if (caracteristicas == "Velocidad de circulación")  return e._fun_velocidad_de_circulacion;
    if (caracteristicas == "Progresión del balón")  return e._fun_progresion_del_balon;
    if (caracteristicas == "Velocidad de recuperación")  return e._fun_velocidad_de_recuperacion;
    if (caracteristicas == "Amplio")  return e._fun_amplio;
    if (caracteristicas == "Moderado")  return e._fun_moderado;
    if (caracteristicas == "Reducido")  return e._fun_reducido;
    if (caracteristicas == "Amplia") return   e._fun_amplia;
    if (caracteristicas == "Moderada") return   e._fun_moderada;
    if (caracteristicas == "Reducida")  return  e._fun_reducida;

  }

  static poneElValor(String caracteristicas, bool value, Entrenador e) {
    if (caracteristicas == "1442")   e._con_1442= value;
    if (caracteristicas == "14411")   e._con_14411= value;
    if (caracteristicas == "14231")   e._con_14231= value;
    if (caracteristicas == "14141")   e._con_14141= value;
    if (caracteristicas == "1343")   e._con_1343= value;
    if (caracteristicas == "1352")   e._con_1352= value;
    if (caracteristicas == "13421")   e._con_13421= value;
    if (caracteristicas == "1532")   e._con_1532= value;
    if (caracteristicas == "1451")   e._con_1451= value;
    if (caracteristicas == "1541")   e._con_1541= value;
    if (caracteristicas == "1433")   e._con_1433= value;
    if (caracteristicas == "Ofensivo")   e._con_ofensivo= value;
    if (caracteristicas == "Equilibrado")   e._con_equilibrado= value;
    if (caracteristicas == "Defensivo")   e._con_equilibrado= value;
    if (caracteristicas == "Organizada o prevista")   e._con_organizada_o_prevista= value;
    if (caracteristicas == "Libre o imprevista")   e._con_libre_o_imprevista= value;
    if (caracteristicas == "De ajuste o gran variabilidad")   e._con_de_ajuste_o_gran_variabilidad= value;
    if (caracteristicas == "Plan único o baja variabilidad")   e._con_plan_unico_o_baja_variabilidad= value;
    if (caracteristicas == "Amplitud ofensiva")   e._for_amplitud_ofensiva= value;
    if (caracteristicas == "Amplitud defensiva")   e._for_amplitud_defensiva= value;
    if (caracteristicas == "Profundidad ofensiva")   e._for_profundidad_ofensiva= value;
    if (caracteristicas == "Profundidad defensiva")   e._for_profundidad_defensiva= value;
    if (caracteristicas == "Densidad ofensiva")   e._for_densidad_ofensiva= value;
    if (caracteristicas == "Densidad defensiva")   e._for_densidad_defensiva= value;
    if (caracteristicas == "(D) Bloque bajo")   e._for_def_bloque_bajo= value;
    if (caracteristicas == "(D) Bloque medio")   e._for_def_bloque_medio= value;
    if (caracteristicas == "(D) Bloque alto")   e._for_def_bloque_alto= value;
    if (caracteristicas == "(O) Bloque bajo")   e._for_ofe_bloque_bajo= value;
    if (caracteristicas == "(O) Bloque medio")   e._for_ofe_bloque_medio= value;
    if (caracteristicas == "(O) Bloque alto")   e._for_ofe_bloque_alto= value;
    if (caracteristicas == "Perifericos")   e._for_perifericos= value;
    if (caracteristicas == "Centralizados")   e._for_centralizados= value;
    if (caracteristicas == "Fija")   e._for_fija= value;
    if (caracteristicas == "Variable")   e._for_variable= value;
    if (caracteristicas == "En corto")   e._fun_en_corto= value;
    if (caracteristicas == "Ofe mixta")   e._fun_ofe_mixta= value;
    if (caracteristicas == "En largo")   e._fun_en_largo= value;
    if (caracteristicas == "Combinativa mixta")   e._fun_combinativa_mixta= value;
    if (caracteristicas == "Directa")   e._fun_directa= value;
    if (caracteristicas == "Presión conjunta")   e._fun_presion_conjunta= value;
    if (caracteristicas == "Presión orientada al poseedor rival repliegue")   e._fun_presion_orientada_al_poseedor_rival_repliegue= value;
    if (caracteristicas == "Repliegue")   e._fun_repliegue= value;
    if (caracteristicas == "Contencion")   e._fun_contencion= value;
    if (caracteristicas == "Presionante")   e._fun_presionante= value;
    if (caracteristicas == "Def mixta")   e._fun_def_mixta= value;
    if (caracteristicas == "Juego directo")   e._fun_juego_directo= value;
    if (caracteristicas == "Contraataque")   e._fun_contraataque= value;
    if (caracteristicas == "Ataque organizado")   e._fun_ataque_organizado= value;
    if (caracteristicas == "Velocidad de circulación")   e._fun_velocidad_de_circulacion= value;
    if (caracteristicas == "Progresión del balón")   e._fun_progresion_del_balon= value;
    if (caracteristicas == "Velocidad de recuperación")   e._fun_velocidad_de_recuperacion= value;
    if (caracteristicas == "Amplio")   e._fun_amplio= value;
    if (caracteristicas == "Moderado")   e._fun_moderado= value;
    if (caracteristicas == "Reducido")   e._fun_reducido= value;
    if (caracteristicas == "Amplia")   e._fun_amplia= value;
    if (caracteristicas == "Moderada")   e._fun_moderada= value;
    if (caracteristicas == "Reducida")   e._fun_reducida= value;
  }

  static List<String> estructuralHabitual = <String>
  [ '1442',
    '14411',
    '14231',
    '14141',
    '1433',
    '1451',
    '1343',
    '13421',
    '1352',
    '1532',
    '1541'];

  static List<String> planteamientoTacticoGeneral = <String>
  [
  'Ofensivo',
  'Equilibrado',
  'Defensivo',
  ];

  static List<String> estructuracionJuegoColectivo = <String>
  [
    'Organizada o prevista',
    'Libre o imprevista'];

  static List<String> adaptabilidadJuegoColectivo = <String>
  [
    'De ajuste o gran variabilidad',
    'Plan único o baja variabilidad'];

  static List<String> ocupacionRacionalEspacio = <String>
  ['Amplitud ofensiva',
    'Profundidad ofensiva',
    'Densidad ofensiva',
    'Amplitud defensiva',
    'Profundidad defensiva',
    'Densidad defensiva'];


  static List<String> asentamientoDefensivo = <String>
  [
    '(D) Bloque bajo',
    '(D) Bloque medio',
    '(D) Bloque alto'];


  static List<String> asentamientoOfensivo = <String>
  [
  '(O) Bloque bajo',
  '(O) Bloque medio',
  '(O) Bloque alto'];

  static List<String> espaciosdeintervencion= <String>
  [
    'Perifericos',//  e._for_perifericos= value;
    'Centralizados'];

  static List<String> dinamicaPosicional = <String>
  [
    'Fija',
    'Variable'];

  static List<String> inicioDeJuego = <String>[
  'En corto',//  e._fun_en_corto= value;
  'Ofe mixta',//  e._fun_ofe_mixta= value;
  'En largo'];

  static List<String> progresionFinalizacioJuego
  = <String>
  [
    'Combinativa mixta',//  e._fun_combinativa_mixta= value;
    'Directa'];

  static List<String> transicionesDefensivas
  = <String>
  [
    'Presión conjunta',//  e._fun_presion_conjunta= value;
    'Presión orientada al poseedor rival repliegue',//  e._fun_presion_orientada_al_poseedor_rival_repliegue= value;
    'Repliegue'];

  static List<String> juegoDefensivo
  = <String>
  [
    'Contencion',//  e._fun_contencion= value;
    'Presionante',//  e._fun_presionante= value;
    'Def mixta'];

  static List<String> transicionesOfensivas
  = <String>
  [
    'Juego directo',//  e._fun_juego_directo= value;
    'Contraataque',//  e._fun_contraataque= value;
    'Ataque organizado'];

  static List<String> ritmosDeJuego
  = <String>
  [
    'Velocidad de circulación',//  e._fun_velocidad_de_circulacion= value;
    'Progresión del balón',//  e._fun_progresion_del_balon= value;
    'Velocidad de recuperación'];

  static List<String> gradosDeLibertad
  = <String>
  [
    'Amplio',//  e._fun_amplio= value;
    'Moderado',//  e._fun_moderado= value;
    'Reducido'];

  static List<String> variabilidadEstrategeciaLocalVisitante
  = <String>
  [
    'Amplia',//  e._fun_amplio= value;
    'Moderada',//  e._fun_moderado= value;
    'Reducida'];


  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

  String get temporada => _temporada;

  set temporada(String value) {
    _temporada = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get equipo => _equipo;

  set equipo(String value) {
    _equipo = value;
  }

  String get entrenador => _entrenador;

  set entrenador(String value) {
    _entrenador = value;
  }

  String get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(String value) {
    _fechaNacimiento = value;
  }

  String get fechaFichaje => _fechaFichaje;

  set fechaFichaje(String value) {
    _fechaFichaje = value;
  }

  String get fechaFinContrato => _fechaFinContrato;

  set fechaFinContrato(String value) {
    _fechaFinContrato = value;
  }

  String get nacionalidad => _nacionalidad;

  set nacionalidad(String value) {
    _nacionalidad = value;
  }

  String get paisNacimiento => _paisNacimiento;

  set paisNacimiento(String value) {
    _paisNacimiento = value;
  }

  String get ccaa => _ccaa;

  set ccaa(String value) {
    _ccaa = value;
  }

  String get scout => _scout;

  set scout(String value) {
    _scout = value;
  }

  String get activo => _activo;

  set activo(String value) {
    _activo = value;
  }

  String get observaciones => _observaciones;

  set observaciones(String value) {
    _observaciones = value;
  }

  bool get con_1442 => _con_1442;

  set con_1442(bool value) {
    _con_1442 = value;
  }

  bool get con_14411 => _con_14411;

  set con_14411(bool value) {
    _con_14411 = value;
  }

  bool get con_14231 => _con_14231;

  set con_14231(bool value) {
    _con_14231 = value;
  }

  bool get con_14141 => _con_14141;

  set con_14141(bool value) {
    _con_14141 = value;
  }

  bool get con_1343 => _con_1343;

  set con_1343(bool value) {
    _con_1343 = value;
  }

  bool get con_1352 => _con_1352;

  set con_1352(bool value) {
    _con_1352 = value;
  }

  bool get con_13421 => _con_13421;

  set con_13421(bool value) {
    _con_13421 = value;
  }

  bool get con_1532 => _con_1532;

  set con_1532(bool value) {
    _con_1532 = value;
  }

  bool get con_1451 => _con_1451;

  set con_1451(bool value) {
    _con_1451 = value;
  }

  bool get con_1541 => _con_1541;

  set con_1541(bool value) {
    _con_1541 = value;
  }

  bool get con_1433 => _con_1433;

  set con_1433(bool value) {
    _con_1433 = value;
  }

  bool get con_ofensivo => _con_ofensivo;

  set con_ofensivo(bool value) {
    _con_ofensivo = value;
  }

  bool get con_equilibrado => _con_equilibrado;

  set con_equilibrado(bool value) {
    _con_equilibrado = value;
  }

  bool get con_defensivo => _con_defensivo;

  set con_defensivo(bool value) {
    _con_defensivo = value;
  }

  bool get con_organizada_o_prevista => _con_organizada_o_prevista;

  set con_organizada_o_prevista(bool value) {
    _con_organizada_o_prevista = value;
  }

  bool get con_libre_o_imprevista => _con_libre_o_imprevista;

  set con_libre_o_imprevista(bool value) {
    _con_libre_o_imprevista = value;
  }

  bool get con_de_ajuste_o_gran_variabilidad =>
      _con_de_ajuste_o_gran_variabilidad;

  set con_de_ajuste_o_gran_variabilidad(bool value) {
    _con_de_ajuste_o_gran_variabilidad = value;
  }

  bool get con_plan_unico_o_baja_variabilidad =>
      _con_plan_unico_o_baja_variabilidad;

  set con_plan_unico_o_baja_variabilidad(bool value) {
    _con_plan_unico_o_baja_variabilidad = value;
  }

  bool get for_amplitud_ofensiva => _for_amplitud_ofensiva;

  set for_amplitud_ofensiva(bool value) {
    _for_amplitud_ofensiva = value;
  }

  bool get for_amplitud_defensiva => _for_amplitud_defensiva;

  set for_amplitud_defensiva(bool value) {
    _for_amplitud_defensiva = value;
  }

  bool get for_profundidad_ofensiva => _for_profundidad_ofensiva;

  set for_profundidad_ofensiva(bool value) {
    _for_profundidad_ofensiva = value;
  }

  bool get for_profundidad_defensiva => _for_profundidad_defensiva;

  set for_profundidad_defensiva(bool value) {
    _for_profundidad_defensiva = value;
  }

  bool get for_densidad_ofensiva => _for_densidad_ofensiva;

  set for_densidad_ofensiva(bool value) {
    _for_densidad_ofensiva = value;
  }

  bool get for_densidad_defensiva => _for_densidad_defensiva;

  set for_densidad_defensiva(bool value) {
    _for_densidad_defensiva = value;
  }

  bool get for_def_bloque_bajo => _for_def_bloque_bajo;

  set for_def_bloque_bajo(bool value) {
    _for_def_bloque_bajo = value;
  }

  bool get for_def_bloque_medio => _for_def_bloque_medio;

  set for_def_bloque_medio(bool value) {
    _for_def_bloque_medio = value;
  }

  bool get for_def_bloque_alto => _for_def_bloque_alto;

  set for_def_bloque_alto(bool value) {
    _for_def_bloque_alto = value;
  }

  bool get for_ofe_bloque_bajo => _for_ofe_bloque_bajo;

  set for_ofe_bloque_bajo(bool value) {
    _for_ofe_bloque_bajo = value;
  }

  bool get for_ofe_bloque_medio => _for_ofe_bloque_medio;

  set for_ofe_bloque_medio(bool value) {
    _for_ofe_bloque_medio = value;
  }

  bool get for_ofe_bloque_alto => _for_ofe_bloque_alto;

  set for_ofe_bloque_alto(bool value) {
    _for_ofe_bloque_alto = value;
  }

  bool get for_perifericos => _for_perifericos;

  set for_perifericos(bool value) {
    _for_perifericos = value;
  }

  bool get for_centralizados => _for_centralizados;

  set for_centralizados(bool value) {
    _for_centralizados = value;
  }

  bool get for_fija => _for_fija;

  set for_fija(bool value) {
    _for_fija = value;
  }

  bool get for_variable => _for_variable;

  set for_variable(bool value) {
    _for_variable = value;
  }

  String get for_variante_defensiva => _for_variante_defensiva;

  set for_variante_defensiva(String value) {
    _for_variante_defensiva = value;
  }

  String get for_variante_ofensiva => _for_variante_ofensiva;

  set for_variante_ofensiva(String value) {
    _for_variante_ofensiva = value;
  }

  bool get fun_en_corto => _fun_en_corto;

  set fun_en_corto(bool value) {
    _fun_en_corto = value;
  }

  bool get fun_ofe_mixta => _fun_ofe_mixta;

  set fun_ofe_mixta(bool value) {
    _fun_ofe_mixta = value;
  }

  bool get fun_en_largo => _fun_en_largo;

  set fun_en_largo(bool value) {
    _fun_en_largo = value;
  }

  bool get fun_combinativa_mixta => _fun_combinativa_mixta;

  set fun_combinativa_mixta(bool value) {
    _fun_combinativa_mixta = value;
  }

  bool get fun_directa => _fun_directa;

  set fun_directa(bool value) {
    _fun_directa = value;
  }

  bool get fun_presion_conjunta => _fun_presion_conjunta;

  set fun_presion_conjunta(bool value) {
    _fun_presion_conjunta = value;
  }

  bool get fun_presion_orientada_al_poseedor_rival_repliegue =>
      _fun_presion_orientada_al_poseedor_rival_repliegue;

  set fun_presion_orientada_al_poseedor_rival_repliegue(bool value) {
    _fun_presion_orientada_al_poseedor_rival_repliegue = value;
  }

  bool get fun_repliegue => _fun_repliegue;

  set fun_repliegue(bool value) {
    _fun_repliegue = value;
  }

  bool get fun_contencion => _fun_contencion;

  set fun_contencion(bool value) {
    _fun_contencion = value;
  }

  bool get fun_presionante => _fun_presionante;

  set fun_presionante(bool value) {
    _fun_presionante = value;
  }

  bool get fun_def_mixta => _fun_def_mixta;

  set fun_def_mixta(bool value) {
    _fun_def_mixta = value;
  }

  bool get fun_juego_directo => _fun_juego_directo;

  set fun_juego_directo(bool value) {
    _fun_juego_directo = value;
  }

  bool get fun_contraataque => _fun_contraataque;

  set fun_contraataque(bool value) {
    _fun_contraataque = value;
  }

  bool get fun_ataque_organizado => _fun_ataque_organizado;

  set fun_ataque_organizado(bool value) {
    _fun_ataque_organizado = value;
  }

  bool get fun_velocidad_de_circulacion => _fun_velocidad_de_circulacion;

  set fun_velocidad_de_circulacion(bool value) {
    _fun_velocidad_de_circulacion = value;
  }

  bool get fun_progresion_del_balon => _fun_progresion_del_balon;

  set fun_progresion_del_balon(bool value) {
    _fun_progresion_del_balon = value;
  }

  bool get fun_velocidad_de_recuperacion => _fun_velocidad_de_recuperacion;

  set fun_velocidad_de_recuperacion(bool value) {
    _fun_velocidad_de_recuperacion = value;
  }

  bool get fun_amplio => _fun_amplio;

  set fun_amplio(bool value) {
    _fun_amplio = value;
  }

  bool get fun_moderado => _fun_moderado;

  set fun_moderado(bool value) {
    _fun_moderado = value;
  }

  bool get fun_reducido => _fun_reducido;

  set fun_reducido(bool value) {
    _fun_reducido = value;
  }

  bool get fun_reducida => _fun_reducida;

  set fun_reducida(bool value) {
    _fun_reducida = value;
  }

  bool get fun_moderada => _fun_moderada;

  set fun_moderada(bool value) {
    _fun_moderada = value;
  }

  bool get fun_amplia => _fun_amplia;

  set fun_amplia(bool value) {
    _fun_amplia = value;
  }
}