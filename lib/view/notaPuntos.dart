import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/jugadorDao.dart';
import 'package:iadvancedscout/locale/app_localization.dart';
import 'package:iadvancedscout/model/jugador.dart';

import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../conf/config.dart';

class NotaPuntos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotaPuntos();
  }

  NotaPuntos(this._texto, this._posicion, this._jugador, this._vertical);

  final String _texto;
  final int _posicion;
  final Jugador _jugador;
  final bool _vertical;
}

class _NotaPuntos extends State<NotaPuntos> {
  int puntoAux = 1;

  Widget build(BuildContext context) {

   // puntoAux=dameLosPuntos();
    // TODO: implement build
    return widget._vertical == true
        ? Container(
            padding: EdgeInsets.all(0),
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(1.0),
                child: Texto(
                    Colors.blue[900], widget._texto, 10, Colors.white, false),
              ),
              CupertinoSegmentedControl(
                  borderColor: Colors.black,
                  pressedColor: Colors.blue,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.white,
                  groupValue: dameLosPuntos(),
                  children: <int, Widget>{
                    1: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "1",
                          style: TextStyle(fontSize: 10),
                        )),
                    2: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "2",
                          style: TextStyle(fontSize: 12),
                        )),
                    3: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "3",
                          style: TextStyle(fontSize: 12),
                        )),
                    4: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "4",
                          style: TextStyle(fontSize: 12),
                        )),
                    5: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "5",
                          style: TextStyle(fontSize: 12),
                        )),
                 /*   6: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "6",
                          style: TextStyle(fontSize: 12),
                        )),
                    7: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "7",
                          style: TextStyle(fontSize: 12),
                        )),
                    8: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "8",
                          style: TextStyle(fontSize: 12),
                        )),
                    9: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "9",
                          style: TextStyle(fontSize: 12),
                        )),
                    10: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "10",
                          style: TextStyle(fontSize: 12),
                        )),*/
                  },
                  onValueChanged: (value) {
                    setState(() {
                      ponerLosPuntos(value);
                     
                      
                    });
                    // TODO: - fix it
                    ;
                  }),
            ]))
        : Container(
            padding: EdgeInsets.all(0),
            child: Row(children: [
              Container(
                padding: EdgeInsets.all(1.0),
                child: Texto(
                    Colors.blue[900], widget._texto, 10, Colors.white, false),
              ),
              CupertinoSegmentedControl(
                  borderColor: Colors.black,
                  pressedColor: Colors.blue,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.white,
                  groupValue: dameLosPuntos(),
                  children: <int, Widget>{
                    1: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "1",
                          style: TextStyle(fontSize: 10),
                        )),
                    2: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "2",
                          style: TextStyle(fontSize: 12),
                        )),
                    3: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "3",
                          style: TextStyle(fontSize: 12),
                        )),
                    4: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "4",
                          style: TextStyle(fontSize: 12),
                        )),
                    5: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "5",
                          style: TextStyle(fontSize: 12),
                        )),
                /*    6: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "6",
                          style: TextStyle(fontSize: 12),
                        )),
                    7: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "7",
                          style: TextStyle(fontSize: 12),
                        )),
                    8: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "8",
                          style: TextStyle(fontSize: 12),
                        )),
                    9: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "9",
                          style: TextStyle(fontSize: 12),
                        )),
                    10: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "10",
                          style: TextStyle(fontSize: 12),
                        )),*/
                  },
                  onValueChanged: (value) {
                    setState(() {
                      ponerLosPuntos(value);
                     
                      
                    });
                    // TODO: - fix it
                    ;
                  }),
            ]));
  }

  int dameLosPuntos() {
    int puntos=0;
   /* //TACTICA
     if (widget._posicion == 2)
      puntos= widget._jugador.tac_acosopresionsobreoponente;
    if (widget._posicion == 3)
      puntos= widget._jugador.tac_resolucionanteparedesrivales;
    if (widget._posicion == 4) puntos= widget._jugador.tac_vigilancias;
    if (widget._posicion == 5) puntos= widget._jugador.tac_coberturas;
    if (widget._posicion == 6) puntos= widget._jugador.tac_repliegues;
    if (widget._posicion == 7)
      puntos= widget._jugador.tac_basculacionyrelacionintralinea;
    if (widget._posicion == 8) puntos= widget._jugador.tac_anticipaciones;
    if (widget._posicion == 9) puntos= widget._jugador.tac_proyeccionofensiva;
    if (widget._posicion == 10) puntos= widget._jugador.tac_contundencia;
    if (widget._posicion == 11) puntos= widget._jugador.tac_accionen2dasjugadas;
    if (widget._posicion == 12) puntos= widget._jugador.tac_equilibrioatdef;
    if (widget._posicion == 13)
      puntos= widget._jugador.tac_interrumpircortarjuegorival;
    if (widget._posicion == 14) puntos= widget._jugador.tac_llegadaaarearival;
    if (widget._posicion == 15) puntos= widget._jugador.tac_cambiosderitmojuego;
    if (widget._posicion == 16)
      puntos= widget._jugador.tac_responsabilidadllevarjuegoofensivo;
    if (widget._posicion == 17) puntos= widget._jugador.tac_creativo;
    if (widget._posicion == 18)
      puntos= widget._jugador.tac_llegaalineadefondodesborde;
    if (widget._posicion == 19)
      puntos= widget._jugador.tac_movimientosverticalesprofundidad;
    if (widget._posicion == 20)
      puntos= widget._jugador.tac_movimientosdiagonalesfinalizacionasociacion;
    if (widget._posicion == 49)
      puntos= widget._jugador.tac_juegoentrelineas;
    if (widget._posicion == 50)
      puntos= widget._jugador.tac_caerabanda;
    if (widget._posicion == 52)
      puntos= widget._jugador.tac_astucia;
    if (widget._posicion == 53)
      puntos=  widget._jugador.tac_generaespaciosmovimientosdiagonales;
    if (widget._posicion == 54)
      puntos=  widget._jugador.tac_atacaelespaciodesmarquederuptura;
    if (widget._posicion == 57) puntos=widget._jugador.tac_atraearivalesamenazamarcas;

    //TECNICA
    if (widget._posicion == 21) puntos= widget._jugador.tec_disputas;
    if (widget._posicion == 22) puntos= widget._jugador.tec_pasesfiltrados;
    if (widget._posicion == 23)
      puntos= widget._jugador.tec_desplazamientosmedios;
    if (widget._posicion == 24) puntos= widget._jugador.tec_paseslargos;
    if (widget._posicion == 25) puntos= widget._jugador.tec_salidaconducciones;
    if (widget._posicion == 26) puntos= widget._jugador.tec_frontales;
    if (widget._posicion == 27) puntos= widget._jugador.tec_laterales;
    if (widget._posicion == 28) puntos= widget._jugador.tec_duelos1vs1;
    if (widget._posicion == 29) puntos= widget._jugador.tec_aereo_abp_of;
    if (widget._posicion == 30) puntos= widget._jugador.tec_aereo_abp_df;
    if (widget._posicion == 34) puntos= widget._jugador.tec_aereo;
    if (widget._posicion == 35) puntos= widget._jugador.tec_pasescortos;
    if (widget._posicion == 36) puntos= widget._jugador.tec_juegoa12toques;
    if (widget._posicion == 37) puntos= widget._jugador.tec_capacidadjuegocombinado;
    if (widget._posicion == 38) puntos= widget._jugador.tec_generales;
    if (widget._posicion == 39) puntos= widget._jugador.tec_orientados;
    if (widget._posicion == 40) puntos= widget._jugador.tec_golpeosapuerta;
    if (widget._posicion == 41) puntos= widget._jugador.tec_cierredelineasdepase;
    if (widget._posicion == 42) puntos= widget._jugador.tec_perdidasdebalones;
    if (widget._posicion == 43) puntos= widget._jugador.tec_provocasituacionesde1vs1;
    if (widget._posicion == 44)  puntos=widget._jugador.tec_jugarapiernacambiada;
    if (widget._posicion == 45) puntos= widget._jugador.tec_habilidosodesequilibrante;
    if (widget._posicion == 46) puntos= widget._jugador.tec_usopiernanodominante;
    if (widget._posicion == 47) puntos= widget._jugador.tec_centros;
    if (widget._posicion == 48) puntos= widget._jugador.tec_temporizacionesofensivas;
   if (widget._posicion == 51) puntos= widget._jugador.tac_movimientosdiagonalesfinalizacionasociacion;
    if (widget._posicion == 55)
      puntos=  widget._jugador.tec_ejecutarparedes;
    if (widget._posicion == 56) puntos=widget._jugador.tec_definicion;
    if (widget._posicion == 57)  puntos=widget._jugador.tac_atraearivalesamenazamarcas;


    if(puntos==0) puntos=1;

*/
    return puntos;
  }


  ponerLosPuntos(int value) {
    value==0?1:value;
     //TACTICA
    /*if (widget._posicion == 2)
       widget._jugador.tac_acosopresionsobreoponente=value;
    if (widget._posicion == 3)
       widget._jugador.tac_resolucionanteparedesrivales=value;
    if (widget._posicion == 4)  widget._jugador.tac_vigilancias=value;
    if (widget._posicion == 5)  widget._jugador.tac_coberturas=value;
    if (widget._posicion == 6)  widget._jugador.tac_repliegues=value;
    if (widget._posicion == 7)
       widget._jugador.tac_basculacionyrelacionintralinea=value;
    if (widget._posicion == 8)  widget._jugador.tac_anticipaciones=value;
    if (widget._posicion == 9)  widget._jugador.tac_proyeccionofensiva=value;
    if (widget._posicion == 10)  widget._jugador.tac_contundencia=value;
    if (widget._posicion == 11)  widget._jugador.tac_accionen2dasjugadas=value;
    if (widget._posicion == 12)  widget._jugador.tac_equilibrioatdef=value;
    if (widget._posicion == 13)
       widget._jugador.tac_interrumpircortarjuegorival=value;
    if (widget._posicion == 14)  widget._jugador.tac_llegadaaarearival=value;
    if (widget._posicion == 15)  widget._jugador.tac_cambiosderitmojuego=value;
    if (widget._posicion == 16)
       widget._jugador.tac_responsabilidadllevarjuegoofensivo=value;
    if (widget._posicion == 17)  widget._jugador.tac_creativo=value;
    if (widget._posicion == 18)
       widget._jugador.tac_llegaalineadefondodesborde=value;
    if (widget._posicion == 19)
       widget._jugador.tac_movimientosverticalesprofundidad=value;
    if (widget._posicion == 20)
       widget._jugador.tac_movimientosdiagonalesfinalizacionasociacion=value;
    if (widget._posicion == 49)
      widget._jugador.tac_juegoentrelineas=value;
    if (widget._posicion == 50)
      widget._jugador.tac_caerabanda=value;
    if (widget._posicion == 52)
      widget._jugador.tac_astucia=value;
    if (widget._posicion == 53)
      widget._jugador.tac_generaespaciosmovimientosdiagonales=value;
    if (widget._posicion == 54)
      widget._jugador.tac_atacaelespaciodesmarquederuptura=value;
    if (widget._posicion == 57) widget._jugador.tac_atraearivalesamenazamarcas=value;


    //TECNICA
    if (widget._posicion == 21)  widget._jugador.tec_disputas=value;
    if (widget._posicion == 22)  widget._jugador.tec_pasesfiltrados=value;
    if (widget._posicion == 23)
       widget._jugador.tec_desplazamientosmedios=value;
    if (widget._posicion == 24)  widget._jugador.tec_paseslargos=value;
    if (widget._posicion == 25)  widget._jugador.tec_salidaconducciones=value;
    if (widget._posicion == 26)  widget._jugador.tec_frontales=value;
    if (widget._posicion == 27)  widget._jugador.tec_laterales=value;
    if (widget._posicion == 28)  widget._jugador.tec_duelos1vs1=value;
    if (widget._posicion == 29)  widget._jugador.tec_aereo_abp_of=value;
    if (widget._posicion == 30)  widget._jugador.tec_aereo_abp_df=value;
    if (widget._posicion == 34)  widget._jugador.tec_aereo=value;
    if (widget._posicion == 35)  widget._jugador.tec_pasescortos=value;
    if (widget._posicion == 36)  widget._jugador.tec_juegoa12toques=value;
    if (widget._posicion == 37)  widget._jugador.tec_capacidadjuegocombinado=value;
    if (widget._posicion == 38)  widget._jugador.tec_generales=value;
    if (widget._posicion == 39)  widget._jugador.tec_orientados=value;
    if (widget._posicion == 40)  widget._jugador.tec_golpeosapuerta=value;
    if (widget._posicion == 41)  widget._jugador.tec_cierredelineasdepase=value;
    if (widget._posicion == 42)  widget._jugador.tec_perdidasdebalones=value;
    if (widget._posicion == 43)  widget._jugador.tec_provocasituacionesde1vs1=value;
    if (widget._posicion == 44)  widget._jugador.tec_jugarapiernacambiada=value;
    if (widget._posicion == 45)  widget._jugador.tec_habilidosodesequilibrante=value;
   if (widget._posicion == 46)  widget._jugador.tec_usopiernanodominante=value;
    if (widget._posicion == 47)  widget._jugador.tec_centros=value;
    if (widget._posicion == 48)  widget._jugador.tec_temporizacionesofensivas=value;

    if (widget._posicion == 51)  widget._jugador.tac_movimientosdiagonalesfinalizacionasociacion=value;
    if (widget._posicion == 55) widget._jugador.tec_ejecutarparedes=value;
    if (widget._posicion == 56) widget._jugador.tec_definicion=value;


*/
  }

}
