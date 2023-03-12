import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iafootfeel/locale/app_localization.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/player.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart' as open_file;

class Config {
  static Color colorCardLetra = Colors.black;
  static Color colorCardLetra2 = Colors.grey.shade600;
  static Color color = Colors.black;
  static Color colorCard = Colors.white;

  static double volume = 1.0;
  static double pitch = 1.0;
  static double rate = 0.5;
  static Color fondo = Colors.white;
  static int intcolor = 900; //500 ->0
  static Color tabColor = Colors.white;
  //cambiar

  static Color colorAPP = Colors.blue;
  static Color border = Colors.red;
  static Color colorMenu = Colors.red;
  static Color mail = Colors.red; //.shade900
  static Color botones = Colors.red; //.shade900
  static Color colorFootFeel = Color.fromRGBO(110, 169, 220, 1.0);
  static List<ImagenStorage> _imagenesClubes = [];

  static List<ImagenStorage> get imagenesClubes => _imagenesClubes;

  static set imagenesClubes(List<ImagenStorage> value) {
    _imagenesClubes = value;
  }

  static List<String> altura = <String>[
    'Altura reseñable para su posición',
    'Bajo para su posición'
  ];

  static List<String> envergaduraFisica = <String>['Baja', 'Media', 'Alta'];

  static List<String> velocidaddedesplazamiento = <String>[
    'Gran velocidad en distancia larga',
    'Lento',
    'Velocidad normal'
  ];

  static List<String> fuerzadelucha = <String>[
    'Gana los cuerpo a cuerpo',
    'Pierde los duelos',
    'No entra'
  ];

  static List<String> lateral = <String>[
    'Derecho',
    'Izquierdo',
    'Ambidiestro',
    'unknown'
  ];

  static List<String>   extranjero= <String>[
    'Nacional',
    'Extranjero',
    'Nacionalizado'
  ];

  static List<String> redimiento  = <String>[
    'Otros',
    'Cantera',
    'Sel.Autonómica',
    'Internacional',
  ];
  static List<String> extranjeroArgentino = <String>['Argentina', 'Extranjero'];

  static List<String> activo = <String>['Activo', 'Inactivo'];

  static List<String> gestostecnicos = <String>[
    'Muy buenos',
    'Normal',
    'Malo Tecnicamente'
  ];

  static List<String> tipodeconducciones = <String>[
    'Larga distancia',
    'Media distancia'
  ];


