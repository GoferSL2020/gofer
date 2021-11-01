


import 'dart:math';


enum TtsState { playing, stopped }

class LogoService{



  static int letra(String letra) {
    int i = -1;
    int ascii;
    ascii = letra.codeUnitAt(0);
    if (ascii != -1) {
      switch (ascii) {
        case 97: //a
          i = 1;
          break;
        case 101: //e
          i = 2;
          break;
        case 104: //h
          i = 6;
          break;
        case 105: //i
          i = 4;
          break;
        case 111: //o
          i = 3;
          break;
        case 117: //u
          i = 5;
          break;
        case 225: //Ã¡
          i = 1;
          break;
        case 233: //Ã©
          i = 2;
          break;
        case 237: //Ã­
          i = 4;
          break;
        case 243: //Ã³
          i = 3;
          break;
        case 250: //Ãº
          i = 5;
          break;
        case 252: //Ã¼
          i = 5;
          break;
        default:
          i = 19;
          break;
      }
    }
    return i;
  }

  static String silaba(String str) {
    String temp = "";
    String s = "";
    var x, y, z;
    if (str.length < 3) {
      if (str.length == 2) {
        x = str.substring(0, 1);
        y = str.substring(1, 2);
        if (letra(x) < 6 && letra(y) < 6) {
          if (hiato(x, y))
            s = str.substring(0, 1);
          else
            s = str;
        } else
          s = str;
      } else
        s = str;
    } else {
      x = str.substring(0, 1);
      y = str.substring(1, 2);
      z = str.substring(2, 3);
      if (letra(x) < 6) { //V ? ?
        if (letra(y) < 6) { //V V ?
          if (letra(z) < 6) { //V V V
            if (hiato(x, y)) {
              s = str.substring(0, 1);
            } else {
              if (hiato(y, z)) {
                s = str.substring(0, 2);
              } else {
                s = str.substring(0, 3);
              }
            }
          } else { // V V C
            if (hiato(x, y)) {
              s = str.substring(0, 1);
            } else {
              s = str.substring(0, 2);
            }
          }
        } else { // V C ?
          if (letra(z) < 6) { //V C V
            if (letra(y) == 6) { // V H C
              if (hiato(x, z)) {
                s = str.substring(0, 1);
              } else {
                s = str.substring(0, 3);
              }
            } else {
              s = str.substring(0, 1);
            }
          } else { // V C C
            if (consonantes1(y, z)) {
              s = str.substring(0, 1);
            } else {
              s = str.substring(0, 2);
            }
          }
        }
      } else { // C ??
        if (letra(y) < 6) { //C V ?
          if (letra(z) < 6) { // C V V
            temp = str.substring(0, 3);
            if (temp == "que" || temp == "qui" || temp == "gue" ||
                temp == "gui") {
              s = str.substring(0, 3);
            } else {
              if (hiato(y, z)) {
                s = str.substring(0, 2);
              } else {
                s = str.substring(0, 3);
              }
            }
          } else { // C V C
            s = str.substring(0, 2);
          }
        } else { // C C ?
          if (letra(z) < 6) { // C C V
            if (consonantes1(x, y)) {
              s = str.substring(0, 3);
            } else {
              s = str.substring(0, 1);
            }
          } else { // C C C
            if (consonantes1(y, z)) {
              s = str.substring(0, 1);
            } else {
              s = str.substring(0, 1);
            }
          }
        }
      }
    }
    return s;
  }

  static String silabaRest(var str) {
    var s2;
    s2 = silaba(str);
    return str.substring(s2.length);
  }

  static bool hiato(var v, var v2) {
    bool cer = false;
    if (letra(v) < 4) { // VA + ?
      if (letra(v2) < 4) //VA + VA
        cer = true;
      else { //VA+ VC
        if (v2 == 'ó' || v2 == 'ú' || v2 == 'í') {
          cer = true;
        } else {
          cer = false;
        }
      }
    } else { // VC + ?
      if (letra(v2) < 4) { // VC + VA
        if (v == 'í' || v == 'ú') {
          // if(v=='Ã­' || v=='Ãº'){
          cer = true;
        } else {
          cer = false;
        }
      } else { //VC + VC
        if (v == v2) {
          cer = true;
        } else
          cer = false;
      }
    }
    return cer;
  }

