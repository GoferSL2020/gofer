import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:intl/intl.dart';

class Player {

  Player();

  String key="";
  String _email = "";
  String _fecha = "";
  String _nombre = "";
  String _jugador = "";
  String _equipo = "";
  String _categoria = "";
  String _competecion = "";
  String _seleccion = "";
  String _pais = "";
  String _posicion = "";
  String _posicion2 = "";
  String _imagen = "";
  String _nivel = "";
  String _nivel2 = "";
  String _nivel3 = "";
  String _nivel4 = "";
  String _tipo = "";
  String _tipoAntiguo = "";
  int _dorsal = 0;
  String _fechaContrato = "";
  String _peso = "";
  String _altura = "";
  String _valor = "";
  String _paisNacimiento = "";
  String _contrato = "";
  String _ccaa = "";
  String _nacionalidad = "";
  String _nacionalidad2 = "";
  String _posicionalternativa = "";
  String _temporada = "";
  String _categoriaEdad = "";
  String _veredicto = "";
  String _prestamo = "";
  String _lateral = "unknown";
  String _foto = "";
  String _observaciones = "";
  String _comentarios = "";
  String _descripcion = "";
  String _scouter = "";
  String _contacto = "";
  String _agente = "";
  String _fechaNacimiento = "";
  bool _firmado = false;
  bool _proceso=false;
  String _contratoRepresentacion="";
  String _contratoFederacion="";
  String _contratoProteccionDatos="";
  String _servicioComunicacion="";
  String _fechaVencimientoContrato = "";
  String _contratoMarcaDeportiva="";
  String _marcaDeportiva="";
  int _calzado=0;
  String _fechaFinalizacionMarca = "";

  int _edadRange1=0;
  int _edadRange2=0;

  String _puntaciones = "";
  String _estado = "";
  bool _estrella = false;
  int jornada = 0;

  String _idCategoria = "";
  String _idTemporada = "";
  String _idPais = "";
  String _idEquipo = "";
  
  String _reunion = "";

  String _twitter = "";
  String _instagram = "";

  String _apodo="";
  String _catCantera="";

  String _transfermark="";


  String _rendimiento = "";


  String get rendimiento => _rendimiento;

  set rendimiento(String value) {
    _rendimiento = value;
  }


  String get transfermark => _transfermark;

  set transfermark(String value) {
    _transfermark = value;
  }

  String get twitter => _twitter;

  set twitter(String value) {
    _twitter = value;
  }

