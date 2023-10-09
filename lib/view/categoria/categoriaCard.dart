import 'package:flutter/material.dart';
import 'package:gls/conf/config.dart';
import 'package:gls/modelo/categoria.dart';

import 'package:gls/modelo/mercancia.dart';
import 'package:gls/view/mercancia/mercanciaEdit.dart';
import 'package:gls/view/mercancia/mercanciasView.dart';


class CategoriaCard extends StatelessWidget {
  final bool subir;
  final Categoria categoria;
  final String sitio;

  CategoriaCard(this.subir,this.categoria,this.sitio);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Mercancia mercancia=new Mercancia();
        //   Navigator.push(context, MaterialPageRoute(builder: (_) => EquiposView(temporada: temporadaDetails)));
        if (subir==true)
          Navigator.push(context, MaterialPageRoute(builder: (_) => MercanciaEdit(mercancia, categoria)));
        else
          Navigator.push(context, MaterialPageRoute(builder: (_) => MercanciaView(categoria, sitio)));
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 10,
          color: Config.letras,
          child: Container(color: Config.colorCard,
            height: 50,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        categoria.categoria,
                        style: TextStyle(
                          color: Config.fondo,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
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

//https://firebasestorage.googleapis.com/v0/b/gls.appspot.com/o/categorias%2F2ª%20División%20A.png
//https://firebasestorage.googleapis.com/v0/b/gls.appspot.com/o/categorias%2F2%C2%AA%20Divisio%CC%81n%20A.png