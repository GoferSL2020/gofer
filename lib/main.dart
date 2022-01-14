
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//token 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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' show get;
import 'package:iadvancedscout/auth/signup.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/equipoDao.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/locale/app_localization.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/view/temporada/temporadaView.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/splash.dart';
import 'package:path_provider/path_provider.dart';


//import 'package:flutter_localizations/flutter_localizations.dart';

bool login=false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  login = false;
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      //print("USER NULL:");
      login = true;
    } else {
      login = false;
      //print("USER NO NULL:");
      BBDDService().getUserApp();
    }
  });


  runApp(
     MyApp());
}


class MyApp extends StatefulWidget {


  MyAppState createState() => MyAppState();

}


class MyAppState extends State<MyApp> {
  String jugadorAux="";

// This widget is the root of your application.

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    //print("MAIN:");
    FirebaseAuth auth=FirebaseAuth.instance;
    AppLocalizationDelegate _localeOverrideDelegate =
    AppLocalizationDelegate(Locale('es', 'ES'));


  inicio();
    //FirebaseAuth.instance.setPersistence(Persistence.NONE);
    

    return MaterialApp(
     localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
       _localeOverrideDelegate
       ], supportedLocales: [
       const Locale('es', 'ES'),
       const Locale('en', 'US')
     ],

