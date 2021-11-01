import 'package:iadvancedscout/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/model/jugador.dart';
class Config{


 static double volume = 1.0;
 static double pitch = 1.0;
 static double rate = 0.5;
 static Color fondo = Colors.white ;
 static int intcolor =900;//500 ->0
 static Color tabColor =Colors.white;
 //cambiar
 static Color color=Colors.black;
 static Color colorAPP = Colors.black;
 static Color border = Colors.red;
 static Color colorMenu = Colors.red;
 static Color mail  =Colors.red;//[900]
 static Color botones  =Colors.red;//[900]

 static  List<String> altura = <String>
 [ 'Altura reseñable para su posición','Bajo para su posición'];

 static List<String> envergaduraFisica = <String>
 ['Alta', 'Media', 'Baja'];



 static List<String> velocidaddedesplazamiento = <String>
 ['Gran velocidad en distancia larga', 'Lento', 'Velocidad normal'];

 static List<String> fuerzadelucha = <String>
 ['Gana los cuerpo a cuerpo', 'Pierde los duelos', 'No entra'];

 static List<String> lateral = <String>
 ['derecho', 'izquierdo','unknown'];

 static List<String> extranjero = <String>
 ['Español', 'Extranjero'];

 static List<String> gestostecnicos = <String>
 ['Muy buenos', 'Normal','Malo Tecnicamente'];

 static List<String> tipodeconducciones = <String>
 ['Larga distancia', 'Media distancia'];

 static List<String> capacidaddemarcaje = <String>
 ['Muy buena', 'Lo superan'];

 static List<String> capacidadparataparcentros = <String>
 ['No lo superan', 'Lo superan'];

 static List<String> salidadebalon = <String>
 ['Buenos controles para superar', 'Malos controles para superar'];

 static List<String> goleador = <String>
 ['Si','No', 'Ocacional'];



 static getValue(String aux){

   if (aux=="-") return 0;
   if (aux==null) return 0;
   if (aux=="null") return 0;
   if (aux=="Altura reseñable para su posición") return 0;
   if (aux=="Alta") return 0;
   if (aux=="Español") return 0;
   if (aux=="Gran velocidad en distancia larga") return 0;
   if (aux=="Gana los cuerpo a cuerpo") return 0;

   if (aux=="derecho") return 0;
   if (aux=="Muy buenos") return 0;
   if (aux=="Larga distancia") return 0;
   if (aux=="Muy buena") return 0;
   if (aux=="No lo superan") return 0;
   if (aux=="Buenos controles para superar") return 0;
   if (aux=="Si") return 0;

   if (aux=="Bajo para su posición") return 1;
   if (aux=="Media") return 1;
   if (aux=="Lento") return 1;
   if (aux=="Pierde los duelos") return 1;
   if (aux=="Extranjero") return 1;

   if (aux=="izquierdo") return 1;
   if (aux=="Normal") return 1;
   if (aux=="Media distancia") return 1;
   if (aux=="Lo superan") return 1;
   if (aux=="Lo superan") return 1;
   if (aux=="Malos controles para superar") return 1;
   if (aux=="No") return 1;

   if (aux=="Baja") return 2;
   if (aux=="Velocidad normal") return 2;
   if (aux=="No entra") return 2;

   if (aux=="Ambidiestro") return 2;
   if (aux=="Malo Tecnicamente") return 2;
   if (aux=="Ocacional") return 2;
   if (aux=="unknown") return 2;

   if (aux=="") return 0;


 }

 static String edad(String fechaNacimiento){
   if (fechaNacimiento==null)return "Sin fecha";
   if (fechaNacimiento=="")return "Sin fecha";
   if (fechaNacimiento=="-")return "Sin fecha";
   var edad;
   var anioNacimiento = int.parse(fechaNacimiento.split("/")[2].toString());
   var fechaDeHoy = DateTime.now();
   int anioActual = fechaDeHoy.year;
   edad = anioActual - anioNacimiento;
   return edad.toString();
 }