  String foto() {
    return
      this._jugador.replaceAll("à", "a")
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


  String get contratoRepresentacion => _contratoRepresentacion;

  set contratoRepresentacion(String value) {
    _contratoRepresentacion = value;
  }

  String get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(String value) {
    _fechaNacimiento = value;
  }

  String get categoriaEdad {
    return Config.edadCategoria(fechaNacimiento);
  }


  String get categoriaEdadBBDD {
    return Config.edadCategoriaBBDD(fechaNacimiento,categoria);
  }


  set categoriaEdad(String value) {
    _categoriaEdad = value;
  }


  String get seleccion => _seleccion;

  set seleccion(String value) {
    _seleccion = value;
  }

  String get competecion => _competecion;

  set competecion(String value) {
    _competecion = value;
  }



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["categoria"] = _categoria;
    map["competecion"] = _competecion;
    map["seleccion"] = seleccion;

    map["equipo"] = _equipo;
    map["jugador"] = _jugador;
    map["apodo"] = _apodo;
    map["fechaNacimiento"] = _fechaNacimiento;

    map["nivel"] = _nivel;
    map["nivel2"] = _nivel2;
    map["nivel3"] = _nivel3;
    map["nivel4"] = _nivel4;
    map["tipo"] = _tipo;
    map["fechaContrato"] = _fechaContrato;
    map["dorsal"] = _dorsal;
    map["peso"] = _peso;
    map["altura"] = _altura;
    map["valor"] = _valor;
    map["paisNacimiento"] = _paisNacimiento;
    map["contrato"] = _contrato;
    map["contacto"] = _contacto;
    map["agente"] = _agente;
    map["reunion"] = _reunion;
    map["rendimiento"] = _rendimiento;
    map["instagram"] = _instagram;
    map["proceso"] = _proceso;

    map["twitter"] = _twitter;
    map["transfermark"] = _transfermark;

    map["catCantera"] = _catCantera;

    map["lateral"] = _lateral;
    map['ccaa'] = _ccaa;
    map['nacionalidad'] = _nacionalidad;
    map["posicion"] = _posicion;
    map['posicionalternativa'] = _posicionalternativa;

    map["observaciones"] = _observaciones == null ? "" : observaciones;
    map["comentarios"] = _comentarios == null ? "" : _comentarios;
    map["descripcion"] = _descripcion == null ? "" : _descripcion;

    map["pais"] = _pais;
    map["idCategoria"] = _idCategoria;
    map["idTemporada"] = _idTemporada;
    map["idPais"] = _idPais;
    map["scouter"] = _scouter;
    map["firmado"] = _firmado;
    map["idEquipo"] = _idEquipo;

   map['contratoRepresentacion']=this._contratoRepresentacion;
    map['contratoFederacion']=this._contratoFederacion;
    map['contratoProteccionDatos']=this._contratoProteccionDatos;
   map['servicioComunicacion']= this._servicioComunicacion;
    map['fechaVencimientoContrato']=this._fechaVencimientoContrato;
    map['contratoMarcaDeportiva']=this._contratoMarcaDeportiva;
    map['contratoFederacion']=this._contratoFederacion;
   map['marcaDeportiva']= this._marcaDeportiva;
    map['calzado']=this._calzado;
   map['fechaFinalizacionMarca']= this._fechaFinalizacionMarca;


    return map;
  }


  Player.fromJson(this.key, Map obj) {
    key = this.key;
    // obj['_fis_envergadura']
    this._categoria = obj['categoria'];
    this._competecion= obj['competecion'];
    this._seleccion= obj['seleccion'];

    this._equipo = obj['equipo'];
    this._imagen = obj['imagen'];
    this._jugador = obj['jugador'];
    this._fechaNacimiento = obj['fechaNacimiento'];
    this._nivel = obj['nivel'].toString();
    this._nivel2 = obj['nivel2'].toString();
    this._nivel3 = obj['nivel3'].toString();
    this._nivel4 = obj['nivel4'].toString();
    this._tipo = obj['tipo'].toString();
    this._tipoAntiguo = obj['tipoAntiguo'].toString();

    this._scouter = obj['scouter'];
    this._firmado = obj['firmado'];

    this._contratoRepresentacion = obj['contratoRepresentacion'];
    this._contratoFederacion = obj['contratoFederacion'];
    this._contratoProteccionDatos = obj['contratoProteccionDatos'];
    this._servicioComunicacion = obj['servicioComunicacion'];
    this._fechaVencimientoContrato = obj['fechaVencimientoContrato'];
    this._contratoMarcaDeportiva = obj['contratoMarcaDeportiva'];
    this._marcaDeportiva = obj['marcaDeportiva'];
    this._calzado = obj['calzado'];
    this._fechaFinalizacionMarca = obj['fechaFinalizacionMarca'];

    this._fechaContrato = obj['fechaContrato'];
    this._dorsal = obj['dorsal'];
    this._peso = obj['peso'];
    this._altura = obj['altura'];
    this._valor = obj['valor'];
    this._paisNacimiento = obj['paisNacimiento'];
    this._contrato = obj['contrato'];
    this._contacto = obj['contacto'];
    this._agente = obj['agente'];

    this._veredicto = obj['veredicto'] == null ? "" : obj['veredicto'];
    this._prestamo = obj['prestamo'];
    this._lateral = obj['lateral'];

    this._reunion = obj['reunion'];
    this._rendimiento = obj['rendimiento'];
    this._instagram = obj['instagram'];
    this._proceso = obj['proceso']==null?false:obj['proceso'];

    this._twitter = obj['twitter'];
    this._transfermark = obj['transfermark'];

    this._apodo = obj['apodo'];
    this._catCantera = obj['catCantera'];

    this._ccaa = obj['ccaa'];
    this._nacionalidad = obj['nacionalidad'];
    this._nacionalidad2 = obj['nacionalidad2'];
    this._posicionalternativa = obj['posicionalternativa'];

    this._observaciones = obj['observaciones'];
    this._descripcion = obj['descripcion'];
    this._comentarios = obj['comentarios'];

    this._pais = obj['pais'];
    this._posicion = obj['posicion'];

    this._idCategoria = obj['idCategoria'];
    this._idTemporada = obj['idTemporada'];
    this._idPais = obj['idPais'];
    this._idEquipo = obj['idEquipo'];
    this._nombre = obj['nombre'];
    this._email = obj['email'];

  }

