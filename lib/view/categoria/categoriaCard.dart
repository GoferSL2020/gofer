import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/categoria.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/equipos/equiposOpcionesViewAux.dart';

class CategoriaCard extends StatelessWidget {
  final Pais paisDetails;
  final Temporada temporada;
  final Categoria categoria;

  CategoriaCard({@required this.paisDetails,@required this.temporada,@required this.categoria});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (_) => EquiposOpcionesViewAux(pais: paisDetails, temporada: temporada,categoria:categoria)));
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
                      new Image.network(
                          Config.escudoCategoria(categoria.categoria),
                          height:30),
                      Container(width: 20,),
                      Text(
                        categoria.categoria,
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

//https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F2ª%20División%20A.png
//https://firebasestorage.googleapis.com/v0/b/iadvancedscout.appspot.com/o/categorias%2F2%C2%AA%20Divisio%CC%81n%20A.png