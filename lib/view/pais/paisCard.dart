import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/view/categoria/categoriasView.dart';
import 'package:iafootfeel/view/equipos/equiposEditJugadorView.dart';
import 'package:iafootfeel/view/equipos/equiposJugadorView.dart';

class PaisCard extends StatelessWidget {
  final Pais paisDetails;
  final Temporada temporada;
  final bool menu;
  PaisCard({@required this.paisDetails,@required this.temporada,@required this.menu});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        EquipoJugador equipo=new EquipoJugador();
        equipo.equipo="";
        if(menu==true)
          Navigator.push(context, MaterialPageRoute(builder: (_) => EquipoEditJugadorView (paisDetails,menu)));
        else{
          //PAIS LALIGA
          if (paisDetails.cantera==true){
            Navigator.push(context, MaterialPageRoute(builder: (_) => EquipoJugadorView (paisDetails,menu)));
          }else{
            //PAIS DE FUERA
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                CategoriasView(pais:paisDetails,equipo:equipo)));
          }
        }

      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 1,
          child: Container(color: Config.colorCard,
            height: 60,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                       new Image.network(
                           Config.escudoClubesFF( paisDetails.pais),
                          height:35),
                      Container(width: 40,),
                      Text(
                        paisDetails.pais,
                        style: TextStyle(
                          color: Config.colorCardLetra,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            fontStyle: FontStyle.italic),
                      ),



                    ],

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