  static DateTime? dateStringtodateCalendario(String stringdate)
  {
    print("FECAH:$stringdate");
    DateTime? _stringdate;
    if(stringdate==null) return DateTime.now();
    if(stringdate=="") return DateTime.now();

    List<String> validadeSplit = stringdate.split('/');
    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[0].toString());
      int month = int.parse(validadeSplit[1].toString());
      int year = int.parse(validadeSplit[2].toString());
      _stringdate = DateTime.utc(year, month, day);
    }
    return _stringdate;
  }


  static List<String> capacidaddemarcaje = <String>['Muy buena', 'Lo superan'];

  static List<String> capacidadparataparcentros = <String>[
    'No lo superan',
    'Lo superan'
  ];

  static List<String> salidadebalon = <String>[
    'Buenos controles para superar',
    'Malos controles para superar'
  ];

  static List<String> goleador = <String>['Si', 'No', 'Ocacional'];

  static getValue(String aux) {
    if (aux == "-") return 0;
    if (aux == null) return 0;
    if (aux == "null") return 0;
    if (aux == "Altura reseñable para su posición") return 0;
    if (aux == "Baja") return 0;
    if (aux == "Nacional") return 0;
    if (aux == "Gran velocidad en distancia larga") return 0;
    if (aux == "Gana los cuerpo a cuerpo") return 0;
    if (aux == "Nativo") return 0;
    if (aux == "Argentina") return 0;
    if (aux == "Activo") return 0;

    if (aux == "Derecho") return 0;
    if (aux == "Muy buenos") return 0;
    if (aux == "Larga distancia") return 0;
    if (aux == "Muy buena") return 0;
    if (aux == "No lo superan") return 0;
    if (aux == "Buenos controles para superar") return 0;
    if (aux == "Si") return 0;

    if (aux == "Bajo para su posición") return 1;
    if (aux == "Media") return 1;
    if (aux == "Lento") return 1;
    if (aux == "Pierde los duelos") return 1;
    if (aux == "Extranjero") return 1;
    if (aux == "Inactivo") return 1;

    if (aux == "Izquierdo") return 1;
    if (aux == "Normal") return 1;
    if (aux == "Media distancia") return 1;
    if (aux == "Lo superan") return 1;
    if (aux == "Lo superan") return 1;
    if (aux == "alos controles para superar") return 1;
    if (aux == "No") return 1;

    if (aux == "Alta") return 2;
    if (aux == "Velocidad normal") return 2;
    if (aux == "No entra") return 2;
    if (aux == "Ambidextro") return 2;

    if (aux == "Ambidiestro") return 2;
    if (aux == "Malo Tecnicamente") return 2;
    if (aux == "Ocacional") return 2;
    if (aux == "Nacionalizado") return 2;
    if (aux == "unknown") return 3;

    if (aux == "Otros") return 0;
    if (aux == "Cantera") return 1;
    if (aux == "Sel.Autonómica") return 2;
    if (aux == "Internacional") return 3;


    if (aux == "") return 0;


  }

  static String edad(String fechaNacimiento) {
    String sub = "";
    if (fechaNacimiento == null) return "Sin fecha";
    if (fechaNacimiento == "") return "Sin fecha";
    if (fechaNacimiento == "-") return "Sin fecha";
    int edad;
    var fechaDeHoy = DateTime.now();
    DateFormat format = DateFormat("dd/MM/yyyy");
    var fechaNac = format.parse(fechaNacimiento);
    var anio = fechaDeHoy.difference(fechaNac);
    print(fechaDeHoy);
    print(fechaNac);
    print(anio);
    edad = (anio.inDays / 366).truncate();
    print(edad);
    sub = edad.toString();
    print(sub);
    return sub;
  }

  static String edadCategoriaSinLetras(String fechaNacimiento) {
    String sub = "";
    if (fechaNacimiento == null) return "";
    if (fechaNacimiento == "") return "";
    if (fechaNacimiento == "-") return "";
    int edad;
    var fechaDeHoy = DateTime.now();
    //  print("YEAR:${fechaDeHoy.year}");
    DateFormat format = DateFormat("dd/MM/yyyy");
    var fechaNac = format.parse(fechaNacimiento);
    // print("YEAR NAC:${fechaNac.year}");
    edad = fechaDeHoy.year - fechaNac.year;

    String edadSring="";
    if (edad >22) return edadSring="";
    //print("edadC:${edad}");
    switch (edad) {
      case 22:
        edadSring = "Sub-23";
        break;
      case 21:
        edadSring = "Sub-23";
        break;
      case 20:
        edadSring = "Sub-23";
        break;
      case 19:
        edadSring = "Juvenil";
        break;
      case 18:
        edadSring = "Juvenil";
        break;
      case 17:
        edadSring = "Juvenil";
        break;
      case 16:
        edadSring = "Cadete";
        break;
      case 15:
        edadSring = "Cadete";
        break;
      case 14:
        edadSring = "Infantil";
        break;
      case 13:
        edadSring = "Infantil";
        break;
      case 12:
        edadSring = "Alevín";
        break;
      case 11:
        edadSring = "Alevín";
        break;
      case 10:
        edadSring = "Benjamín";
        break;
      case 9:
        edadSring= "Benjamín";
        break;
      case 8:
        edadSring= "Pre-Benjamín";
        break;
      case 7:
        edadSring= "Pre-Benjamín";
        break;
      case 6:
        edadSring= "Chupetín";
        break;
      case 5:
        edadSring= "Chupetín";
        break;
    }
    //  print("EDADSTRNIG:${edadSring}");
    return edadSring;
  }



  static String edadCategoria(String fechaNacimiento) {
    String sub = "";
    if (fechaNacimiento == null) return "";
    if (fechaNacimiento == "") return "";
    if (fechaNacimiento == "-") return "";
    int edad;
    var fechaDeHoy = DateTime.now();
  //  print("YEAR:${fechaDeHoy.year}");
    DateFormat format = DateFormat("dd/MM/yyyy");
    var fechaNac = format.parse(fechaNacimiento);
   // print("YEAR NAC:${fechaNac.year}");
    edad = fechaDeHoy.year - fechaNac.year;

    String edadSring="";
    if (edad >22) return edadSring="";
    //print("edadC:${edad}");
    switch (edad) {
      case 22:
          edadSring = "Sub-23";
        break;
      case 21:
          edadSring = "Sub-23";
        break;
      case 20:
          edadSring = "Sub-23";
        break;
      case 19:
          edadSring = "3º Juvenil";
        break;
      case 18:
          edadSring = "2º Juvenil";
        break;
      case 17:
          edadSring = "1º Juvenil";
        break;
      case 16:
          edadSring = "2º Cadete";
        break;
      case 15:
          edadSring = "1º Cadete";
        break;
      case 14:
          edadSring = "2º Infantil";
        break;
      case 13:
          edadSring = "1º Infantil";
        break;
      case 12:
          edadSring = "2º Alevín";
        break;
      case 11:
          edadSring = "1º Alevín";
          break;
      case 10:
          edadSring = "2º Benjamín";
          break;
      case 9:
          edadSring= "1º Benjamín";
          break;
      case 8:
          edadSring= "2º Pre-Benjamín";
        break;
      case 7:
          edadSring= "1º Pre-Benjamín";
        break;
      case 6:
        edadSring= "Chupetín";
        break;
      case 5:
        edadSring= "Chupetín";
        break;
    }
  //  print("EDADSTRNIG:${edadSring}");
    return edadSring;
  }



  static String edadCategoriaBBDD(String fechaNacimiento,String categoria) {
    print(fechaNacimiento);
    if (fechaNacimiento == null) return categoria;
    if (fechaNacimiento == "") return categoria;
    if (fechaNacimiento == "-") return categoria;
    int edad;
    var fechaDeHoy = DateTime.now();
    //  print("YEAR:${fechaDeHoy.year}");
    DateFormat format = DateFormat("dd/MM/yyyy");
    var fechaNac = format.parse(fechaNacimiento);
    // print("YEAR NAC:${fechaNac.year}");
    edad = fechaDeHoy.year - fechaNac.year;

    String edadSring=categoria;
    if (edad >22) return edadSring="Senior";
    //print("edadC:${edad}");
    switch (edad) {
      case 22:
        edadSring = "Senior";
        break;
      case 21:
        edadSring = "Senior";
        break;
      case 20:
        edadSring = "Senior";
        break;
      case 19:
        edadSring = "3º Juvenil";
        break;
      case 18:
        edadSring = "2º Juvenil";
        break;
      case 17:
        edadSring = "1º Juvenil";
        break;
      case 16:
        edadSring = "2º Cadete";
        break;
      case 15:
        edadSring = "1º Cadete";
        break;
      case 14:
        edadSring = "2º Infantil";
        break;
      case 13:
        edadSring = "1º Infantil";
        break;
      case 12:
        edadSring = "2º Alevín";
        break;
      case 11:
        edadSring = "1º Alevín";
        break;
      case 10:
        edadSring = "2º Benjamín";
        break;
      case 9:
        edadSring= "1º Benjamín";
        break;
      case 8:
        edadSring= "2º Pre-Benjamín";
        break;
      case 7:
        edadSring= "1º Pre-Benjamín";
        break;
      case 6:
        edadSring= "Chupetín";
        break;
      case 5:
        edadSring= "Chupetín";
        break;
    }
    //  print("EDADSTRNIG:${edadSring}");
    return edadSring;
  }

  static String edadSub(String fechaNacimiento) {
    String sub = "";
    if (fechaNacimiento == null) return "Sin fecha";
    if (fechaNacimiento == "") return "Sin fecha";
    if (fechaNacimiento == "-") return "Sin fecha";
    int edad;
    var fechaDeHoy = DateTime.now();
    int anioHoy = (fechaDeHoy.year); //Año
    int mesHoy = (fechaDeHoy.month); //Mes
    int diaHoy = (fechaDeHoy.day);

    DateFormat format = DateFormat("dd/MM/yyyy");
    var fechaNac = format.parse(fechaNacimiento);
    int anioJugador = (fechaNac.year); //Año
    int mesJugador = (fechaNac.month); //Mes
    int diaJugador = (fechaNac.day);
    edad = anioHoy - anioJugador;

    if (mesJugador > mesHoy)
      edad--;
    else {
      if ((mesHoy == mesJugador) && (diaHoy < diaJugador)) edad--;
    }

    var anio = fechaDeHoy.difference(fechaNac);
    var edad365 = (anio.inDays / 366);
    var edadTruncate = (anio.inDays / 366).truncate();

    if (edad < 20) {
      sub = edad.toString() + " (Sub-20" + ")";
    } else if (edad < 23) {
      sub = edad.toString() + " (Sub-23" + ")";
    } else {
      sub = edad.toString();
    }
    return sub;
  }

  static String edadSubSolo(String fechaNacimiento) {
    String sub = "";
    if (fechaNacimiento == null) return "Sin fecha";
    if (fechaNacimiento == "") return "Sin fecha";
    if (fechaNacimiento == "-") return "Sin fecha";
    int edad;
    var fechaDeHoy = DateTime.now();
    int anioHoy = (fechaDeHoy.year); //Año
    int mesHoy = (fechaDeHoy.month); //Mes
    int diaHoy = (fechaDeHoy.day);

    DateFormat format = DateFormat("dd/MM/yyyy");
    var fechaNac = format.parse(fechaNacimiento);
    int anioJugador = (fechaNac.year); //Año
    int mesJugador = (fechaNac.month); //Mes
    int diaJugador = (fechaNac.day);
    edad = anioHoy - anioJugador;

    if (mesJugador > mesHoy)
      edad--;
    else {
      if ((mesHoy == mesJugador) && (diaHoy < diaJugador)) edad--;
    }
    sub=edad.toString();
    return sub;
  }

  static String categoriaMin(String categoria) {
    String sub = "";
    if (categoria == "2ª División A") return "2ª A";
    if (categoria == "2ª División B Grupo 1 A") return "2ªB Grupo 1-A";
    if (categoria == "2ª División B Grupo 1 B") return "2ªB Grupo 1-B";
    if (categoria == "2ª División B Grupo 2 A") return "2ªB Grupo 2-A";
    if (categoria == "2ª División B Grupo 2 B") return "2ªB Grupo 2-B";
    if (categoria == "2ª División B Grupo 3 A") return "2ªB Grupo 3-A";
    if (categoria == "2ª División B Grupo 3 B") return "2ªB Grupo 3-B";
    if (categoria == "2ª División B Grupo 4 A") return "2ªB Grupo 4-A";
    if (categoria == "2ª División B Grupo 4 B") return "2ªB Grupo 4-B";
    if (categoria == "2ª División B Grupo 5 A") return "2ªB Grupo 5-A";
    if (categoria == "2ª División B Grupo 5 B") return "2ªB Grupo 5-B";
    if (categoria == "1ª División RFEF Grupo 1") return "1ª RFEF Gr.1";
    if (categoria == "1ª División RFEF Grupo 2") return "1ª RFEF Gr.2";
    if (categoria == "2ª División RFEF Grupo 1") return "2ª RFEF Gr.1";
    if (categoria == "2ª División RFEF Grupo 2") return "2ª RFEF Gr.2";
    if (categoria == "2ª División RFEF Grupo 3") return "2ª RFEF Gr.3";
    if (categoria == "2ª División RFEF Grupo 4") return "2ª RFEF Gr.4";
    if (categoria == "2ª División RFEF Grupo 5") return "2ª RFEF Gr.5";

    return sub;
  }

  static String imagenJugador(Equipo equipo, Player jugador) {
    return "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/"
        "jugadores"
        "%2F${jugador.foto()}?alt=media";
  }


  ///https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/entrenadores%2FBorja%20Jiménez?alt=media
  ///https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/entrenadores%2FBorja%20Jim%C3%A9nez?alt=media&token=30f2cc35-c348-490a-817c-912761bf1d96
