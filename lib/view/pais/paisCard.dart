import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/categoria/categoriasView.dart';

class PaisCard extends StatelessWidget {
  final Pais paisDetails;
  final Temporada temporada;

  PaisCard({@required this.paisDetails,@required this.temporada});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriasView (pais: paisDetails, temporada: temporada,)));
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          child: Container(color: Config.colorCard,
            height: 80,
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
                      new Image.network("https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/paises%2F${paisDetails.pais.toString().replaceAll("Ñ", "N")}.png?alt=media",
                          height:40),
                      Container(width: 50,),
                      Text(
                        paisDetails.pais,
                        style: TextStyle(
                          color: Config.colorCardLetra,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
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

