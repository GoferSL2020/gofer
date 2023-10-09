import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gls/modelo/mercancia.dart';

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
  static Color fondo = Color.fromRGBO(21, 31, 173, 1.0);
  static Color letras = Color.fromRGBO(252, 191, 0, 1.0);


  static String icono = "assets/img/logo.png";
  static String logoGLS = "assets/img/logoGLS.png";
  static String logo2 = "assets/img/logo2.png";


  static Color colorAPP = Colors.blue;
  static Color border = Colors.red;
  static Color colorMenu = Colors.red;
  static Color mail = Colors.red; //.shade900
  static Color botones = Colors.red; //.shade900
  static Color colorGLS = Color.fromRGBO(110, 169, 220, 1.0);


  static DateTime? dateStringtodateCalendario(String stringdate) {
    print("FECAH:$stringdate");
    DateTime? _stringdate;
    if (stringdate == null) return DateTime.now();
    if (stringdate == "") return DateTime.now();

    List<String> validadeSplit = stringdate.split('/');
    if (validadeSplit.length > 1) {
      int day = int.parse(validadeSplit[0].toString());
      int month = int.parse(validadeSplit[1].toString());
      int year = int.parse(validadeSplit[2].toString());
      _stringdate = DateTime.utc(year, month, day);
    }
    return _stringdate;
  }


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

  static String imagenFoto(Mercancia mercancia, int fotoNumero) {
    String foto =
        "https://firebasestorage.googleapis.com/v0/b/gofer-gls.appspot.com/o/productos"
        "%2F${mercancia!.referenciaProducto.replaceAll(
        "/", "")}_$fotoNumero.png?alt=media";
    return foto;
  }


}