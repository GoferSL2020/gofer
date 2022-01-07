import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/view/jugadores/scouting/tabNivel.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


class Nivel extends StatefulWidget {
   Nivel( this._jugador);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Nivel();
  }

  final Player _jugador;

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
    print(widget._jugador.posicion.toUpperCase());
    if(widget._jugador.posicion.toUpperCase().contains("PORTERO"))
      caract=Player.tipoPortero;
    else  if(widget._jugador.posicion.toUpperCase().contains("LATERAL"))
      caract=Player.tipoLateral;
    else  if(widget._jugador.posicion.toUpperCase().contains("CARRILERO"))
      caract=Player.tipoCarrilero;
    else if(widget._jugador.posicion.toUpperCase().contains("DEFENSA"))
      caract=Player.tipoCentral;
    else if(widget._jugador.posicion.toUpperCase().contains("CENTRAL"))
      caract=Player.tipoCentral;
    else  if(widget._jugador.posicion.toUpperCase().contains("MEDIO"))
      caract=Player.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("INTERIOR"))
      caract=Player.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("VOLANTE"))
      caract=Player.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("CENTROCAMPISTA"))
      caract=Player.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("PIVOTE"))
      caract=Player.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("DELANTERO"))
      caract=Player.tipoDelantero;
    else  if(widget._jugador.posicion.toUpperCase().contains("PUNTA"))
      caract=Player.tipoMedio;
    else  if(widget._jugador.posicion.toUpperCase().contains("EXTREMO"))
      caract=Player.tipoExtremo;
    else
      caract=Player.tipoPortero;

    for (String doc in caract)
      caractAux+=doc;
    print(caractAux);

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
          caractAux.contains("P 1")?
          buildContainerPortero():
          caractAux.contains("L 1")?
          buildContainerLateral():
          caractAux.contains("CB 1")?
          buildContainerCentral():
          caractAux.contains("FB 1")?
          buildContainerCarrilero():
          caractAux.contains("MF 1")?
          buildContainerMedio():
          caractAux.contains("CF 1")?
          buildContainerDelantero():
          caractAux.contains("WF 1")?
          buildContainerExtremo():null,

          Container(padding: EdgeInsets.only(left:15.0, right: 15),
              alignment: Alignment.center,
              child: new Table(

              defaultVerticalAlignment:
              TableCellVerticalAlignment.middle,
              children:
              ponerFila2col(),
              ),
            ),
          Container(
            height: 40,
          ),
        ])
      ),
    );
  }