  static bool consonantes1(var a, var b) {
    bool cer;
    cer = false;
    if (a == 'b' || a == 'c' || a == 'd' || a == 'f' || a == 'g' || a == 'p' ||
        a == 'r' || a == 't') {
      if (b == 'r') {
        cer = true;
      }
    }
    if (a == 'b' || a == 'c' || a == 'f' || a == 'g' || a == 'p' || a == 't' ||
        a == 'l') {
      if (b == 'l') {
        cer = true;
      }
    }
    if (b == 'h') {
      if (a == 'c') {
        cer = true;
      }
    }
    return cer;
  }

  static bool strConsonantes(var str) {
    bool cer;
    int i, k;
    var c;
    cer = false;
    k = 0;
    c = str.split('');
    for (i = 0; i < str.length; i++) {
      if (letra(c[i]) > 5) {
        k = k + 1;
      }
    }
    if (k == str.length) {
      cer = true;
    }
    return cer;
  }

  static bool strVVstr(String s1, String s2) {
    bool cer;
    String c1, c2;

    c1 = s1.substring(s1.length - 1, s1.length);
    c2 = s2.substring(0, 1);
    cer = false;
    if (letra(c1) < 6 && letra(c2) < 6) {
      if (hiato(c1, c2)) {
        cer = false;
      } else {
        cer = true;
      }
    }
    return cer;
  }

  static String silabear(String cadena) {
    String temp;
    String s = "";
    int i, k;
    k = cadena.length;
    temp = cadena;
    for (i = 0; i < k; i++) {
      temp = silaba(cadena);
      if (i == 0) {
        s = s + temp;
      } else {
        if (strConsonantes(temp)) {
          s = s + temp;
        } else {
          if (strVVstr(s, temp)) {
            s = s + temp;
          } else {
            if (strConsonantes(s)) {
              s = s + temp;
            } else {
              s = s + "-" + temp;
            }
          }
        }
      }
      i = i + temp.length - 1;
      cadena = silabaRest(cadena);
    }
    return s;
  }



  static String silabearCadena(String frase) {
    String cadena="";
    String cadenaSilabas = "";
    if (verificar(cadena.toLowerCase())) {
      var palabras = getPalabras(frase);
      int i;
      for ( i = 0; i < palabras.length; i++)
      {
        cadena = palabras[i];
        cadenaSilabas = cadenaSilabas + " " + silabear(cadena);
      }
      // ignore: expected_token
    }
    else
      cadenaSilabas = "Palabra no válida";

    return cadenaSilabas;
  }

  static bool verificar(String cadena) {
    String s;
    var c;
    String x;
    int i, j, k;
    int error = 0;
    //  s = " abcdefghijklmnÃ±opqrstuvwxyzÃ¡Ã©Ã­Ã³ÃºÃ¼";
    s = " abcdefghijklmnñ±opqrstuvwxyzáéíóúü";
    c = s.split('');
    for (i = 0; i < cadena.length && error == 0; i++) {
      x = cadena.substring(i, i + 1);
      k = 0;
      for (j = 0; j < s.length && k == 0; j++) {
        if (x == c[j])
          k++;
      }
      if (k == 0)
        error++;
    }
    if (error == 0)
      return true;
    else
      return false;
  }

  static List<String> getPalabras(String cadena) {
    List<String> palabras = new List();
    String palabra = "";
    cadena = cadena.trim().toLowerCase() + " ";
    var c = cadena.split("");
    int i;
    for (i = 0; i < cadena.length; i++) {
      if (c[i] == ' ') {
        palabras.add(palabra);
        palabra = "";
      }
      else
        palabra = palabra + c[i];
    }
    return palabras;
  }





  static ayudaPalabra(String palabra){
    int log=palabra.length;
    List<String> letras=palabra.split("");
    for (var k=0;k<log;k++)
      print("{$letras[k]}\n");
  }

  static List shuffle(List items) {
      var random = new Random();
   // Go through all elements.
      for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
        var n = random.nextInt(i + 1);
        var temp = items[i];
        items[i] = items[n];
        items[n] = temp;
      }
   return items;
  }




}
