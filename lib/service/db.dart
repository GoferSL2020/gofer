
import 'dart:io';
import 'dart:typed_data';

import 'package:iadvancedscout/model/equipo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static final DB _instance = new DB.internal();
  factory DB() => _instance;
  static Database _db;
  Future<Database> get db async {

    if (_db != null) {
      print("ENTRO1");
      print(_db.path);
      //actual();
      return _db;
    }
    _db = await initDB();
    print(_db.path);
    return _db;
  }
  DB.internal();

// A continuación, define la función para insertar dogs en la base de datos
  Future<void> actual() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "IAScout21-22.db");
    print("ENTRO actual");
    await _db.execute("delete  from  jugador ");
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Manu Herrera','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','19/09/1981','Portero','','',0,0,1,'','00/01/1900','Madrid','Madrid','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('R. Bairam','ESPAÑA','Español/Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','19/11/2000','Lateral izquierdo','Lateral derecho','',0,0,2,'','00/01/1900','Canarias','Canarias','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('L. Ferroni','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','29/01/1996','Lateral izquierdo','','',0,0,3,'','00/01/1900','Argentina','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Alexis Egea','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','25/12/1987','Defensa central derecho','','',0,0,4,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('M. Bellotti','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','21/01/2002','Volante derecho','Volante izquierdo','',0,0,5,'','00/01/1900','Argentina','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('José García','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','08/07/1991','Volante derecho','','',0,0,6,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Eric Jimenez','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','24/05/1997','Mediapunta derecho','Mediapunta izquierdo','',0,0,7,'','00/01/1900','Barcelona','Cataluña','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Miguel Mari','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','30/06/1997','Volante izquierdo','Pivote','',0,0,8,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Carlos Carmona','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','05/07/1987','Delantero centro','Interior izquierdo','',0,0,9,'','00/01/1900','Baleares','Baleares','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Cristian Herrera','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','29/03/1994','Delantero centro','Mediapunta izquierdo','',0,0,10,'','00/01/1900','Girona','Cataluña','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Pol Roigé','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','28/01/1994','Interior derecho','Volante izquierdo','',0,0,11,'','00/01/1900','Barcelona','Cataluña','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('J. Nuñez','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','29/01/1993','Interior derecho','Delantero centro','',0,0,12,'','00/01/1900','Panamá','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Carlos Carrasco','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','14/02/1993','Volante izquierdo','Mediapunta','',0,0,14,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Álvaro Pérez','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','07/03/1996','Defensa central izquierdo','','',0,0,15,'','00/01/1900','Valencia','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Victor','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','28/07/2002','Defensa central izquierdo','Defensa central derecho','',0,0,16,'','00/01/1900','Madrid','Madrid','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Juanma Ortiz','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','01/03/1982','Lateral derecho','','',0,0,17,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Borja Viguera','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','26/03/1987','Delantero centro','','',0,0,18,'','00/01/1900','La Rioja','La Rioja','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('E. Cabrera','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','20/11/1999','Mediapunta','Delantero centro','',0,0,19,'','00/01/1900','Argentina','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('J. Tellería','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','10/04/2003','Interior izquierdo','Interior derecho','',0,0,20,'','00/01/1900','Costa Rica','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Benja','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','23/08/1987','Delantero centro','','',0,0,21,'','00/01/1900','Barcelona','Cataluña','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('I. Kecojević','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','10/04/1988','Defensa central derecho','Defensa central izquierdo','',0,0,22,'','00/01/1900','Montenegro','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Javier Heredia','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','27/09/1999','Delantero centro','','',0,0,23,'','00/01/1900','Desconocida','Desconocida','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Juan Pablo Salomen','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','-','Portero','','',0,0,25,'','00/01/1900','Desconocida','Desconocida','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Fabricio Alemán','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','26/07/2003','Mediapunta izquierdo','Mediapunta derecho','',0,0,31,'','00/01/1900','Costa Rica','NA','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Victor Poveda','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','02/02/2000','Lateral izquierdo','','',0,0,33,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
    await _db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('S. Husic','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','06/08/2002','Defensa central izquierdo','','',0,0,-2,'','00/01/1900','Bosnia y Herzegovina','NA','','unknown','')");


  await openDatabase(path, version: 1, onOpen: (db) {
       print("ENTRO1 openDatabase");
      });
    // Obtiene una referencia de la base de datos
    final Database db = await _db;

  }


  initDB() async {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, "IAScout21-22.db");
      print(path);

      return await openDatabase(path, version: 1, onOpen: (db) {
      }, onCreate: (Database db, int version) async {
       /* await db.execute("CREATE TABLE PAIS ("
            "PAIS TEXT PRIMARY KEY,"
            "IMAGEN BLOB NULL"
            ")");

        await db.execute("CREATE TABLE CATEGORIA ("
            "CATEGORIA TEXT PRIMARY KEY ,"
            "PAIS TEXT,"
            "IMAGEN BLOB NULL"
            ")");
        await db.execute("CREATE TABLE EQUIPO ("
            "EQUIPO TEXT PRIMARY KEY,"
            "PAIS TEXT,"
            "CATEGORIA TEXT,"
            "IMAGEN BLOB NULL"
            ")");



        await db.execute("INSERT into PAIS VALUES("
            "'ESPAÑA',"
            "null"
            ")");
        //await db.execute("INSERT into PAIS VALUES('PORTUGAL',null)");
        await db.execute("INSERT into CATEGORIA VALUES('2ª División RFEF Grupo 1', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('2ª División RFEF Grupo 2', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('2ª División RFEF Grupo 3', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('2ª División RFEF Grupo 4', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('2ª División RFEF Grupo 5', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('1ª División RFEF Grupo 1', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('1ª División RFEF Grupo 2', 'ESPAÑA', null)");
        await db.execute("INSERT into CATEGORIA VALUES('2ª División A', 'ESPAÑA', null)");
*/

        //await db.execute("DROP TABLE jugador");
        /*await db.execute("create table jugador  ("
            "JUGADOR   TEXT default '',"
            "PAIS   TEXT default '',"
            "NACIONALIDAD   TEXT default '',"
            "CATEGORIA   TEXT default '',"
            "EQUIPO   TEXT default '',"
            "FECHANACIMIENTO   TEXT default '',"
            "POSICION   TEXT default '',"
            "POSICION_ALTERNATIVA   TEXT default '',"
            "IMAGEN   TEXT default '',"
            "PESO int default 0,"
            "ALTURA int default 0,"
            "DORSAL int default 0,"
            "VALOR  TEXT default '',"
            "FECHACONTRATO   TEXT default '',"
            "LUGAR_NACIMIENTO   TEXT default '',"
            "CCAA   TEXT default '',"
            "CONTRATO   TEXT default '',"
            "LATERAL   TEXT default '',"
            "VEREDICTO   TEXT default '',"
            "KEY   TEXT default '',"
            "NIVEL   int default 0,"
            "OBSERVAIONES_1   TEXT default '',"
            "fis_altura  TEXT default 'Altura reseñable para su posición',"
            "fis_arranquespotentes   int default 0,"
            "fis_buenaenespacioreduccion   int default 0,"
            "fis_capacidaddesalto   int default 0,"
            "fis_complexion_fisica   TEXT default 'Grande',"
            "fis_cubrecampoocupaciondeespacios   int default 0,"
            "fis_dinamicomovilidad   int default 0,"
            "fis_escasaenespacioreducido   int default 0,"
            "fis_fondoresistente   int default 0,"
            "fis_fuerza_lucha   TEXT default 'Gana los cuerpo a cuerpo',"
            "fis_potenteencarrera   int default 0,"
            "fis_rapidoemgirosycambiosdedireccion   int default 0,"
            "fis_toscoengirotcambiocambiosdedireccion   int default 0,"
            "fis_velocidad_desp   TEXT default 'Gran velocidad en distancia larga',"
            "fis_zancadaamplia   int default 0,"
            "psic_competitivo   int default 0,"
            "psic_concentracion   int default 0,"
            "psic_disciplinado   int default 0,"
            "psic_empuje   int default 0,"
            "psic_esfurezo   int default 0,"
            "psic_liderazgo   int default 0,"
            "psic_vozdemando   int default 0,"
            "tac_accionen2dasjugadas   int default 1,"
            "tac_acosopresionsobreoponente   int default 1,"
            "tac_anticipaciones   int default 1,"
            "tac_astucia   int default 1,"
            "tac_atacaelespaciodesmarquederuptura   int default 1,"
            "tac_atraearivalesamenazamarcas   int default 1,"
            "tac_basculacionyrelacionintralinea   int default 1,"
            "tac_caerabanda   int default 1,"
            "tac_cambiosderitmojuego   int default 1,"
            "tac_coberturas   int default 1,"
            "tac_contundencia   int default 1,"
            "tac_creativo   int default 1,"
            "tac_equilibrioatdef   int default 1,"
            "tac_generaespaciosmovimientosdiagonales   int default 1,"
            "tac_interrumpircortarjuegorival   int default 1,"
            "tac_juegoentrelineas   int default 1,"
            "tac_llegaalineadefondodesborde   int default 1,"
            "tac_llegadaaarearival   int default 1,"
            "tac_mejorpordentro   int default 0,"
            "tac_movimientosdiagonalesfinalizacionasociacion   int default 1,"
            "tac_movimientosverticalesprofundidad   int default 1,"
            "tac_proyeccionofensiva   int default 1,"
            "tac_repliegues   int default 1,"
            "tac_resolucionanteparedesrivales   int default 1,"
            "tac_responsabilidadllevarjuegoofensivo   int default 1,"
            "tac_vigilancias   int default 1,"
            "tec_aereo   int default 1,"
            "tec_aereo_abp_df   int default 1,"
            "tec_aereo_abp_of   int default 1,"
            "tec_capacidad_marcaje   TEXT default 'Muy buena',"
            "tec_capacidad_tapar_centros   TEXT default 'No lo superan',"
            "tec_capacidadjuegocombinado   int default 1,"
            "tec_centros   int default 1,"
            "tec_cierredelineasdepase   int default 1,"
            "tec_definicion   int default 1,"
            "tec_desplazamientosmedios   int default 1,"
            "tec_dificultaden1vs1   int default 0,"
            "tec_disputas   int default 1,"
            "tec_duelos1vs1   int default 1,"
            "tec_ejecutarparedes   int default 1,"
            "tec_frontales   int default 1,"
            "tec_generales   int default 1,"
            "tec_gestostecnicos   TEXT default 'Muy buenos',"
            "tec_goleador   TEXT default 'Si',"
            "tec_golpeosapuerta   int default 1,"
            "tec_habilidosodesequilibrante   int default 1,"
            "tec_habiolidosos   int default 0,"
            "tec_juegoa12toques   int default 1,"
            "tec_jugarapiernacambiada   int default 1,"
            "tec_laterales   int default 1,"
            "tec_malotecnicamente   int default 0,"
            "tec_muybuenos   int default 0,"
            "tec_normales   int default 0,"
            "tec_orientados   int default 1,"
            "tec_pasescortos   int default 1,"
            "tec_pasesfiltrados   int default 1,"
            "tec_paseslargos   int default 1,"
            "tec_perdidasdebalones   int default 1,"
            "tec_perfil   TEXT default 'Diestro',"
            "tec_provocasituacionesde1vs1   int default 1,"
            "tec_regateconmaspotencia   int default 0,"
            "tec_salida_de_balon   TEXT default 'Buenos controles para superar',"
            "tec_salidaconducciones   int default 1,"
            "tec_superaconespacio   int default 0,"
            "tec_temporizacionesofensivas   int default 1,"
            "tec_tipoconducciones   TEXT default 'Larga distancia',"
            "tec_usopiernanodominante   int default 1,"
            "primary key (jugador, equipo, pais, categoria, posicion, fechaNacimiento)"
            ")");*/
        await db.execute("delete from  jugador ");
        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Manu Herrera','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','19/09/1981','Portero','','',0,0,1,'','00/01/1900','Madrid','Madrid','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('R. Bairam','ESPAÑA','Español/Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','19/11/2000','Lateral izquierdo','Lateral derecho','',0,0,2,'','00/01/1900','Canarias','Canarias','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('L. Ferroni','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','29/01/1996','Lateral izquierdo','','',0,0,3,'','00/01/1900','Argentina','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Alexis Egea','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','25/12/1987','Defensa central derecho','','',0,0,4,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('M. Bellotti','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','21/01/2002','Volante derecho','Volante izquierdo','',0,0,5,'','00/01/1900','Argentina','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('José García','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','08/07/1991','Volante derecho','','',0,0,6,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Eric Jimenez','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','24/05/1997','Mediapunta derecho','Mediapunta izquierdo','',0,0,7,'','00/01/1900','Barcelona','Cataluña','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Miguel Mari','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','30/06/1997','Volante izquierdo','Pivote','',0,0,8,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Carlos Carmona','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','05/07/1987','Delantero centro','Interior izquierdo','',0,0,9,'','00/01/1900','Baleares','Baleares','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Cristian Herrera','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','29/03/1994','Delantero centro','Mediapunta izquierdo','',0,0,10,'','00/01/1900','Girona','Cataluña','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Pol Roigé','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','28/01/1994','Interior derecho','Volante izquierdo','',0,0,11,'','00/01/1900','Barcelona','Cataluña','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('J. Nuñez','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','29/01/1993','Interior derecho','Delantero centro','',0,0,12,'','00/01/1900','Panamá','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Carlos Carrasco','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','14/02/1993','Volante izquierdo','Mediapunta','',0,0,14,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Álvaro Pérez','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','07/03/1996','Defensa central izquierdo','','',0,0,15,'','00/01/1900','Valencia','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Victor','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','28/07/2002','Defensa central izquierdo','Defensa central derecho','',0,0,16,'','00/01/1900','Madrid','Madrid','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Juanma Ortiz','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','01/03/1982','Lateral derecho','','',0,0,17,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Borja Viguera','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','26/03/1987','Delantero centro','','',0,0,18,'','00/01/1900','La Rioja','La Rioja','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('E. Cabrera','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','20/11/1999','Mediapunta','Delantero centro','',0,0,19,'','00/01/1900','Argentina','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('J. Tellería','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','10/04/2003','Interior izquierdo','Interior derecho','',0,0,20,'','00/01/1900','Costa Rica','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Benja','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','23/08/1987','Delantero centro','','',0,0,21,'','00/01/1900','Barcelona','Cataluña','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('I. Kecojević','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','10/04/1988','Defensa central derecho','Defensa central izquierdo','',0,0,22,'','00/01/1900','Montenegro','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Javier Heredia','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','27/09/1999','Delantero centro','','',0,0,23,'','00/01/1900','Desconocida','Desconocida','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Juan Pablo Salomen','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','-','Portero','','',0,0,25,'','00/01/1900','Desconocida','Desconocida','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Fabricio Alemán','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','26/07/2003','Mediapunta izquierdo','Mediapunta derecho','',0,0,31,'','00/01/1900','Costa Rica','NA','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('Victor Poveda','ESPAÑA','Español','2ª División RFEF Grupo 5','Intercity SJ D Alacant','02/02/2000','Lateral izquierdo','','',0,0,33,'','00/01/1900','Alicante','Comunidad Valenciana','','unknown','')");
        await db.execute("INSERT into JUGADOR (JUGADOR, PAIS , NACIONALIDAD ,CATEGORIA,  EQUIPO, FECHANACIMIENTO,POSICION , POSICION_ALTERNATIVA, IMAGEN, PESO, ALTURA, DORSAL, VALOR ,FECHACONTRATO, LUGAR_NACIMIENTO, CCAA ,CONTRATO, LATERAL,VEREDICTO) VALUES ('S. Husic','ESPAÑA','Extranjero','2ª División RFEF Grupo 5','Intercity SJ D Alacant','06/08/2002','Defensa central izquierdo','','',0,0,*,'','00/01/1900','Bosnia y Herzegovina','NA','','unknown','')");   }




      );


  }

  /*imagenesEquipo(String pais, String categoria) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM EQUIPO WHERE PAIS = '$pais' and CATEGORIA='$categoria' ORDER BY EQUIPO");
    List<Equipo> list =
    res.isNotEmpty ? res.map((c) => Equipo.fromMap(c)).toList() : [];
    //print(list[0].equipo);
    //print(list[0].categoria);
    //print(list[0].pais);
    //print(list[0].imagen);
    updateEquipo(list[0]);
    for (var i=0;i<list.length;i++)
      updateEquipo(list[i]);
    return list;
  }
  updateEquipo(Equipo equipo) async {
    ponerEscudo(equipo);
    //print(equipo.equipo);
    //print(equipo.categoria);
    //print(equipo.pais);
    //print("UPDATE  EQUIPO SET IMAGEN=${equipo.imagen} WHERE EQUIPO ='${equipo.equipo}' and PAIS = '${equipo.pais}' and CATEGORIA='${equipo.categoria}' ");
    var dbClient = await db;
    await dbClient.rawUpdate("UPDATE  EQUIPO SET IMAGEN=? WHERE EQUIPO =? "
        "and PAIS = ? "
        "and CATEGORIA=?", [equipo.imagen, equipo.equipo, equipo.pais, equipo.categoria]);
    // int count = await dbClient.rawUpdate(
    //   'UPDATE EQUIPO SET IMAGEN = ?, value = ? WHERE name = ?',
    // ['updated name', '9876', 'some name']);
    ////print('updated: $count');
  }


  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  void ponerEscudo(Equipo equipo){

    try {
      //getFileList(equipo);
      File file;
      Uint8List bytes = null;
      file = new File("/Users/borch/proyectos/IAScout/assets/clubes/${equipo.equipo}.png");
      bytes = Equipo.decode(file);
      equipo.imagen = bytes;
    }
    catch(e){
      //print(e.toString());
    }
  }*/
}