 static String edadSub(String fechaNacimiento){
   String sub="";
   if (fechaNacimiento==null)return "Sin fecha";
   if (fechaNacimiento=="")return "Sin fecha";
   if (fechaNacimiento=="-")return "Sin fecha";
   var edad;
   var anioNacimiento = int.parse(fechaNacimiento.split("/")[2].toString());
   var fechaDeHoy = DateTime.now();
   var anioActual = fechaDeHoy.year;
   int mesActual = fechaDeHoy.month;
   if(mesActual<9)
     anioActual=anioActual-1;
   edad = anioActual - anioNacimiento;

   if(edad<20) {
     sub = edad.toString()+" (Sub-20"+")";
   }else if(edad<23) {
     sub = edad.toString()+" (Sub-23"+")";
   }else{
     sub = edad.toString();
   }
   return sub;
 }

 static String categoriaMin(String categoria){
   String sub="";
   if (categoria=="2ª División A")return "2ª A";
   if (categoria=="2ª División B Grupo 1 A")return "2ªB Grupo 1-A";
   if (categoria=="2ª División B Grupo 1 B")return "2ªB Grupo 1-B";
   if (categoria=="2ª División B Grupo 2 A")return "2ªB Grupo 2-A";
   if (categoria=="2ª División B Grupo 2 B")return "2ªB Grupo 2-B";
   if (categoria=="2ª División B Grupo 3 A")return "2ªB Grupo 3-A";
   if (categoria=="2ª División B Grupo 3 B")return "2ªB Grupo 3-B";
   if (categoria=="2ª División B Grupo 4 A")return "2ªB Grupo 4-A";
   if (categoria=="2ª División B Grupo 4 B")return "2ªB Grupo 4-B";
   if (categoria=="2ª División B Grupo 5 A")return "2ªB Grupo 5-A";
   if (categoria=="2ª División B Grupo 5 B")return "2ªB Grupo 5-B";
   if (categoria=="1ª División RFEF Grupo 1")return "1ª RFEF Gr.1";
   if (categoria=="1ª División RFEF Grupo 2")return "1ª RFEF Gr.2";
   if (categoria=="2ª División RFEF Grupo 1")return "2ª RFEF Gr.1";
   if (categoria=="2ª División RFEF Grupo 2")return "2ª RFEF Gr.2";
   if (categoria=="2ª División RFEF Grupo 3")return "2ª RFEF Gr.3";
   if (categoria=="2ª División RFEF Grupo 4")return "2ª RFEF Gr.4";
   if (categoria=="2ª División RFEF Grupo 5")return "2ª RFEF Gr.5";

   return sub;
 }


 static Color edadColorSub(String sub){

   if(sub=="SUB-20") return Colors.red[900];
   if(sub=="SUB-23") return Colors.green[900];
   return Colors.black;

 }

/* static Color color=
 BBDDService().getUserIAScout().color=="rojo"?Colors.red:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue:Colors.blueGrey;
 static Color colorAPP =
 BBDDService().getUserIAScout().color=="rojo"?Colors.red[900]:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue[900]:Colors.blueGrey[900];
 static Color border =
 BBDDService().getUserIAScout().color=="rojo"?Colors.red[900]:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue[900]:Colors.blueGrey[900];
 static Color colorMenu =
 BBDDService().getUserIAScout().color=="rojo"?Colors.red:
 BBDDService().getUserIAScout().color=="azul"?Colors.blue:Colors.blueGrey;
 static Color mail  =Colors.red[900];//[900]
*/

 static String icono="assets/img/iconotitulo.png";

  static int letrasPalabra=30;

  static int jornadas=30;