  //flutter: {name: edwdw, email: sdsdsdwd@1.com, mobileNo: 1234567789, feedback: wede}
  // Method to make GET parameters._key ,_jugador, _categoria, _equipo
  Map<String, dynamic> toJson() =>
      {
        "__name": idjugador,
        "name": idjugador,
        "categoria": _categoria,
        "competecion": _competecion,
        "seleccion": _seleccion,
        "equipo": _equipo,
        "jugador": _jugador,
        "fechaNacimiento": _fechaNacimiento == null ? "" : _fechaNacimiento,
        "temporada": _temporada,
        "nivel": _nivel,
        "nivel2": _nivel2,
        "nivel3": _nivel3,
        "nivel4": _nivel4,
        "tipo": _tipo,
        "fechaContrato": _fechaContrato,
        "dorsal": _dorsal,
        "peso": _peso,
        "valor": _valor,
        "paisNacimiento": _paisNacimiento,
        "contrato": _contrato,
        "lateral": _lateral,
        "scouter": _scouter,
        "firmado": _firmado,
        'contratoRepresentacion': _contratoRepresentacion,
        'contratoFederacion': _contratoFederacion,
        'contratoProteccionDatos': _contratoProteccionDatos,
        'servicioComunicacion' :_servicioComunicacion,
        'fechaVencimientoContrato': _fechaVencimientoContrato,
        'contratoMarcaDeportiva': _contratoMarcaDeportiva,
        'marcaDeportiva': _marcaDeportiva,
        'calzado': _calzado,
        'apodo': _apodo,
        'catCantera': _catCantera,
  'fechaFinalizacionMarca':_fechaFinalizacionMarca,
        "edadCategoria": edadCategoria(),
        "nacionalidad": _nacionalidad,
        "nacionalidad2": _nacionalidad2,
        "posicionalternativa": _posicionalternativa,
        "pais": _pais,
        "posicion": _posicion,
        "posicion2": _posicion2,
        "idCategoria": _idCategoria,
        "idTemporada": _idTemporada,
        "idPais": _idPais,
        "idEquipo": _idEquipo,
        "contacto": _contacto,
        "agente": _agente,
        "reunion": _reunion,
        "rendimiento": _rendimiento,

        'nombre': BBDDService()
            .getUserScout()
            .name,
        'email': BBDDService()
            .getUserScout()
            .email,
      };


  Map<String, dynamic> toJsonScouting() =>
      {
        "nivel": _nivel,
        "nivel2": _nivel2,
        "nivel3": _nivel3,
        "nivel4": _nivel4,
        "tipo": _tipo,
        "veredicto": _veredicto,
        "lateral": _lateral,
        "scouter": _scouter,
        "firmado": _firmado,
        "contacto": _contacto,
        "agente": _agente,
        "reunion": _reunion,
        "rendimiento": _rendimiento,
        "instagram": _instagram,
        "proceso" :_proceso,
        "twitter": _twitter,
        "transfermark":_transfermark,

  'apodo': _apodo,
        'catCantera': _catCantera,
        "edadCategoria": edadCategoria(),
        "observaciones": _observaciones == null ? "" : observaciones,
  "descripcion": _descripcion == null ? "" : _descripcion,
  "comentarios": _comentarios == null ? "" : _comentarios,


        'nombre': BBDDService()
            .getUserScout()
            .name,
        'email': BBDDService()
            .getUserScout()
            .email,
      };


