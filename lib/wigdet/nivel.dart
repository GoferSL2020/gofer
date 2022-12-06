import 'package:flutter/material.dart';
import 'package:iafootfeel/dao/jugadorDao.dart';
import 'package:iafootfeel/model/jugador.dart';



const List<Choice> choices = const [
  const Choice(title: 'Superlativo', icon: Icons.directions_car),
  const Choice(title: 'Superior', icon: Icons.directions_bike),
  const Choice(title: 'Destacado', icon: Icons.directions_boat),
  const Choice(title: 'Intermedio', icon: Icons.directions_bus),
  const Choice(title: 'Dudoso', icon: Icons.directions_railway),
  const Choice(title: 'Bajo', icon: Icons.directions_railway),
];

class Nivel extends StatefulWidget {

  Nivel(this._jugador);

  final Jugador _jugador;
  @override
  _Nivel createState() => _Nivel();
}

class _Nivel extends  State<Nivel> {
  @override
  double _crossAxisSpacing = 0, _mainAxisSpacing = 0, _aspectRatio = 1;
  int _crossAxisCount = 6;

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var height = width / _aspectRatio;
    return
            Container(
                height:80,
              child:GridView.count(
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  childAspectRatio: _aspectRatio,
                  children: <Widget>[
                    Card(
                    color: Colors.black,
                      child: Center(
                          child: new  MaterialButton(
                            height: double.infinity,
                            minWidth:  double.infinity,
                            color: widget._jugador.nivel=="Superlativo"?Colors.green:Colors.grey,
                            textColor: Colors.black,
                            child: new Text(choices[0].title, style: new TextStyle(fontSize: 10),),
                            onPressed: ()  {
                              setState(() {
                                widget._jugador.nivel="Superlativo";
                                JugadorDao con=new JugadorDao();
                                con.updateJugador(widget._jugador);
                              });
                            },
                            splashColor: Colors.blue,
                          )
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      child: Center(
                          child: new  MaterialButton(
                            height: double.infinity,
                            minWidth:  double.infinity,
                            color: widget._jugador.nivel=="Superior"?Colors.greenAccent:Colors.grey,
                            textColor: Colors.black,
                            child: new Text(choices[1].title, style: new TextStyle(fontSize: 10),),
                            onPressed: ()  {
                              setState(() {
                                widget._jugador.nivel="Superior";
                                JugadorDao con=new JugadorDao();
                                con.updateJugador(widget._jugador);
                              });
                            },
                            splashColor: Colors.blue,
                          )
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      child: Center(
                          child: new  MaterialButton(
                            height: double.infinity,
                            minWidth:  double.infinity,
                            color: widget._jugador.nivel=="Destacado"?Colors.yellow:Colors.grey,
                            textColor: Colors.black,
                            child: new Text(choices[2].title, style: new TextStyle(fontSize: 10),),
                            onPressed: ()  {
                              setState(() {
                                widget._jugador.nivel="Destacado";
                                JugadorDao con=new JugadorDao();
                                con.updateJugador(widget._jugador);
                              });
                            },
                            splashColor: Colors.blue,
                          )
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      child: Center(
                          child: new  MaterialButton(
                            height: double.infinity,
                            minWidth:  double.infinity,
                            color: widget._jugador.nivel=="Intermedio"?Colors.amber:Colors.grey,
                            textColor: Colors.black,
                            child: new Text(choices[3].title, style: new TextStyle(fontSize: 10),),
                            onPressed: ()  {
                              setState(() {
                                widget._jugador.nivel="Intermedio";
                                JugadorDao con=new JugadorDao();
                                con.updateJugador(widget._jugador);
                              });
                            },
                            splashColor: Colors.blue,
                          )
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      child: Center(
                          child: new  MaterialButton(
                            height: double.infinity,
                            minWidth:  double.infinity,
                            color: widget._jugador.nivel=="Dudoso"?Colors.red:Colors.grey,
                            textColor: Colors.black,
                            child: new Text(choices[4].title, style: new TextStyle(fontSize: 10),),
                            onPressed: ()  {
                              setState(() {
                                widget._jugador.nivel="Dudoso";
                                JugadorDao con=new JugadorDao();
                                con.updateJugador(widget._jugador);
                              });
                            },
                            splashColor: Colors.blue,
                          )
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      child: Center(
                          child: new  MaterialButton(
                            height: double.infinity,
                            minWidth:  double.infinity,
                            color: widget._jugador.nivel=="Discreto"?Colors.red[900]:Colors.grey,
                            textColor: Colors.black,
                            child: new Text(choices[5].title, style: new TextStyle(fontSize: 10),),
                            onPressed: ()  {
                              setState(() {
                                widget._jugador.nivel="Discreto";
                                JugadorDao con=new JugadorDao();
                                con.updateJugador(widget._jugador);
                              });
                            },
                            splashColor: Colors.blue,
                          )
                      ),
                    ),
                    ]
              )
                );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;

  final IconData icon;
}


