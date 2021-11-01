import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/custom_icon_icons.dart';
import 'package:iadvancedscout/model/jugador.dart';
import 'package:iadvancedscout/view/caracteristicas/tabNivel.dart';
import 'package:iadvancedscout/view/notaPuntos.dart';
import 'package:iadvancedscout/wigdet/texto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Nivel extends StatefulWidget {
   Nivel( this._jugador);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Nivel();
  }

  final Jugador _jugador;

}

class _Nivel extends State<Nivel> {
  List<String> caract;
  String caractAux="";
  String veredicto="";

  int letrasAux=Config.letrasPalabra;


  List<String> _veredicto = <String>
  [ "",
    'Firmar',
    'Muy interesante',
    'Continuar seguimiento',
    'Normal',
    'Descartar'
  ];


  @override
  void initState() {
    veredicto=widget._jugador.veredicto.trim();
    if(widget._jugador.posicion.toUpperCase().contains("PORTERO"))
      caract=Jugador.tipoPortero;
    else  if(widget._jugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Jugador.tipoLateral;
    else  if(widget._jugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Jugador.tipoCarrilero;
    else if(widget._jugador.posicion.toUpperCase().contains("DEFENSA"))
      caract=Jugador.tipoCentral;
    else if(widget._jugador.posicion.toUpperCase().contains("CENTRAL"))
      caract=Jugador.tipoCentral;
    else  if(widget._jugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Jugador.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Jugador.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Jugador.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Jugador.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("PIVOTE"))
      caract=Jugador.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Jugador.tipoDelantero;
    else  if(widget._jugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Jugador.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("EXTREMO"))
      caract=Jugador.tipoExtremo;
    else
      caract=Jugador.tipoPortero;

    for (String doc in caract)
      caractAux+=doc;

    }

Widget build(BuildContext context) {
  print("_________");
    print(caractAux);
    // TODO: implement build
    return Scaffold(
        body:new SingleChildScrollView(

     child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        verticalDirection: VerticalDirection.down,

        children:[
          // NotaPuntos("Resolución ante paredes rivales", 2),

          Container(color:Colors.black,
              padding: EdgeInsets.all(1.0),
              child: Texto(Colors.white,"Nivel".toUpperCase()
                  ,10, Colors.black, false)),


          Container(padding: EdgeInsets.only(left:15.0, right: 15),
            child:
            FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Selecciona el veredicto",
                    ),
                    isEmpty: veredicto == '',
                    child: new DropdownButtonFormField(
                      items: _veredicto.map((String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      value: veredicto,
                      validator: (value) =>
                      value == null
                          ? 'Selecciona el veredicto' : null,
                      isDense: true,
                      onChanged: (value) {
                        setState(() {
                          //newContact.favoriteColor = newValue;
                          widget._jugador.veredicto = value;
                          state.didChange(value);
                        });
                      },
                    ),
                  );
                }),),
           Container(padding: EdgeInsets.only(left:15.0, right: 15,top: 15),
            child: Text("NIVEL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,

                )),
          ),
          Container(
            height: 210,
            padding: EdgeInsets.only(left:0, right: 0),
            child:
            TabNivel(widget._jugador),
          ),
          Container(padding: EdgeInsets.only(left:15.0, right: 15,top: 15),
            child: Text("TIPO",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,

                )),
          ),
          Container(padding: EdgeInsets.only(left:15.0, right: 15),
                child:
          Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                caractAux.contains("TIPO A")==true?SizedBox(
                width: 50, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "A"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "A"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "A";
                    });

                  },
                )):Container(),

            Container(
              width: 2,
            ),
                caractAux.contains("TIPO B")==true?SizedBox(
                width: 50, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "B"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "B",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "B"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "B";
                    });

                  },
                )):Container(),
            Container(
              width: 2,
            ),
                caractAux.contains("TIPO C")==true?SizedBox(
                width: 50, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "C"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "C",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "C"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "C";
                    });

                  },
                )):Container(),
            Container(
              width: 2,
            ),
                caractAux.contains("TIPO D")==true?SizedBox(
                width: 50, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "D"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "D",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "D"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "D";
                    });

                  },
                )):Container(),

            Container(
              width: 2,
            ),
            caractAux.contains("TIPO E")==true?SizedBox(
                width: 50, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "E"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "E",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "E"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "E";
                    });
                  },
                )):Container(),
                Container(
                  width: 2,
                ),

                caractAux.contains("TIPO F")==true?SizedBox(
                    width: 50, // specific value
                    child: RaisedButton(
                      color: widget._jugador.tipo == "F"
                          ? Colors.green
                          : Colors.grey,
                      child: Text(
                        "F",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      textColor: Colors.black,
                      splashColor: widget._jugador.tipo == "F"
                          ? Colors.green
                          : Colors.grey,
                      onPressed: () {
                        setState(() {
                          widget._jugador.tipo = "F";
                        });
                      },
                    )):Container(),
          ]),
            ),

          Container(padding: EdgeInsets.only(left:15.0, right: 15),
              alignment: Alignment.center,
              child: new Table(

              defaultVerticalAlignment:
              TableCellVerticalAlignment.middle,
              children:
              ponerFila2col(),
              ),
            ),
        ])
      ),
    );
  }
  
  List<TableRow> ponerFila2col() {
    List<TableRow> rows =new List<TableRow>();
    for (String doc in caract) {

      rows.add(
          TableRow(children: [
            new Container(height: 10,)
            ])
      );
      rows.add(
          TableRow(children: [
          new Text(doc.split(":")[0],
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          )),
        ])
      );
      rows.add(
          TableRow(children: [
            new Text(doc.split(":")[1],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                )),
          ])
      );
    }
    return rows;
  }
  @override
  void setState(fn) {
    //print("setStateFN");
    if (mounted) {
      super.setState(fn);
    }
  }

}



/*
Nivel técnico
Salida de balón
Pase largo/medio
Cambios de orientación
Bate líneas con pase interior
Conducción para dividir
Primer pase tras recuperación
Interviene en ABP´s
Finalización
 */

