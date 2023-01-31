import 'package:iafootfeel/modelo/player.dart';

class Partido {
  String id;
  String equipoCASA;
  String equipoFUERA;
  bool jugado = false;
  String _ganadoEmpatePierde = "";
  String resultado;
  String observador;
  String accion;
  int jornada;
  String fecha;
  String temporada;
  String pais;
  String categoria;

  String golesCASA = "";
  String golesFUERA = "";
  AccionPutuacionJugadorPartido putuacionJugadorPartido;

  int titularesCasa=0;
  int suplentesCasa=0;
  int sinDatosCasa=0;
  int NACasa=0;
  int EXCasa=0;
  int conteoDescCasa=0;

  int titularesFuera=0;
  int suplentesFuera=0;
  int sinDatosFuera=0;
  int conteoDescFuera=0;

  int NAFuera=0;
  int EXFuera=0;

  var imagen1;
  var imagen2;

  Partido({
    this.id,
    this.equipoCASA,
    this.equipoFUERA,
    this.jugado,
    this.accion,
    this.observador,
    this.resultado,
    this.golesCASA,
    this.golesFUERA,
  });



  Partido.fromMap(Map snapshot, String id)
      : id = id ?? '',
        equipoCASA = snapshot['equipoCASA'] ?? '',
        equipoFUERA = snapshot['equipoFUERA'] ?? '',
        golesCASA = snapshot['golesCASA'] ?? '',
        golesFUERA= snapshot['golesFUERA'] ?? '',
        accion=snapshot['accion'] ?? '',
        fecha=snapshot['fecha'] ?? '',
        jornada=snapshot['jornada'] ?? 0,
        observador = snapshot['observador'] ?? '',
        jugado = snapshot['jugado'] ?? false,
        resultado = snapshot['resultado'] ?? '';

  toJson() {
    return {
      "equipoCASA": equipoCASA,
      "equipoFUERA": equipoFUERA,
      "golesFUERA": golesFUERA,
      "golesCASA": golesCASA,
      "observador": observador,
      "accion": accion,
      "jornada": jornada,
      "fecha": fecha,
      "jugado": jugado,
      "resultado": resultado,
    };
  }

  Map<String, dynamic> toMapJornada() {
    var map = new Map<String, dynamic>();
    map["jornada"] = jornada;
    map["fecha"] = fecha;
    return map;
  }

  Map<String, dynamic> toMapPartido() {
    var map = new Map<String, dynamic>();
    map["jornada"] = jornada;
    map["fecha"] = fecha;
    map["id"] = id;
    map["equipoCASA"] =equipoCASA;
    map["equipoFUERA"] =equipoFUERA;
    map["jugado"] =jugado;
    map["accion"] =accion;
    map["observador"] =observador;
    map["golesCASA"] =golesCASA;
    map["golesFUERA"] =golesFUERA;
    return map;
  }

  Partido.fromMapBBDD(dynamic obj) {

    this.temporada=obj['TEMPORADA'];
    this.pais=obj['PAIS'];
    this.categoria=obj['CATEGORIA'];
    this.equipoCASA=obj['EQUIPO_LOCAL'];
    this.equipoFUERA=obj['EQUIPO_VISITANTE'];
    this.fecha=obj['FECHA'];
    this.jornada=obj['JORNADA'];
    this.golesCASA=obj['GOLES_LOCAL'];
    this.golesFUERA=obj['GOLES_VISITANTE'];
    this.observador=obj['SCOUTER'];
    this.accion='';
  }
  /* String get resultado {
    if (jugado){
      return lugar=="CASA"?"${gol} - ${golContrario}":"${golContrario} - ${gol}";
    }else{
      return "-";
    }
}
*/


}
