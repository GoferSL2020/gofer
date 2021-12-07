


import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/modelo/entrenador.dart';
import 'package:iadvancedscout/modelo/player.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


class Observaciones extends StatefulWidget {
  Observaciones(this._entrenador);
  final Entrenador _entrenador;
  @override
  _Observaciones createState() => _Observaciones();
}

class _Observaciones extends State<Observaciones> {
  @override
  TextEditingController observaciones1 = TextEditingController();
  TextEditingController observaciones2 = TextEditingController();
  TextEditingController observaciones3 = TextEditingController();
  TextEditingController observaciones4 = TextEditingController();
  double _crossAxisSpacing = 8, _mainAxisSpacing = 2, _aspectRatio = 4;
  int _crossAxisCount = 2;
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: new Image.asset(Config.icono),
              onPressed: () {
                //var a = singOut();
                //if (a != null) {

                //}
              },
            )
          ],
          backgroundColor: Colors.black,
          title: Text(
              "${widget._entrenador.entrenador.toUpperCase()} (${widget._entrenador.equipo})",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.blue,
              )),
          elevation: 0,
        ),
        body: new SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
                /* Container(
              child:Texto(Colors.black, "Cualidades psicológicas", 14, Colors.white,false),
              ),*/

                Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(1.0),
                    child: Texto(
                        Colors.white,
                        "Observaciones".toUpperCase(),
                        20,
                        Colors.black,
                        false)),
                /*Container(
                    padding: EdgeInsets.all(0.0),
                    child: Texto(Colors.blue[900],"Nivel".toUpperCase()
                        ,12, Colors.white, false)),
               Container(
                    child:new Nivel(widget._jugador)
                ), */
                Container(
                    padding: EdgeInsets.all(0.0),
                    child: Texto(Colors.blue[900],"Comentarios".toUpperCase()
                        ,12, Colors.white, false)),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 0.0, left: 25.0, right: 25.0),
                child: TextField(
                  enabled:  true,
                  controller: TextEditingController(text: widget._entrenador.observaciones),
                  maxLines:15,maxLength: 1000,
                  decoration: InputDecoration(
                      fillColor: Colors.white38,
                      filled: true,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(1.0),
                      ),
                  ),
                  style: TextStyle(


                    fontWeight: FontWeight.bold,
                    fontSize: 12,

                  ),
                  onChanged: (String value) {
                    widget._entrenador.observaciones=value;
                    //_onChange(value);
                  },
                )),
              ]),
        ));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;

  final IconData icon;
}

const List<Choice> choices = const [
  const Choice(title: 'Discipliado', icon: Icons.directions_car),
  const Choice(title: 'esfuerzo', icon: Icons.directions_bike),
  const Choice(title: 'Liderazgo', icon: Icons.directions_boat),
  const Choice(title: 'Nivel de competidor', icon: Icons.directions_bus),
  const Choice(title: 'Concentración', icon: Icons.directions_railway),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Center(
          child: new MaterialButton(
        height: double.infinity,
        minWidth: double.infinity,
        color: Colors.black,
        textColor: Colors.white,
        child: new Text(choice.title),
        onPressed: () => {},
        splashColor: Colors.blue,
      )),
    );
    /*
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child:
                    Texto(Colors.white, choice.title, 14, Colors.black,false),),

              ]),
        ));*/
  }
}
