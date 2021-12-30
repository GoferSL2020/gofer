import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/pais/paisView.dart';

class TemporadaCard extends StatelessWidget {
  final Temporada temporadaDetails;

  TemporadaCard({@required this.temporadaDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (_) => PaisView(temporada: temporadaDetails)));
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
                  tag: temporadaDetails.id,
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
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        temporadaDetails.temporada,
                        style: TextStyle(
                          color: Config.colorCardLetra,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
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