     title: 'InAdvanced - IAScout',
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor:Colors.black,backgroundColor: Config.fondo


      ),

      routes: <String, WidgetBuilder>{
        "SPLASH_SCREEN": (BuildContext context) => SplashScreen(),
        "HOME_SCREEN": (BuildContext context) => login == true ? SignUp():TemporadaView(),
      },

    );
  }



  @override
  void initState() {
    jugadorAux="";
    // TODO: implement initState
    super.initState();
    imagenesStorageClubes();
  }

  imagenesStorageClubes() async{
    final _storage = FirebaseStorage.instance;
    await _storage.ref('clubes/').listAll().then((value) {
      value.items.forEach((element) async {
        ImagenStorage img = new ImagenStorage();
        var escudo=element.name.replaceAll(".png", "");
        var imgequipo;
          imgequipo = await get(Uri.parse(
              Config.escudo(escudo)));
          img.imagen = imgequipo;
          img.club =escudo;
        Config.imagenesClubes.add(img);

          });
        });
  }
  imagenesStorageClubes2() async{
      final _storage = FirebaseStorage.instance;
      await _storage.ref('clubes/').listAll().then((value) {
        value.items.forEach((element) async {
          print(element.name);
          var escudo=element.name.replaceAll(".png", "");
          ImagenStorage img=new ImagenStorage();
          print(Config.escudoClubes(escudo));
          var imgequipo= await get(Uri.parse(Config.escudoClubes(escudo)));
          //element.getData().then((value) => img.imagen= value.buffer.asUint8List().toList());
          img.imagen=imgequipo;
          img.club=element.name.replaceAll(".png", "");
          Config.imagenesClubes.add(img);
        });
      });
//https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/clubes%2FSD%20Logron%CC%83e%CC%81s.png?alt=media&token=a4ace1d8-110a-4cca-b844-928d0cd66638
    }
    void inicio() async{
      JugadorDao jug= JugadorDao();
      List<Jugador> listEquipo2 = await jug.getTodosJugadores();
      //subirPais();
      //temporadas/2021-2022/paises/ESPA%C3%91A/categorias/Segunda%20B%20Grupo%20I/equipos/Burgos/jugadore
      // eliminar();
      //paises();
      //
      temporadas();
      // jugadores();
      //temporadas2DIVISION();
      // jugadores();
      // updatejugadores2();
      //addjugadores2B();
      //addjugadores2B();
      //actual();
      //_write("HOLA");

      //await fileJugadores();
      //await getCsv();
    }


    subirPais(){
      EquipoDao equ=EquipoDao();
      String nodeName = "temporadas/2021-2022/paises";
      //jug.eliminarTodoTemporadas();

    }

    eliminar() async {
      JugadorDao jug = JugadorDao();
      //jug.eliminarTodoTemporadas();
      //jug.eliminarTodoJugadores();

    }

    paises() async {
      JugadorDao jug= JugadorDao();
      EquipoDao equ=EquipoDao();
      String nodeName = "temporadas/2021-2022/paises";
      DatabaseReference dbRef =  FirebaseDatabase.instance.reference().child("temporadas/2021-2022/paises");

      //jug.eliminarTodoTemporadas();
      dbRef =
          FirebaseDatabase.instance.reference().child(nodeName+"/ALEMANIA");

      dbRef.set({
        "pais": "ALEMANIA",
      });

      dbRef =
          FirebaseDatabase.instance.reference().child(nodeName+"/FRANCIA");

      dbRef.set({
        "pais": "FRANCIA",
      });

      dbRef =FirebaseDatabase.instance.reference().child(nodeName+"/ARGENTINA");

      dbRef.set({
        "pais": "ARGENTINA",
      });

      dbRef =FirebaseDatabase.instance.reference().child(nodeName+"/ITALIA");

      dbRef.set({
        "pais": "ITALIA",
      });
      dbRef =FirebaseDatabase.instance.reference().child(nodeName+"/PORTUGAL");

      dbRef.set({
        "pais": "PORTUGAL",
      });

      dbRef = FirebaseDatabase.instance.reference().child(nodeName+"/URUGUAY");

      dbRef.set({
        "pais": "URUGUAY",
      });

    }

    temporadas() async {
      JugadorDao jug= JugadorDao();
      EquipoDao equ=EquipoDao();
      String nodeName = "temporadas/2021-2022/paises";
      /* FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA").remove();

  /* DatabaseReference dbRef =  FirebaseDatabase.instance.reference().child("temporadas/2021-2022");
     dbRef.set({
      "temporada": "2021-2022",
    });*/
    //jug.eliminarTodoTemporadas();
   DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA");

    dbRef.set({
      "pais": "ESPAÑA",
    });
    dbRef =
        FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División RFEF Grupo 1");
    //print(dbRef.toString());
    dbRef.set({
      "categoria": "2ª División RFEF Grupo 1",
    });
   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División RFEF Grupo 2");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "2ª División RFEF Grupo 2",
   });
    dbRef =
        FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División RFEF Grupo 3");
    //print(dbRef.toString());
    dbRef.set({
      "categoria": "2ª División RFEF Grupo 3",
    });
   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División RFEF Grupo 4");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "2ª División RFEF Grupo 4",
   });
   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División RFEF Grupo 5");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "2ª División RFEF Grupo 5",
   });
   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/1ª División RFEF Grupo 1");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "1ª División RFEF Grupo 1",
   });
   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/1ª División RFEF Grupo 2");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "1ª División RFEF Grupo 2",
   });

   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División A");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "2ª División A",
   });



   DatabaseReference dbRef =
   FirebaseDatabase.instance.reference().child(nodeName+"/ARGENTINA");

   dbRef =
       FirebaseDatabase.instance.reference().child(nodeName+"/ARGENTINA/categorias/1ª División Liga Argentina");
   //print(dbRef.toString());
   dbRef.set({
     "categoria": "1ª División Liga Argentina",
   });

   */
      /* String json2="";
   List<Jugador> listEquipo2 = await jug.getTodosJugadores();
   for (var i=0;i<listEquipo2.length;i++) {
     print("${i}:${listEquipo2[i].jugador},${listEquipo2[i].equipo},${listEquipo2[i].categoria}");
     listEquipo2[i].nivel="Sin nivel";
     listEquipo2[i].jugador;
     String pathEquipos="temporadas/2021-2022/paises/${listEquipo2[i].pais}/"
         "categorias/${listEquipo2[i].categoria}/"
         "equipos/${listEquipo2[i].equipo}";
     DatabaseReference dbRef1 =
     FirebaseDatabase.instance.reference().child(pathEquipos);
     dbRef1.set({
       "equipo" : "${listEquipo2[i].equipo}"
     });


   }*/

      /*
    //FirebaseDatabase.instance.reference().child("jugadores2021-2022").remove();

   BBDDService().getUserScout().temporada="2021-2022";
     String json="";
      List<Entrenador> list2 = await jug.getTodosEntrenadores();
      for (var i=0;i<list2.length;i++) {
        print("${i}:${list2[i].entrenador},${list2[i].equipo},${list2[i]
            .categoria}");
        list2[i].entrenador;
        //jug.updateJugadorIAScoutDorsal(list2[i], false);
        //jug.addJugadorIAScout(list2[i],true,i);

      }*/
    }

    getCsv() async {
      JugadorDao jug= JugadorDao();
      List<String> res = List();
      List<Jugador> list2 = await jug.getTodosJugadores();
      print("-----CSV------");
      print(list2.length);
      print("--------------");
      FirebaseDatabase _database = FirebaseDatabase.instance;
      String coma = "&";
      String enter = "\n";
      String jugador="";
      List<List<dynamic>> rows = List<List<dynamic>>();
      List<dynamic> row = List();
      row.add('jugador'.toUpperCase());
      row.add('equipo'.toUpperCase());
      row.add('categoria'.toUpperCase());
      row.add('ID'.toUpperCase());
      row.add('fechaNacimiento'.toUpperCase());
      row.add('posicion'.toUpperCase());
      row.add('pais'.toUpperCase());
      row.add('nivel'.toUpperCase());
      row.add('tipo'.toUpperCase());
      row.add('observaciones'.toUpperCase());
      row.add('ofe_niveltecnico'.toUpperCase());
      row.add('ofe_profundidad'.toUpperCase());
      row.add('ofe_capacidaddegenerarbuenoscentrosalarea'.toUpperCase());
      row.add('ofe_capacidaddeasociacion'.toUpperCase());
      row.add('ofe_desborde'.toUpperCase());
      row.add('ofe_superioridadpordentro'.toUpperCase());
      row.add('ofe_finalizacion'.toUpperCase());
      row.add('ofe_saquedebanda_longitud'.toUpperCase());
      row.add('ofe_lanzadordeabps'.toUpperCase());
      row.add('ofe_salidadebalon'.toUpperCase());
      row.add('ofe_paselargo_medio'.toUpperCase());
      row.add('ofe_cambiosdeorientacion'.toUpperCase());
      row.add('ofe_batelineasconpaseinterior'.toUpperCase());
      row.add('ofe_conduccionparadividir'.toUpperCase());
      row.add('ofe_primerpasetrasrecuperacion'.toUpperCase());
      row.add('ofe_intervieneenabps'.toUpperCase());
      row.add('ofe_velocidadeneljuego'.toUpperCase());
      row.add('ofe_incorporacionazonasderemate'.toUpperCase());
      row.add('ofe_amplitud'.toUpperCase());
      row.add('ofe_desmarquesdeapoyo'.toUpperCase());
      row.add('ofe_desmarquesderuptura'.toUpperCase());
      row.add('ofe_capacidaddegenerarbuenoscentroslateralesalarea'.toUpperCase());
      row.add('ofe_habilidad1vs1'.toUpperCase());
      row.add('ofe_realizaciondelultimopase'.toUpperCase());
      row.add('ofe_goleador'.toUpperCase());
      row.add('ofe_explotaciondeespacios'.toUpperCase());
      row.add('ofe_duelosaereos'.toUpperCase());
      row.add('ofe_desbordeporvelocidad'.toUpperCase());
      row.add('ofe_dominiode2vs1_pared'.toUpperCase());
      row.add('ofe_ambidextro'.toUpperCase());
      row.add('ofe_juegodecara'.toUpperCase());
      row.add('ofe_protecciondelbalon'.toUpperCase());
      row.add('ofe_caidasabanda'.toUpperCase());
      row.add('ofe_prolongacionesaereas'.toUpperCase());
      row.add('ofe_dominiodelarea'.toUpperCase());
      row.add('ofe_llegadaaposicionesderemate'.toUpperCase());
      row.add('ofe_juegoesespacioreducido'.toUpperCase());
      row.add('ofe_definidor_anteelportero'.toUpperCase());
      row.add('ofe_rematador_finalizador'.toUpperCase());
      row.add('ofe_capacidadasociativa_apoyosalalineadefensiva'.toUpperCase());
      row.add('ofe_desplazamientoenlargo'.toUpperCase());
      row.add('fis_velocidaddereaccion'.toUpperCase());
      row.add('fis_velocidaddedesplazamiento'.toUpperCase());
      row.add('fis_agilidad'.toUpperCase());
      row.add('fis_envergadura'.toUpperCase());
      row.add('fis_fuerza_potencia'.toUpperCase());
      row.add('fis_cuerpoacuerpo'.toUpperCase());
      row.add('fis_capacidaddesalto'.toUpperCase());
      row.add('fis_explosividad'.toUpperCase());
      row.add(
          '_fis_potenciadesaltolateralyvertical'.toUpperCase());
      row.add('fis_resistencia_idayvuelta'.toUpperCase());
      row.add('fis_cambioderitmo'.toUpperCase());
      row.add('psic_liderazgo'.toUpperCase());
      row.add('psic_comunicacion'.toUpperCase());
      row.add('psic_seguridad'.toUpperCase());
      row.add('psic_tomadedecisiones'.toUpperCase());
      row.add('psic_agresividad'.toUpperCase());
      row.add('psic_polivalencia'.toUpperCase());
      row.add('psic_competitividad'.toUpperCase());
      row.add('psic_agresividad_contundencia'.toUpperCase());
      row.add('psic_noasumeriesgosextremos'.toUpperCase());
      row.add('psic_entendimientodeljuego_inteligencia'.toUpperCase());
      row.add('psic_creatividad'.toUpperCase());
      row.add('psic_confianza'.toUpperCase());
      row.add('psic_compromiso'.toUpperCase());
      row.add('psic_valentia'.toUpperCase());
      row.add('psic_oportunismo'.toUpperCase());
      row.add('def_acoso_presionsobreeloponente'.toUpperCase());
      row.add('def_actituddefensiva'.toUpperCase());
      row.add('def_activaciondelosmecanismosdepresion'.toUpperCase());
      row.add('def_anticipacion'.toUpperCase());
      row.add('def_ayudaspermanentesallateral'.toUpperCase());
      row.add('def_capacidaddemarcaje'.toUpperCase());
      row.add('def_capacidadparataparcentros'.toUpperCase());
      row.add(
          '_def_cerrarelladodebil_basculaciones'.toUpperCase());
      row.add('def_cierralineasdepase'.toUpperCase());
      row.add('def_coberturadecentrales'.toUpperCase());
      row.add('def_coberturas'.toUpperCase());
      row.add('def_colocacion'.toUpperCase());
      row.add('def_comportamientofueradezona'.toUpperCase());
      row.add('def_correctabasculacion'.toUpperCase());
      row.add('def_correctabasculacion_distanciadeintervalos'.toUpperCase());
      row.add('def_correctoperfilamiento'.toUpperCase());
      row.add('def_cruces'.toUpperCase());
      row.add('def_destrezaantecentroslaterales'.toUpperCase());
      row.add('def_dificildesuperarenel1vs1'.toUpperCase());
      row.add('def_dominiodelaszonasderechace'.toUpperCase());
      row.add('def_duelosaereos'.toUpperCase());
      row.add('def_duelosdefensivos'.toUpperCase());
      row.add('def_evitarecepcionesentrelineas'.toUpperCase());
      row.add('def_evitaserdesbordado'.toUpperCase());
      row.add('def_interceptaciondetiro'.toUpperCase());
      row.add('def_mantenerlalineadefensiva'.toUpperCase());
      row.add(
          '_def_marcajeproximoaoponentedirecto'.toUpperCase());
      row.add('def_ocupaespaciosdecompanerossuperados'.toUpperCase());
      row.add('def_perfilamientos'.toUpperCase());
      row.add('def_permiteelgiro'.toUpperCase());
      row.add('def_presiontrasperdida'.toUpperCase());
      row.add('def_resolucionanteparedesrivales'.toUpperCase());
      row.add('def_sabecuidarsuespalda'.toUpperCase());
      row.add('def_vigilayreferenciaalrival_enfaseofensiva'.toUpperCase());
      row.add('def_vigilanciassobrelateralrival'.toUpperCase());
      row.add('def_blocaje'.toUpperCase());
      row.add('def_juegoaereolateral'.toUpperCase());
      row.add('def_juegoaereofrontal'.toUpperCase());
      row.add('def_habilidadenel1vs1'.toUpperCase());
      row.add('def_despeje'.toUpperCase());
      row.add('def_anticipacion_intuicion'.toUpperCase());
      row.add('def_coberturadelineadefensiva'.toUpperCase());
      row.add('def_abps'.toUpperCase());
      row.add('def_penaltis'.toUpperCase());
      row.add('nombre'.toUpperCase());
      row.add('email'.toUpperCase());
      row.add('fecha'.toUpperCase());
      row.add('fechaContrato'.toUpperCase());
      row.add('dorsal'.toUpperCase());
      row.add('peso'.toUpperCase());
      row.add('altura'.toUpperCase());
      row.add('valor'.toUpperCase());
      row.add('paisNacimiento'.toUpperCase());
      row.add('contrato'.toUpperCase());
      row.add('veredicto'.toUpperCase());
      row.add('prestamo'.toUpperCase());
      row.add('lateral'.toUpperCase());
      rows.add(row);
      for (int i=0;i<list2.length;i++) {
        String pathTemporadas = "temporadas/${BBDDService().getUserScout().temporada}/paises/${list2[i].pais}/"
            "categorias/${list2[i].categoria}/"
            "equipos/${list2[i].equipo}/jugadores/${list2[i].id}";
        print(pathTemporadas);
        await _database.reference()
            .child(pathTemporadas)
            .once()
            .then((DataSnapshot snapshotResult) {
          List<dynamic> row = List();
          if (snapshotResult == null || snapshotResult.value == null){print("NULL");return null;}

          print(i.toString());
          print(list2[i].jugador);
          print(snapshotResult.value["jugador"]);

          row.add('${snapshotResult.value["jugador"]}');
          row.add('${snapshotResult.value["equipo"]}');
          row.add('${snapshotResult.value["categoria"]}');
          row.add('$jugador ${snapshotResult.value["jugador"].toString()
              .toUpperCase()
              .replaceAll(" ", "")}${snapshotResult.value["posicion"]
              .toString()
              .replaceAll(" ", "")}');
          row.add('${snapshotResult.value["fechaNacimiento"]}');
          row.add('${snapshotResult.value["posicion"]}');
          row.add('${snapshotResult.value["pais"]}');
          row.add('${snapshotResult.value["nivel"]}');
          row.add('${snapshotResult.value["tipo"]}');
          row.add('${snapshotResult.value["observaciones_1"]}'.replaceAll("\n", " "));
          row.add('${snapshotResult.value["_ofe_niveltecnico"]}');
          row.add('${snapshotResult.value["_ofe_profundidad"]}');
          row.add('${snapshotResult
              .value["_ofe_capacidaddegenerarbuenoscentrosalarea"]}');
          row.add('${snapshotResult.value["_ofe_capacidaddeasociacion"]}');
          row.add('${snapshotResult.value["_ofe_desborde"]}');
          row.add('${snapshotResult.value["_ofe_superioridadpordentro"]}');
          row.add('${snapshotResult.value["_ofe_finalizacion"]}');
          row.add('${snapshotResult.value["_ofe_saquedebanda_longitud"]}');
          row.add('${snapshotResult.value["_ofe_lanzadordeabps"]}');
          row.add('${snapshotResult.value["_ofe_salidadebalon"]}');
          row.add('${snapshotResult.value["_ofe_paselargo_medio"]}');
          row.add('${snapshotResult.value["_ofe_cambiosdeorientacion"]}');
          row.add('${snapshotResult.value["_ofe_batelineasconpaseinterior"]}');
          row.add('${snapshotResult.value["_ofe_conduccionparadividir"]}');
          row.add('${snapshotResult.value["_ofe_primerpasetrasrecuperacion"]}');
          row.add('${snapshotResult.value["_ofe_intervieneenabps"]}');
          row.add('${snapshotResult.value["_ofe_velocidadeneljuego"]}');
          row.add('${snapshotResult.value["_ofe_incorporacionazonasderemate"]}');
          row.add('${snapshotResult.value["_ofe_amplitud"]}');
          row.add('${snapshotResult.value["_ofe_desmarquesdeapoyo"]}');
          row.add('${snapshotResult.value["_ofe_desmarquesderuptura"]}');
          row.add('${snapshotResult
              .value["_ofe_capacidaddegenerarbuenoscentroslateralesalarea"]}');
          row.add('${snapshotResult.value["_ofe_habilidad1vs1"]}');
          row.add('${snapshotResult.value["_ofe_realizaciondelultimopase"]}');
          row.add('${snapshotResult.value["_ofe_goleador"]}');
          row.add('${snapshotResult.value["_ofe_explotaciondeespacios"]}');
          row.add('${snapshotResult.value["_ofe_duelosaereos"]}');
          row.add('${snapshotResult.value["_ofe_desbordeporvelocidad"]}');
          row.add('${snapshotResult.value["_ofe_dominiode2vs1_pared"]}');
          row.add('${snapshotResult.value["_ofe_ambidextro"]}');
          row.add('${snapshotResult.value["_ofe_juegodecara"]}');
          row.add('${snapshotResult.value["_ofe_protecciondelbalon"]}');
          row.add('${snapshotResult.value["_ofe_caidasabanda"]}');
          row.add('${snapshotResult.value["_ofe_prolongacionesaereas"]}');
          row.add('${snapshotResult.value["_ofe_dominiodelarea"]}');
          row.add('${snapshotResult.value["_ofe_llegadaaposicionesderemate"]}');
          row.add('${snapshotResult.value["_ofe_juegoesespacioreducido"]}');
          row.add('${snapshotResult.value["_ofe_definidor_anteelportero"]}');
          row.add('${snapshotResult.value["_ofe_rematador_finalizador"]}');
          row.add('${snapshotResult
              .value["_ofe_capacidadasociativa_apoyosalalineadefensiva"]}');
          row.add('${snapshotResult.value["_ofe_desplazamientoenlargo"]}');
          row.add('${snapshotResult.value["_fis_velocidaddereaccion"]}');
          row.add('${snapshotResult.value["_fis_velocidaddedesplazamiento"]}');
          row.add('${snapshotResult.value["_fis_agilidad"]}');
          row.add('${snapshotResult.value["_fis_envergadura"]}');
          row.add('${snapshotResult.value["_fis_fuerza_potencia"]}');
          row.add('${snapshotResult.value["_fis_cuerpoacuerpo"]}');
          row.add('${snapshotResult.value["_fis_capacidaddesalto"]}');
          row.add('${snapshotResult.value["_fis_explosividad"]}');
          row.add(
              '${snapshotResult.value["_fis_potenciadesaltolateralyvertical"]}');
          row.add('${snapshotResult.value["_fis_resistencia_idayvuelta"]}');
          row.add('${snapshotResult.value["_fis_cambioderitmo"]}');
          row.add('${snapshotResult.value["_psic_liderazgo"]}');
          row.add('${snapshotResult.value["_psic_comunicacion"]}');
          row.add('${snapshotResult.value["_psic_seguridad"]}');
          row.add('${snapshotResult.value["_psic_tomadedecisiones"]}');
          row.add('${snapshotResult.value["_psic_agresividad"]}');
          row.add('${snapshotResult.value["_psic_polivalencia"]}');
          row.add('${snapshotResult.value["_psic_competitividad"]}');
          row.add('${snapshotResult.value["_psic_agresividad_contundencia"]}');
          row.add('${snapshotResult.value["_psic_noasumeriesgosextremos"]}');
          row.add('${snapshotResult
              .value["_psic_entendimientodeljuego_inteligencia"]}');
          row.add('${snapshotResult.value["_psic_creatividad"]}');
          row.add('${snapshotResult.value["_psic_confianza"]}');
          row.add('${snapshotResult.value["_psic_compromiso"]}');
          row.add('${snapshotResult.value["_psic_valentia"]}');
          row.add('${snapshotResult.value["_psic_oportunismo"]}');
          row.add('${snapshotResult.value["_def_acoso_presionsobreeloponente"]}');
          row.add('${snapshotResult.value["_def_actituddefensiva"]}');
          row.add('${snapshotResult
              .value["_def_activaciondelosmecanismosdepresion"]}');
          row.add('${snapshotResult.value["_def_anticipacion"]}');
          row.add('${snapshotResult.value["_def_ayudaspermanentesallateral"]}');
          row.add('${snapshotResult.value["_def_capacidaddemarcaje"]}');
          row.add('${snapshotResult.value["_def_capacidadparataparcentros"]}');
          row.add(
              '${snapshotResult.value["_def_cerrarelladodebil_basculaciones"]}');
          row.add('${snapshotResult.value["_def_cierralineasdepase"]}');
          row.add('${snapshotResult.value["_def_coberturadecentrales"]}');
          row.add('${snapshotResult.value["_def_coberturas"]}');
          row.add('${snapshotResult.value["_def_colocacion"]}');
          row.add('${snapshotResult.value["_def_comportamientofueradezona"]}');
          row.add('${snapshotResult.value["_def_correctabasculacion"]}');
          row.add('${snapshotResult
              .value["_def_correctabasculacion_distanciadeintervalos"]}');
          row.add('${snapshotResult.value["_def_correctoperfilamiento"]}');
          row.add('${snapshotResult.value["_def_cruces"]}');
          row.add('${snapshotResult.value["_def_destrezaantecentroslaterales"]}');
          row.add('${snapshotResult.value["_def_dificildesuperarenel1vs1"]}');
          row.add('${snapshotResult.value["_def_dominiodelaszonasderechace"]}');
          row.add('${snapshotResult.value["_def_duelosaereos"]}');
          row.add('${snapshotResult.value["_def_duelosdefensivos"]}');
          row.add('${snapshotResult.value["_def_evitarecepcionesentrelineas"]}');
          row.add('${snapshotResult.value["_def_evitaserdesbordado"]}');
          row.add('${snapshotResult.value["_def_interceptaciondetiro"]}');
          row.add('${snapshotResult.value["_def_mantenerlalineadefensiva"]}');
          row.add(
              '${snapshotResult.value["_def_marcajeproximoaoponentedirecto"]}');
          row.add('${snapshotResult
              .value["_def_ocupaespaciosdecompanerossuperados"]}');
          row.add('${snapshotResult.value["_def_perfilamientos"]}');
          row.add('${snapshotResult.value["_def_permiteelgiro"]}');
          row.add('${snapshotResult.value["_def_presiontrasperdida"]}');
          row.add('${snapshotResult.value["_def_resolucionanteparedesrivales"]}');
          row.add('${snapshotResult.value["_def_sabecuidarsuespalda"]}');
          row.add('${snapshotResult
              .value["_def_vigilayreferenciaalrival_enfaseofensiva"]}');
          row.add('${snapshotResult.value["_def_vigilanciassobrelateralrival"]}');
          row.add('${snapshotResult.value["_def_blocaje"]}');
          row.add('${snapshotResult.value["_def_juegoaereolateral"]}');
          row.add('${snapshotResult.value["_def_juegoaereofrontal"]}');
          row.add('${snapshotResult.value["_def_habilidadenel1vs1"]}');
          row.add('${snapshotResult.value["_def_despeje"]}');
          row.add('${snapshotResult.value["_def_anticipacion_intuicion"]}');
          row.add('${snapshotResult.value["_def_coberturadelineadefensiva"]}');
          row.add('${snapshotResult.value["_def_abps"]}');
          row.add('${snapshotResult.value["_def_penaltis"]}');
          row.add('${snapshotResult.value["nombre"]}');
          row.add('${snapshotResult.value["email"]}');
          row.add('${snapshotResult.value["fecha"]}');
          row.add('${snapshotResult.value["_fechaContrato"]}');
          row.add('${snapshotResult.value["_dorsal"]}');
          row.add('${snapshotResult.value["_peso"]}');
          row.add('${snapshotResult.value["_altura"]}');
          row.add('${snapshotResult.value["_valor"]}');
          row.add('${snapshotResult.value["_paisNacimiento"]}');
          row.add('${snapshotResult.value["_contrato"]}');
          row.add('${snapshotResult.value["_veredicto"]}');
          row.add('${snapshotResult.value["_prestamo"]}');
          row.add('${snapshotResult.value["_lateral"]}');
          rows.add(row);
          i++;
        });
        //print(snapshotResult.value);
        // }
      }
      //store file in documents folder
      //final Directory directory = await getApplicationDocumentsDirectory();
      //File f = new File('/Users/borch/Documents/2ab.csv');

// convert rows to String and write as csv file

      //String csv = const ListToCsvConverter().convert(rows,fieldDelimiter: ",");
      // await f.writeAsString(csv);

      /*final csvFile = new File('/Users/borch/Documents/2ab.csv').openRead();
    await csvFile
        .transform(utf8.decoder)
        .transform(
      CsvToListConverter(),
    )
        .toList();*/
    }


    Future fileJugadores() async {

      _jugadoresFile();
      await _write(jugadorAux);
    }

    _jugadoresFile() async{
      JugadorDao jug= JugadorDao();

      List<String> res = List();
      List<Jugador> list2 = await jug.getTodosJugadores();
      print("------------");
      print(list2.length);
      print("------------");
      FirebaseDatabase _database = FirebaseDatabase.instance;
      String coma = "&";
      String enter = "\n";
      String jugador="";
      print(jugador);
      for (int i=0;i<list2.length;i++) {

        String pathTemporadas="temporadas/${BBDDService().getUserScout().temporada}/paises/${list2[i].pais}/"
            "categorias/${list2[i].categoria}/"
            "equipos/${list2[i].equipo}/jugadores/${list2[i].id}";
        print(pathTemporadas);
        await _database.reference()
            .child(pathTemporadas)
            .once()
            .then((DataSnapshot snapshotResult) {
          jugador="";
          if (snapshotResult == null || snapshotResult.value == null) return null;
          print("------------");
          print(i.toString());
          print(list2[i].jugador);
          print(snapshotResult.value["jugador"]);
          print("------------");
          //print(snapshotResult.value);

          //jugador ='$jugador ${snapshotResult.value["jugador"].toString().toUpperCase().replaceAll(" ", "")}${snapshotResult.value["posicion"].toString().replaceAll(" ", "")}  ';
          jugador = '$jugador  ${snapshotResult.value["jugador"]}';
          jugador = '$jugador $coma ${snapshotResult.value["equipo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["posicion"]}';
          jugador = '$jugador $coma ${snapshotResult.value["categoria"]}';
          jugador = '$jugador $coma ${snapshotResult.value["fechaNacimiento"]}';
          jugador = '$jugador $coma ${snapshotResult.value["equipo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["pais"]}';
          jugador = '$jugador $coma ${snapshotResult.value["nivel"]}';
          jugador = '$jugador $coma ${snapshotResult.value["tipo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["observaciones_1"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_niveltecnico"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_profundidad"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_capacidaddegenerarbuenoscentrosalarea"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_capacidaddeasociacion"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_desborde"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_superioridadpordentro"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_finalizacion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_saquedebanda_longitud"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_lanzadordeabps"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_salidadebalon"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_paselargo_medio"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_cambiosdeorientacion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_batelineasconpaseinterior"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_conduccionparadividir"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_primerpasetrasrecuperacion"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_intervieneenabps"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_velocidadeneljuego"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_incorporacionazonasderemate"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_amplitud"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_desmarquesdeapoyo"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_desmarquesderuptura"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_capacidaddegenerarbuenoscentroslateralesalarea"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_habilidad1vs1"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_realizaciondelultimopase"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_goleador"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_explotaciondeespacios"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_duelosaereos"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_desbordeporvelocidad"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_dominiode2vs1_pared"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_ambidextro"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_juegodecara"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_protecciondelbalon"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_caidasabanda"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_prolongacionesaereas"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_ofe_dominiodelarea"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_llegadaaposicionesderemate"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_juegoesespacioreducido"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_definidor_anteelportero"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_rematador_finalizador"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_capacidadasociativa_apoyosalalineadefensiva"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_ofe_desplazamientoenlargo"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_fis_velocidaddereaccion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_fis_velocidaddedesplazamiento"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_agilidad"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_envergadura"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_fuerza_potencia"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_cuerpoacuerpo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_capacidaddesalto"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_explosividad"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_fis_potenciadesaltolateralyvertical"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_fis_resistencia_idayvuelta"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fis_cambioderitmo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_liderazgo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_comunicacion"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_seguridad"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_tomadedecisiones"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_agresividad"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_polivalencia"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_competitividad"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_psic_agresividad_contundencia"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_psic_noasumeriesgosextremos"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_psic_entendimientodeljuego_inteligencia"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_creatividad"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_confianza"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_compromiso"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_valentia"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_psic_oportunismo"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_acoso_presionsobreeloponente"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_actituddefensiva"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_activaciondelosmecanismosdepresion"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_anticipacion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_ayudaspermanentesallateral"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_capacidaddemarcaje"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_capacidadparataparcentros"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_cerrarelladodebil_basculaciones"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_cierralineasdepase"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_coberturadecentrales"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_coberturas"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_colocacion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_comportamientofueradezona"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_correctabasculacion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_correctabasculacion_distanciadeintervalos"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_correctoperfilamiento"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_cruces"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_destrezaantecentroslaterales"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_dificildesuperarenel1vs1"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_dominiodelaszonasderechace"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_duelosaereos"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_duelosdefensivos"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_evitarecepcionesentrelineas"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_evitaserdesbordado"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_interceptaciondetiro"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_mantenerlalineadefensiva"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_marcajeproximoaoponentedirecto"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_ocupaespaciosdecompanerossuperados"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_perfilamientos"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_permiteelgiro"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_presiontrasperdida"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_resolucionanteparedesrivales"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_sabecuidarsuespalda"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_vigilayreferenciaalrival_enfaseofensiva"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_vigilanciassobrelateralrival"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_blocaje"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_juegoaereolateral"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_juegoaereofrontal"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_habilidadenel1vs1"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_despeje"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_anticipacion_intuicion"]}';
          jugador =
          '$jugador $coma ${snapshotResult.value["_def_coberturadelineadefensiva"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_abps"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_def_penaltis"]}';
          jugador = '$jugador $coma ${snapshotResult.value["nombre"]}';
          jugador = '$jugador $coma ${snapshotResult.value["email"]}';
          jugador = '$jugador $coma ${snapshotResult.value["fecha"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_fechaContrato"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_dorsal"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_peso"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_altura"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_valor"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_paisNacimiento"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_contrato"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_veredicto"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_prestamo"]}';
          jugador = '$jugador $coma ${snapshotResult.value["_lateral"]}';

          jugadorAux+='$jugador $enter';

          i++;
        });
        //
      }
      return jugadorAux;
    }
    _write(String text) async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('/Users/borch/Documents/2ABB.txt');
      await file.writeAsString(text, encoding: utf8 );
      print("===============================================");
      print(jugadorAux);
      print("===============================================");
    }
    addjugadores2B() async{

      JugadorDao jug= JugadorDao();
      // List<Jugador> list2 = await jug.getTodosJugadoresEquipo("Almería");
      // List<Jugador> list2 = await jug.getTodosJugadores();
      // List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 1 A");
      // List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 1 B");
      //  List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 2 A");
      //  List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 2 B");
      // List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 3 A");
      // List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 3 B");
      //  List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 4 A");
      // List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 4 B");
      // List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 5 A");
      List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 1 A");
      for (var i=0;i<list2.length;i++) {
        print("${i}:${list2[i].jugador},${list2[i].equipo},${list2[i].categoria}");
        list2[i].nivel="Sin nivel";
        list2[i].jugador;
        //jug.addJugadorIAScout(_jugador, jugadores, i)
        jug.addJugadorIAScout(list2[i],false,i);
        // jug.addJugadorIAScout(list2[i],true,i);

      }
    }

    updatejugadores2() async{

      JugadorDao jug= JugadorDao();
      // List<Jugador> list2 = await jug.getTodosJugadoresEquipo("Almería");
      // List<Jugador> list2 = await jug.getTodosJugadores();
      List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División B Grupo 4 B");
      for (var i=0;i<list2.length;i++) {
        print("${i}:${list2[i].jugador},${list2[i].equipo},${list2[i].categoria}");
        list2[i].nivel="Sin nivel";
        list2[i].jugador;
        print(list2[i].paisNacimiento);
        //jug.addJugadorIAScout(_jugador, jugadores, i)
        jug.updateJugadorIAScoutDorsal(list2[i],false);
        // jug.addJugadorIAScout(list2[i],true,i);

      }
    }


    temporadas2DIVISION() async {
      JugadorDao jug= JugadorDao();
      EquipoDao equ=EquipoDao();
      String nodeName = "temporadas/2021-2022/paises";
      //jug.eliminarTodoTemporadas();
      DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA");

      dbRef =
          FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División A");
      //print(dbRef.toString());
      dbRef.set({
        "categoria": "2ª División A",
      });


      EquipoDao con=EquipoDao();
      List<Equipo> lista= await con.getAllEquipo("ESPAÑA", "2ª División A");
      for (var i=0;i<lista.length;i++) {
        dbRef =
            FirebaseDatabase.instance.reference().child(nodeName+"/ESPAÑA/categorias/2ª División A/equipos/${lista[i].equipo}");

        dbRef.set({
          "equipo": lista[i].equipo,
        });
        //print("${i}:${lista[i].equipo}");
      }


      String json="";
      List<Jugador> list2 = await jug.getTodosJugadoresCategorias("2ª División A");
      for (var i=0;i<list2.length;i++) {
        print("${i}:${list2[i].jugador},${list2[i].equipo},${list2[i].categoria}");
        list2[i].nivel="Sin nivel";
        list2[i].jugador;
        print(list2[i].jugador);
        jug.addJugadorIAScout(list2[i],false,0);
        //jug.addJugadorIAScout(list2[i],true,i);

      }
    }

    jugadores() async {
      JugadorDao jug= JugadorDao();
      jug.eliminarTodoJugadores();
      String json="";
      List<Jugador> list2 = await jug.getTodosJugadores();
      for (var i=0;i<list2.length;i++) {
        ////print("${i}:${list2[i].jugador},${list2[i].equipo},${list2[i].categoria}");
        jug.addJugadorIAScout(list2[i],false,i);
        //jug.addJugadorIAScout(list2[i],true,i);
        //print(i);
      }
    }
  }