Container buildContainerPortero() {
  return Container(padding: EdgeInsets.only(left:10.0, right: 10),
              child:
        Row(  
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              caractAux.contains("P 1")==true?SizedBox(
              width: 56, // specific value
              child: RaisedButton(
                color: widget._jugador.tipo == "P 1"
                    ? Colors.green
                    : Colors.grey,
                child: Text(
                  "P 1",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                textColor: Colors.black,
                splashColor: widget._jugador.tipo == "P 1"
                    ? Colors.green
                    : Colors.grey,
                onPressed: () {
                  setState(() {
                    widget._jugador.tipo = "P 1";
                  });

                },
              )):Container(),

          Container(
            width: 1,
          ),
              caractAux.contains("P 2")==true?SizedBox(
              width: 56, // specific value
              child: RaisedButton(
                color: widget._jugador.tipo == "P 2"
                    ? Colors.green
                    : Colors.grey,
                child: Text(
                  "P 2",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                textColor: Colors.black,
                splashColor: widget._jugador.tipo == "P 2"
                    ? Colors.green
                    : Colors.grey,
                onPressed: () {
                  setState(() {
                    widget._jugador.tipo = "P 2";
                  });

                },
              )):Container(),
          Container(
            width: 1,
          ),
              caractAux.contains("P 3")==true?SizedBox(
              width: 56, // specific value
              child: RaisedButton(
                color: widget._jugador.tipo == "P 3"
                    ? Colors.green
                    : Colors.grey,
                child: Text(
                  "P 3",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                textColor: Colors.black,
                splashColor: widget._jugador.tipo == "P 3"
                    ? Colors.green
                    : Colors.grey,
                onPressed: () {
                  setState(() {
                    widget._jugador.tipo = "P 3";
                  });

                },
              )):Container(),
          Container(
            width: 1,
          ),
              caractAux.contains("P 4")==true?SizedBox(
              width: 56, // specific value
              child: RaisedButton(
                color: widget._jugador.tipo == "P 4"
                    ? Colors.green
                    : Colors.grey,
                child: Text(
                  "P 4",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                textColor: Colors.black,
                splashColor: widget._jugador.tipo == "P 4"
                    ? Colors.green
                    : Colors.grey,
                onPressed: () {
                  setState(() {
                    widget._jugador.tipo = "P 4";
                  });

                },
              )):Container(),

          Container(
            width: 1,
          ),
          caractAux.contains("P 5")==true?SizedBox(
              width: 56, // specific value
              child: RaisedButton(
                color: widget._jugador.tipo == "P 5"
                    ? Colors.green
                    : Colors.grey,
                child: Text(
                  "P 5",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                textColor: Colors.black,
                splashColor: widget._jugador.tipo == "P 5"
                    ? Colors.green
                    : Colors.grey,
                onPressed: () {
                  setState(() {
                    widget._jugador.tipo = "P 5";
                  });
                },
              )):Container(),
        ]),
          );
}



  Container buildContainerLateral() {
    return Container(padding: EdgeInsets.only(left:10.0, right: 10),
      child:
      Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            caractAux.contains("L 1")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "L 1"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "L 1",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "L 1"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "L 1";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("L 2")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "L 2"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "L 2",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "L 2"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "L 2";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("L 3")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "L 3"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "L 3",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "L 3"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "L 3";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("L 4")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "L 4"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "L 4",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "L 4"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "L 4";
                    });

                  },
                )):Container(),

          ]),
    );
  }


  Container buildContainerCentral() {
    return Container(padding: EdgeInsets.only(left:10.0, right: 10),
      child:
      Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            caractAux.contains("CB 1")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CB 1"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CB 1",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CB 1"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CB 1";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("CB 2")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CB 2"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CB 2",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CB 2"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CB 2";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("CB 3")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CB 3"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CB 3",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CB 3"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CB 3";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("CB 4")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CB 4"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CB 4",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CB 4"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CB 4";
                    });

                  },
                )):Container(),


          ]),
    );
  }


  Container buildContainerCarrilero() {
    return Container(padding: EdgeInsets.only(left:10.0, right: 10),
      child:
      Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            caractAux.contains("FB 1")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "FB 1"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "FB 1",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "FB 1"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "FB 1";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("FB 2")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "FB 2"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "FB 2",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "FB 2"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "FB 2";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("FB 3")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "FB 3"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "FB 3",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "FB 3"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "FB 3";
                    });

                  },
                )):Container(),
          ]),
    );
  }


  Container buildContainerMedio() {
    return Container(padding: EdgeInsets.only(left:10.0, right: 10),
      child:
      Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            caractAux.contains("MF 1")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "MF 1"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "MF 1",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "MF 1"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "MF 1";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("MF 2")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "MF 2"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "MF 2",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "MF 2"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "MF 2";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("MF 3")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "MF 3"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "MF 3",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "MF 3"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "MF 3";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("MF 4")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "MF 4"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "MF 4",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "MF 4"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "MF 4";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("MF 5")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "MF 5"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "MF 5",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "MF 5"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "MF 5";
                    });
                  },
                )):Container(),
            Container(
              width: 1,
            ),

            caractAux.contains("MF 5")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "MF 6"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "MF 6",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "MF 6"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "MF 6";
                    });
                  },
                )):Container(),
          ]),
    );
  }


  Container buildContainerDelantero() {
    return Container(padding: EdgeInsets.only(left:10.0, right: 10),
      child:
      Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            caractAux.contains("CF 1")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CF 1"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CF 1",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CF 1"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CF 1";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("CF 2")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CF 2"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CF 2",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CF 2"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CF 2";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("CF 3")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CF 3"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CF 3",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CF 3"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CF 3";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("CF 4")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CF 4"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CF 4",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CF 4"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CF 4";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("CF 5")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CF 5"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CF 5",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CF 5"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CF 5";
                    });
                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("CF 6")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "CF 6"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "CF 6",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "CF 6"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "CF 6";
                    });
                  },
                )):Container(),
          ]),
    );
  }


  Container buildContainerExtremo() {
    return Container(padding: EdgeInsets.only(left:10.0, right: 10),
      child:
      Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            caractAux.contains("WF 1")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "WF 1"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "WF 1",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "WF 1"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "WF 1";
                    });

                  },
                )):Container(),

            Container(
              width: 1,
            ),
            caractAux.contains("WF 2")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "WF 2"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "WF 2",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "WF 2"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "WF 2";
                    });

                  },
                )):Container(),
            Container(
              width: 1,
            ),
            caractAux.contains("WF 3")==true?SizedBox(
                width: 56, // specific value
                child: RaisedButton(
                  color: widget._jugador.tipo == "WF 3"
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    "WF 3",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  textColor: Colors.black,
                  splashColor: widget._jugador.tipo == "WF 3"
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget._jugador.tipo = "WF 3";
                    });

                  },
                )):Container(),
          ]),
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
          fontSize: 10,
          )),
        ])
      );
      rows.add(
          TableRow(children: [
            new Text(doc.split(":")[1],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
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