  //flutter: {name: edwdw, email: sdsdsdwd@1.com, mobileNo: 1234567789, feedback: wede}
  // Method to make GET parameters._key ,_jugador, _categoria, _equipo
  Map<String, dynamic> toTodoJson() =>
      {
        "__name": idjugador,
        "temporada": _temporada,
        "categoria": _categoria,
        "competecion": _competecion,
        "seleccion": _seleccion,

        "equipo": _equipo,
        "jugador": _jugador,
        "name": idjugador,
        "fechaNacimiento": _fechaNacimiento,
        "nivel": _nivel,
        "nivel2": _nivel2,
        "nivel3": _nivel3,
        "nivel4": _nivel4,
        "scouter": _scouter,
        "firmado": _firmado,
        "tipo": _tipo,
        "fechaContrato": _fechaContrato,
        "dorsal": _dorsal,
        "peso": _peso,
        "contacto": _contacto,
        "agente": _agente,
        "reunion": _reunion,
        "rendimiento": _rendimiento,
        "altura": _altura,
        "valor": _valor,
        "paisNacimiento": _paisNacimiento,
        "twitter": _twitter,
        "transfermark":_transfermark,
        'apodo': _apodo,
        'catCantera': _catCantera,
        "instagram": _instagram,
        "proceso": _proceso,
        "edadCategoria": edadCategoria(),
        "contrato": _contrato,
        "veredicto": _veredicto,
        "prestamo": _prestamo,
        "lateral": _lateral,
        "ccaa": _ccaa,
        "nacionalidad": _nacionalidad,
        "nacionalidad2": _nacionalidad2,
        'contratoRepresentacion': _contratoRepresentacion,
        'contratoFederacion': _contratoFederacion,
        'contratoProteccionDatos': _contratoProteccionDatos,
        'servicioComunicacion' :_servicioComunicacion,
        'fechaVencimientoContrato': _fechaVencimientoContrato,
        'contratoMarcaDeportiva': _contratoMarcaDeportiva,
        'marcaDeportiva': _marcaDeportiva,
        'calzado': _calzado,
        'fechaFinalizacionMarca':_fechaFinalizacionMarca,
        "posicionalternativa": _posicionalternativa,
        "pais": _pais,
        "posicion": _posicion,
        "posicion2": _posicion2,
        'nombre': BBDDService()
            .getUserScout()
            .name,
        'email': BBDDService()
            .getUserScout()
            .email,
        "nivel": _nivel,
        "nivel2": _nivel2,
        "nivel3": _nivel3,
        "nivel4": _nivel4,
        "tipo": _tipo,
        "veredicto": _veredicto,
        "lateral": _lateral,
        "observaciones": _observaciones == null ? "" : observaciones,
  "descripcion": _descripcion == null ? "" : _descripcion,
  "comentarios": _comentarios == null ? "" : _comentarios,


"idCategoria": _idCategoria,
        "idTemporada": _idTemporada,
        "idPais": _idPais,
        "idEquipo": _idEquipo,

        'nombre': BBDDService()
            .getUserScout()
            .name,
        'email': BBDDService()
            .getUserScout()
            .email,
      };

  Map<String, dynamic> toJsonpuntaciones() =>
      {
        "key": key,
        "id": key,
        "jugador": _jugador,
        "equipo": _equipo,
        "categoria": _categoria,
        "competecion": _competecion,
        "seleccion": _seleccion,

        "posicion": _posicion,
        "puntuacion": _puntaciones,
        "estrella": _estrella,
        "estado": _estado,
        "fechaNacimiento": _fechaNacimiento,
        'nombre': BBDDService()
            .getUserScout()
            .name,
        'fecha': DateTime.now(),
      };