//  https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/entrenadores%2FGuillermo%20Fern%C3%A1ndez?alt=media&token=c1363d66-7799-4693-9eea-ac0058ca519e
  static String imagenJugador2(String equipo, String jugador) {
    return "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/"
        "%2F${equipo.replaceAll(" ", "")}"
        "%2Fjugadores"
        "%2F${jugador.replaceAll("à", "a%CC%80").replaceAll("è", "e%CC%80").replaceAll("ì", "i%CC%80").replaceAll("ñ", "n%CC%83").replaceAll("Ñ", "N%CC%83").replaceAll("ò", "o%CC%80").replaceAll("ù", "u%CC%80").replaceAll("Á", "A%CC%81").replaceAll("É", "E%CC%81").replaceAll("Í", "I%CC%81").replaceAll("Ó", "O%CC%81").replaceAll("Ú", "U%CC%81").replaceAll("ñ", "n%CC%83").replaceAll("á", "a%CC%81").replaceAll("é", "e%CC%81").replaceAll("í", "i%CC%81").replaceAll("ó", "o%CC%81").replaceAll("ú", "u%CC%81")}?alt=media";
  }

  static String escudoCategoria(String imagen) {
    String s =
        "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/categorias%2F${imagen.replaceAll(" ", "%20").replaceAll("2ª", "2%C2%AA").replaceAll("1ª", "1%C2%AA").replaceAll("à", "a%CC%80").replaceAll("è", "e%CC%80").replaceAll("ì", "i%CC%80").replaceAll("ò", "o%CC%80").replaceAll("ù", "u%CC%80").replaceAll("Á", "A%CC%81").replaceAll("É", "E%CC%81").replaceAll("Í", "I%CC%81").replaceAll("Ó", "O%CC%81").replaceAll("Ú", "U%CC%81").replaceAll("ñ", "n%CC%83").replaceAll("á", "a%CC%81").replaceAll("é", "e%CC%81").replaceAll("í", "i%CC%81").replaceAll("ó", "o%CC%81").replaceAll("ú", "u%CC%81")}.png?alt=media";

    return s;
  }

  static String escudoClubes(String imagen) {
    String s =
        "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/"
        "clubes%2F${imagen.replaceAll("2ª", "2%C2%AA").replaceAll("Ó", "O%CC%81").replaceAll("1ª", "1%C2%AA").replaceAll("à", "a%CC%80").replaceAll("è", "e%CC%80").replaceAll("ñ", "n%CC%83").replaceAll("Ñ", "N%CC%83").replaceAll("ì", "i%CC%80").replaceAll("ò", "o%CC%80").replaceAll("ù", "u%CC%80").replaceAll("Á", "A%CC%81").replaceAll("É", "E%CC%81").replaceAll("Í", "I%CC%81").replaceAll("Ó", "O%CC%81").replaceAll("Ú", "U%CC%81").replaceAll("ñ", "n%CC%83").replaceAll("á", "a%CC%81").replaceAll("é", "e%CC%81").replaceAll("í", "i%CC%81").replaceAll("ó", "o%CC%81").replaceAll("ú", "u%CC%81")}.png?alt=media";
    return s;
  }

  static String escudoClubesFF(String imagen) {
    String s =
        "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/"
        "clubes%2F${imagen.replaceAll("Ñ", "N").replaceAll("ñ", "n").replaceAll("Á", "A%CC%81").replaceAll("É", "E%CC%81").replaceAll("Í", "I%CC%81").replaceAll("Ó", "O%CC%81").replaceAll("Ú", "U%CC%81")}.png?alt=media";
    /*replaceAll("Ñ", "2%C2%AA").
    replaceAll("Ó", "O%CC%81").
    replaceAll("1ª", "1%C2%AA").
    replaceAll("à", "a%CC%80").
    replaceAll("è", "e%CC%80").
    replaceAll("ñ", "n%CC%83").
    replaceAll("Ñ", "N%CC%83").
    replaceAll("ì", "i%CC%80").
    replaceAll("ò", "o%CC%80").
    replaceAll("ù", "u%CC%80").
    replaceAll("Á", "A%CC%81").
    replaceAll("É", "E%CC%81").
    replaceAll("Í", "I%CC%81").
    replaceAll("Ó", "O%CC%81").
    replaceAll("Ú", "U%CC%81").
    replaceAll("ñ", "n%CC%83").
    replaceAll("á", "a%CC%81").
    replaceAll("é", "e%CC%81").replaceAll("í", "i%CC%81").replaceAll("ó", "o%CC%81").replaceAll("ú", "u%CC%81")*/

    return s;
  }

  static String escudoPais(String imagen) {
    String s =
        "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/"
        "clubes%2F${imagen.replaceAll("2ª", "2%C2%AA").replaceAll("1ª", "1%C2%AA").replaceAll("à", "a%CC%80").replaceAll("è", "e%CC%80").replaceAll("ñ", "n%CC%83").replaceAll("Ñ", "N%CC%83").replaceAll("ì", "i%CC%80").replaceAll("ò", "o%CC%80").replaceAll("ù", "u%CC%80").replaceAll("Á", "A%CC%81").replaceAll("É", "E%CC%81").replaceAll("Í", "I%CC%81").replaceAll("Ó", "O%CC%81").replaceAll("Ú", "U%CC%81").replaceAll("ñ", "n%CC%83").replaceAll("á", "a%CC%81").replaceAll("é", "e%CC%81").replaceAll("í", "i%CC%81").replaceAll("ó", "o%CC%81").replaceAll("ú", "u%CC%81")}.png?alt=media";
    return s;
  }

  static String escudoImages(String imagen) {
    String s =
        "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/images%2F${imagen}?alt=media";

    return s;
  }

  static Color edadColorSub(String sub) {
    if (sub.toUpperCase() == "SUB-20") return Colors.red.shade900;
    if (sub.toUpperCase() == "SUB-23") return Colors.green.shade900;
    return Colors.black;
  }

