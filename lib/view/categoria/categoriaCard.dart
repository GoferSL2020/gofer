import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/modelo/cantera.dart';
import 'package:iafootfeel/modelo/categoria.dart';
import 'package:iafootfeel/modelo/equipo.dart';
import 'package:iafootfeel/modelo/equipoJugador.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/view/jugadores/jugadoresView.dart';

import 'categoriasView.dart';

class CategoriaCard extends StatelessWidget {
  final Pais paisDetails;
  final Categoria categoria;
  final EquipoJugador equipo;
  CategoriaCard( this.paisDetails,this.categoria,this.equipo);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FiltroJugadores filtro=new FiltroJugadores("", false, categoria.categoria, "${paisDetails.pais}-${categoria.categoria}",equipo.equipo,paisDetails.pais);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => JugadoresView(filtro,paisDetails)));
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          child: Container(color: Config.colorCard,
            height: 60,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: <Widget>[
               /* Hero(
                  tag: paisDetails.id,
                  child: Image.asset(
                    'assets/img/2b.png',
                    height: MediaQuery
                        .of(context)
                        .size
                        .height *
                        0.35,
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Image.network("https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/clubes%2F${paisDetails.pais.toString().replaceAll("Ñ", "N")}.png?alt=media",
                          height:20),
                      Container(width: 20,),
                      Text(
                        categoria.categoria,
                        style: TextStyle(
                          color: Colors.black,
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

//https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/categorias%2F2ª%20División%20A.png
//https://firebasestorage.googleapis.com/v0/b/iafootfeel.appspot.com/o/categorias%2F2%C2%AA%20Divisio%CC%81n%20A.png