  String get idjugador {
    return _temporada == 2020 - 2021 ?
    (_jugador + _posicion).toUpperCase()
        .replaceAll(" ", "")
        .replaceAll("É", "E")
        .replaceAll("Í", "I")
        .replaceAll("Ó", "O")
        .replaceAll("Ú", "U")
        .replaceAll("Á", "A")
        .replaceAll(".", "")
        .replaceAll("n", "N") :
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


  set idJugador(String value) {
    this.idJugador = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }


  int puntacionNivel(String nivelAux) {
    if (nivelAux.toUpperCase() == "Superlativo".toUpperCase())
      return 6; //0,176,80
    if (nivelAux.toUpperCase() == "Superior".toUpperCase())
      return 5; //172,243,13
    if (nivelAux.toUpperCase() == "Destacado".toUpperCase())
      return 4; //Colors.blue;//245,234,11
    if (nivelAux.toUpperCase() == "Intermedio".toUpperCase())
      return 3; //Colors.yellow;//246,128,10
    if (nivelAux.toUpperCase() == "Dudoso".toUpperCase())
      return 2; //Colors.orange;//248,25,8
    if (nivelAux.toUpperCase() == "Discreto".toUpperCase())
      return 1; //Colors.red.shade900;//193,20,7
    if (nivelAux.toUpperCase() == "N/A".toUpperCase())
      return 0; //Colors.red.shade900;//193,20,7
    return -1; //Colors.red.shade900;//193,20,7
  }

  Color getColor() {
    List<int> niveles = [];
    niveles.add(puntacionNivel(_nivel));
    niveles.add(puntacionNivel(_nivel2));
    niveles.add(puntacionNivel(_nivel3));
    niveles.add(puntacionNivel(_nivel4));
    niveles.sort();
    int nivelColor = niveles.last;
    if (nivelColor == 6) return Color.fromRGBO(0, 176, 80, 1); //0,176,80
    if (nivelColor == 5) return Color.fromRGBO(172, 243, 13, 1); //172,243,13
    if (nivelColor == 4)
      return Color.fromRGBO(245, 234, 11, 1); //Colors.blue;//245,234,11
    if (nivelColor == 3)
      return Color.fromRGBO(246, 128, 10, 1); //Colors.yellow;//246,128,10
    if (nivelColor == 2)
      return Color.fromRGBO(169, 11, 145, 1); //purple
    if (nivelColor == 1)
      return Color.fromRGBO(193, 20, 7, 1); //Colors.red.shade900;//193,20,7
    if (nivelColor == 0)
      return Color.fromRGBO(189, 243, 249, 1); //Colors.red.shade900;//193,20,7
    if (nivelColor == -1) return Colors.grey; //Colors.red.shade900;//193,20,7

    return Colors.grey; //Colors.grey;//189,243,249
  }

  static Color nivelColor(String nivelAux) {
    print(nivelAux);
    if (nivelAux.toUpperCase() == "Top".toUpperCase())
      return Color.fromRGBO(0, 176, 80, 1); //0,176,80
    if (nivelAux.toUpperCase() == "Destacado".toUpperCase())
      return Color.fromRGBO(172, 243, 13, 1); //172,243,13
    if (nivelAux.toUpperCase() == "Acorde a la categoría".toUpperCase())
      return Color.fromRGBO(245, 234, 11, 1); //Colors.blue;//245,234,11
    if (nivelAux.toUpperCase() == "Discreto".toUpperCase())
      return Color.fromRGBO(246, 128, 10, 1); //Colors.yellow;//246,128,10
    if (nivelAux.toUpperCase() == "No ha jugado".toUpperCase())
      return Color.fromRGBO(251, 54, 221, 1); //Colors.orange;//248,25,8
    if (nivelAux.toUpperCase() == "Discreto".toUpperCase())
      return Color.fromRGBO(193, 20, 7, 1); //Colors.red.shade900;//193,20,7
    if (nivelAux.toUpperCase() == "N/A".toUpperCase())
      return Color.fromRGBO(189, 243, 249, 1); //Colors.red.shade900;//193,20,7

    return Colors.white; //Colors.grey;//189,243,249
  }


  static Color nivelColorSuperlativo(String nivelAux) {
    return Color.fromRGBO(0, 176, 80, 1); //0,176,80
  }

  static Color nivelColorSuperior(String nivelAux) {
    return Color.fromRGBO(172, 243, 13, 1); //172,243,13
  }

  static Color nivelColorDestacado(String nivelAux) {
    return Color.fromRGBO(245, 234, 11, 1); //Colors.blue;//245,234,11
  }

  static Color nivelColorIntermedio(String nivelAux) {
    return Color.fromRGBO(246, 128, 10, 1); //Colors.yellow;//246,128,10
  }

  static Color nivelColorDudoso(String nivelAux) {
    return Color.fromRGBO(251, 54, 221, 1); //Colors.orange;//248,25,8
  }

  static Color nivelColorBajo(String nivelAux) {
    return Color.fromRGBO(193, 20, 7, 1); //Colors.red.shade900;//193,20,7
  }

  static Color nivelColorNA(String nivelAux) {
    return Color.fromRGBO(189, 243, 249, 1); //Colors.red.shade900;//193,20,7
  }


  Map<String, dynamic> toGsheets() {
    DateTime today = new DateTime.now();
    String dateSlug = "${today.year.toString()}-${today.month.toString()
        .padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    return {
      "ID": key,
      "FIRMADO": firmado,
      "PROCESO": proceso,
      "AGENTE FOOTFEEL": _scouter,
      "PAIS": _pais,
      "JUGADOR": _jugador,
      "EQUIPO": _equipo,
      "COMPETECIÓN": _competecion,
      "CATEGORIA": _categoria + " "+ _catCantera,
      "SELECCIÓN": _seleccion,
      "FECHA NACIMIENTO": _fechaNacimiento,
      "EDAD CATEGORIA": edadCategoria(),
      "POSICION": _posicion,
      "POSICION ALTERNATIVA": _posicionalternativa,
      "LATERAL": _lateral,
      "PESO": _peso,
      "ALTURA": _altura,
      "NACIONALIDAD 1": _nacionalidad,
      "NACIONALIDAD 2": _nacionalidad2,
      "CONTRATO REPRESENTACION": _contratoRepresentacion,
      "FECHA VENCIMIENTO CONTRATO": fechaVencimientoContrato,
      "CONTRATO FEDERACIÓN": _contratoFederacion,
      'CONTRATO PROTECCIÓN DATOS': _contratoProteccionDatos,
      'SERVICIO COMUNICACIÓN': _servicioComunicacion,
      'INSTAGRAM': _instagram,
      'TWITTER' :_twitter,
      'TRANSFERMARK': _transfermark,
      'CONTRATO MARCA DEPORTIVA': _contratoMarcaDeportiva,
      'MARCA DEPORTIVA': _marcaDeportiva,
      'CALZADO': _calzado,
      'FECHA FINALIZACIÓN MARCA':_fechaFinalizacionMarca,
      "FECHA FINALIZACION CLUB": _fechaContrato,
      "PERIODO 1": _nivel,
      "PERIODO 2": _nivel2,
      "RENDIMINENTO": _rendimiento,
      "DESCRIPCIÓN JUGADOR": _descripcion == null ? "" : _descripcion,
      "OBSERVACIONES SCOUTER": _observaciones == null ? "" : _observaciones,
      "AGENTE": _agente,
      "CONTACTO": _contacto,
      "COMENTARIOS CAPTACIÓN": _comentarios,
      "COMENTARIOS CAPTACIÓN": _comentarios,
      "nombre": _nombre,
      "email": _email,
      "id": key
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

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get tipoAntiguo => _tipoAntiguo;

  set tipoAntiguo(String value) {
    _tipoAntiguo = value;
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }


  String get contacto => _contacto;

  set contacto(String value) {
    _contacto = value;
  }


  String get agente => _agente;

  set agente(String value) {
    _agente = value;
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

  String get scouter => _scouter;

  set scouter(String value) {
    _scouter = value;
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

  String get observaciones => _observaciones;

  set observaciones(String value) {
    _observaciones = value;
  }


  String get comentarios => _comentarios;

  set comentarios(String value) {
    _comentarios = value;
  }


  String get idCategoria => _idCategoria;

  set idCategoria(String value) {
    _idCategoria = value;
  }

  String tipoLetra() {
    if (tipo.contains("1"))
      return tipo;
    if (tipo.contains("2"))
      return tipo;
    if (tipo.contains("3"))
      return tipo;
    if (tipo.contains("4"))
      return tipo;
    if (tipo.contains("5"))
      return tipo;
    if (tipo.contains("6"))
      return tipo;
    if (tipo.contains("7"))
      return tipo;
    if (tipo.contains("8"))
      return tipo;
    return "";
  }




  int get edadRange1 => _edadRange1;

  set edadRange1(int value) {
    _edadRange1 = value;
  }

  static List<String> sino = <String>
  [
    'Si',
    'No'
  ];



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

  String get nacionalidad2 => _nacionalidad2;

  set nacionalidad2(String value) {
    _nacionalidad2 = value;
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

  bool get estrella => _estrella;

  set estrella(bool value) {
    _estrella = value;
  }

  String get puntuacion => _puntaciones;

  set puntuacion(String value) {
    _puntaciones = value;
  }

  String get puntaciones => _puntaciones;

  set puntaciones(String value) {
    _puntaciones = value;
  }


  String get idTemporada => _idTemporada;

  set idTemporada(String value) {
    _idTemporada = value;
  }

  String get idPais => _idPais;

  set idPais(String value) {
    _idPais = value;
  }

  String get idEquipo => _idEquipo;

  set idEquipo(String value) {
    _idEquipo = value;
  }

  List<Player> adjacentNodes = [];

  Player.clone(Player source)
      :
        this._dorsal=source.dorsal,
        this.key=source.key,
        this._estado = source.estado,
        this._jugador = source.jugador,
        this._puntaciones = source.puntuacion,
        this.adjacentNodes = source.adjacentNodes.map((item) =>
        new Player.clone(item)).toList();


  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  bool get firmado => _firmado;

  set firmado(bool value) {
    _firmado = value;
  }

  String get instagram => _instagram;

  set instagram(String value) {
    _instagram = value;
  }


  bool get proceso => _proceso;

  set proceso(bool value) {
    _proceso = value;
  }

  String edadCategoria() {
    String sub = "";
    if (fechaNacimiento == null) return "Sin fecha";
    if (fechaNacimiento == "") return "Sin fecha";
    if (fechaNacimiento == "-") return "Sin fecha";
    return Config.edadCategoria(fechaNacimiento);
  }

  String edadCategoriaSinLetras() {
    String sub = "";
    if (fechaNacimiento == null) return "";
    if (fechaNacimiento == "") return "";
    if (fechaNacimiento == "-") return "";
    return Config.edadCategoriaSinLetras(fechaNacimiento);
  }

  String get contratoFederacion => _contratoFederacion;

  set contratoFederacion(String value) {
    _contratoFederacion = value;
  }

  String get contratoProteccionDatos => _contratoProteccionDatos;

  set contratoProteccionDatos(String value) {
    _contratoProteccionDatos = value;
  }

  String get servicioComunicacion => _servicioComunicacion;

  set servicioComunicacion(String value) {
    _servicioComunicacion = value;
  }

  String get fechaVencimientoContrato => _fechaVencimientoContrato;

  set fechaVencimientoContrato(String value) {
    _fechaVencimientoContrato = value;
  }

  String get contratoMarcaDeportiva => _contratoMarcaDeportiva;

  set contratoMarcaDeportiva(String value) {
    _contratoMarcaDeportiva = value;
  }

  String get marcaDeportiva => _marcaDeportiva;

  set marcaDeportiva(String value) {
    _marcaDeportiva = value;
  }

  int get calzado => _calzado;

  set calzado(int value) {
    _calzado = value;
  }

  String get fechaFinalizacionMarca => _fechaFinalizacionMarca;

  set fechaFinalizacionMarca(String value) {
    _fechaFinalizacionMarca = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  String get catCantera => _catCantera;

  set catCantera(String value) {
    _catCantera = value;
  }

  String get apodo => _apodo;

  set apodo(String value) {
    _apodo = value;
  }

  String get reunion => _reunion;

  set reunion(String value) {
    _reunion = value;
  }
}

class AccionPutuacionJugadorPartido{
  String putuacion="NA";
  String accion="";
  String estrella="";

}