/* static Color color=
 BBDDService().getUserIAScout().color=="rojo"?Colors.red:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue:Colors.blueGrey;
 static Color colorAPP =
 BBDDService().getUserIAScout().color=="rojo"?Colors.red.shade900:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue.shade900:Colors.blueGrey.shade900;
 static Color border =
 BBDDService().getUserIAScout().color=="rojo"?Colors.red.shade900:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue.shade900:Colors.blueGrey.shade900;
 static Color colorMenu =
 BBDDService().getUserIAScout().color=="rojo"?Colors.red:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue:Colors.blueGrey;
 static Color mail  =Colors.red.shade900;//.shade900
*/

  static String icono = "assets/img/iconotitulo.png";

  static int letrasPalabra = 30;

  static int jornadas = 30;



  static MaterialColor generateMaterialColor(Color color2) {
    return MaterialColor(color.value, {
      50: color,
      100: color,
      200: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
    });
  }




  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static String escudo(String equipo) {
    return "https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/clubes%2F${equipo.replaceAll("à", "a%CC%80").replaceAll("è", "e%CC%80").replaceAll("ì", "i%CC%80").replaceAll("ò", "o%CC%80").replaceAll("ù", "u%CC%80").replaceAll("Á", "A%CC%81").replaceAll("É", "E%CC%81").replaceAll("Í", "I%CC%81").replaceAll("Ó", "O%CC%81").replaceAll("Ú", "U%CC%81").replaceAll("ñ", "n%CC%83").replaceAll("á", "a%CC%81").replaceAll("é", "e%CC%81").replaceAll("í", "i%CC%81").replaceAll("ó", "o%CC%81").replaceAll("ú", "u%CC%81")}.png?alt=media";
  }
  // https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/clubes%2FReal%20Unio%CC%81n.png?alt=media&token=2be46971-8013-4fb3-bcfa-897939b0cb29

  static Future<bool> saveImage(Uint8List image, Uint8List image2) async {
    try {
      var result = await ImageGallerySaver.saveImage(image,
          quality: 60, name: "${DateTime.now().toIso8601String()}");
      ImageGallerySaver.saveImage(image2,
          quality: 100, name: "2${DateTime.now().toIso8601String()}");

      await open_file.OpenFile.open('${DateTime.now().toIso8601String()}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class ImagenStorage {
  String club="";
  dynamic imagen;
}