 static MaterialColor swatchify(MaterialColor color, int value) {
  return MaterialColor(color[value].hashCode, <int, Color>{
   50: color[value],
   100: color[value],
   200: color[value],
   300: color[value],
   400: color[value],
   500: color[value],
   600: color[value],
   700: color[value],
   800: color[value],
   900: color[value],
  });
 }

 static String ayudaPalabra(String palabra){
  //print(palabra);
   String aux="";
   aux=palabra.substring(0,1);
   for(var i=0;i<palabra.length-2;i++){
     aux+="_ ";
   }
  aux+=palabra.substring(palabra.length-1,palabra.length);
   return aux;
 }

 static MaterialColor generateMaterialColor(Color color2) {

  return MaterialColor(color.value, {
   50: color,
   100: color,
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


 static void noHayPalabras(BuildContext context, String deque) {
  showDialog(
      context: context,
      builder: (ctxt) =>
      new AlertDialog(
       title: Text(
        "${AppLocalization.of(context).no_hay} ${traducir(deque, context)}\n"
            "de menos de ${Config.letrasPalabra+1} ${AppLocalization.of(context).letras}",
        style: TextStyle(
            color: Config.mail,
            fontWeight: FontWeight.bold),
       ),)
  );
 }

 static String traducir(String deque, BuildContext context) {
  if (deque == "objetos") return AppLocalization.of(context).objectos;
  if (deque == "cuerpo") return AppLocalization.of(context).palabras_cuerpo;
  if (deque == "nombres") return AppLocalization.of(context).nombres;
  if (deque == "alimentos") return AppLocalization.of(context).alimentos;
  if (deque == "animales") return AppLocalization.of(context).animales;
  if (deque == "profesiones") return AppLocalization.of(context).profesiones;
  if (deque == "paises") return AppLocalization.of(context).paises;
  if (deque == "verbos") return AppLocalization.of(context).verbos;
  if (deque == "adjetivos") return AppLocalization.of(context).adjetivos;
  if (deque == "verbos") return AppLocalization.of(context).verbos;
  if (deque == "deportes") return AppLocalization.of(context).deportes;
  if (deque == "colores") return AppLocalization.of(context).colores;
 }

 static Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
 }

  static String escudo(String equipo) {
      return
        "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2F${equipo
            .replaceAll("à", "a%CC%80")
            .replaceAll("è", "e%CC%80")
            .replaceAll("ì", "i%CC%80")
            .replaceAll("ò", "o%CC%80")
            .replaceAll("ù", "u%CC%80")
            .replaceAll("Á", "A%CC%81")
            .replaceAll("É", "E%CC%81")
            .replaceAll("Í", "I%CC%81")
            .replaceAll("Ó", "O%CC%81")
            .replaceAll("Ú", "U%CC%81")
            .replaceAll("ñ", "n%CC%83")
            .replaceAll("á", "a%CC%81")
            .replaceAll("é", "e%CC%81")
            .replaceAll("í", "i%CC%81")
            .replaceAll("ó", "o%CC%81")
            .replaceAll("ú", "u%CC%81")}.png?alt=media";
    }

  static String imagenJugador(Jugador jugador) {
    return
      "https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/jugadores%2F${jugador.id
          .replaceAll("à", "a%CC%80")
          .replaceAll("è", "e%CC%80")
          .replaceAll("ì", "i%CC%80")
          .replaceAll("ò", "o%CC%80")
          .replaceAll("ù", "u%CC%80")
          .replaceAll("Á", "A%CC%81")
          .replaceAll("É", "E%CC%81")
          .replaceAll("Í", "I%CC%81")
          .replaceAll("Ó", "O%CC%81")
          .replaceAll("Ú", "U%CC%81")
          .replaceAll("ñ", "n%CC%83")
          .replaceAll("á", "a%CC%81")
          .replaceAll("é", "e%CC%81")
          .replaceAll("í", "i%CC%81")
          .replaceAll("ó", "o%CC%81")
          .replaceAll("ú", "u%CC%81")}.png?alt=media";
  }
}