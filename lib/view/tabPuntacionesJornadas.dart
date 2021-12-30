import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/model/equipo.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/view/categorias.dart';
import 'package:iadvancedscout/view/jugadoresJornada.dart';
import 'package:iadvancedscout/view/temporadas.dart';
import 'package:iadvancedscout/wigdet/texto.dart';


class TabPuntacionesJornadas extends StatefulWidget {
  @override
  TabPuntacionesJornadasState createState() => TabPuntacionesJornadasState();
  final Equipo _equipo;
  TabPuntacionesJornadas(this._equipo);


}



class TabPuntacionesJornadasState extends State<TabPuntacionesJornadas> {
  int _selectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 45,
          child: Scaffold(
            appBar:
              AppBar(actions: <Widget>[
                IconButton(
                  icon: new Image.asset(Config.icono),onPressed: () {
                  //var a = singOut();
                  //if (a != null) {
                  Navigator.of(context).pop();

                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => TemporadasPage(),
                  ));
                  //}
                },
                )
              ],
                backgroundColor:Colors.black,
                title: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    child:Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Image.network(Config.escudo(widget._equipo.equipo),
                                  height:25),
                              Texto(Colors.white, "${widget._equipo.equipo}".toUpperCase(),
                                  12, Colors.black, false)
                            ]))),

                elevation: 0,
              bottom: TabBar(
                  labelStyle: TextStyle(fontSize: 13.0),  //For Selected tab
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  indicatorWeight: 5,
                  tabs:

                  [
                    new Tab(text: 'Jor. 1'),
                    new Tab(text: 'Jor. 2'),
                    new Tab(text: 'Jor. 3'),
                    new Tab(text: 'Jor. 4'),
                    new Tab(text: 'Jor. 5'),
                    new Tab(text: 'Jor. 6'),
                    new Tab(text: 'Jor. 7'),
                    new Tab(text: 'Jor. 8'),
                    new Tab(text: 'Jor. 9'),
                    new Tab(text: 'Jor. 10'),
                    new Tab(text: 'Jor. 11'),
                    new Tab(text: 'Jor. 12'),
                    new Tab(text: 'Jor. 13'),
                    new Tab(text: 'Jor. 14'),
                    new Tab(text: 'Jor. 15'),
                    new Tab(text: 'Jor. 16'),
                    new Tab(text: 'Jor. 17'),
                    new Tab(text: 'Jor. 18'),
                    new Tab(text: 'Jor. 19'),
                    new Tab(text: 'Jor. 20'),
                    new Tab(text: 'Jor. 21'),
                    new Tab(text: 'Jor. 22'),
                    new Tab(text: 'Jor. 23'),
                    new Tab(text: 'Jor. 24'),
                    new Tab(text: 'Jor. 25'),
                    new Tab(text: 'Jor. 26'),
                    new Tab(text: 'Jor. 27'),
                    new Tab(text: 'Jor. 28'),
                    new Tab(text: 'Jor. 29'),
                    new Tab(text: 'Jor. 30'),
                    new Tab(text: 'Jor. 31'),
                    new Tab(text: 'Jor. 32'),
                    new Tab(text: 'Jor. 33'),
                    new Tab(text: 'Jor. 34'),
                    new Tab(text: 'Jor. 35'),
                    new Tab(text: 'Jor. 36'),
                    new Tab(text: 'Jor. 37'),
                    new Tab(text: 'Jor. 38'),
                    new Tab(text: 'Jor. 39'),
                    new Tab(text: 'Jor. 40'),
                    new Tab(text: 'Jor. 41'),
                    new Tab(text: 'Jor. 42'),
                    new Tab(text: 'Prom. 1'),
                    new Tab(text: 'Prom. 2'),
                    new Tab(text: 'Prom. 3'),
                  ]
              ),
            ),

            bottomNavigationBar: BottomAppBar(
              color: Colors.black,
              shape: CircularNotchedRectangle(),
              notchMargin: 4.0,
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Pais pais = Pais(widget._equipo.pais, null);
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => CategoriasPage(pais),
                      ));
                    },
                  ),
                ],
              ),
            ),
                  body:
                  TabBarView(children: [
                    JugadoresJornadaPage(widget._equipo, 1),
                    JugadoresJornadaPage(widget._equipo, 2),
                    JugadoresJornadaPage(widget._equipo, 3),
                    JugadoresJornadaPage(widget._equipo, 4),
                    JugadoresJornadaPage(widget._equipo, 5 ),
                    JugadoresJornadaPage(widget._equipo, 6),
                    JugadoresJornadaPage(widget._equipo,7),
                    JugadoresJornadaPage(widget._equipo,8),
                    JugadoresJornadaPage(widget._equipo,9),
                    JugadoresJornadaPage(widget._equipo,10),
                    JugadoresJornadaPage(widget._equipo,11),
                    JugadoresJornadaPage(widget._equipo,12),
                    JugadoresJornadaPage(widget._equipo,13),
                    JugadoresJornadaPage(widget._equipo,14),
                    JugadoresJornadaPage(widget._equipo,15),
                    JugadoresJornadaPage(widget._equipo,16),
                    JugadoresJornadaPage(widget._equipo,17),
                    JugadoresJornadaPage(widget._equipo,18),
                    JugadoresJornadaPage(widget._equipo,19),
                    JugadoresJornadaPage(widget._equipo,20),
                    JugadoresJornadaPage(widget._equipo,21),
                    JugadoresJornadaPage(widget._equipo,22),
                    JugadoresJornadaPage(widget._equipo,23),
                    JugadoresJornadaPage(widget._equipo,24),
                    JugadoresJornadaPage(widget._equipo,25),
                    JugadoresJornadaPage(widget._equipo,26),
                    JugadoresJornadaPage(widget._equipo,27),
                    JugadoresJornadaPage(widget._equipo,28),
                    JugadoresJornadaPage(widget._equipo,29),
                    JugadoresJornadaPage(widget._equipo,30),
                    JugadoresJornadaPage(widget._equipo,31),
                    JugadoresJornadaPage(widget._equipo,32),
                    JugadoresJornadaPage(widget._equipo,33),
                    JugadoresJornadaPage(widget._equipo,34),
                    JugadoresJornadaPage(widget._equipo,35),
                    JugadoresJornadaPage(widget._equipo,36),
                    JugadoresJornadaPage(widget._equipo,37),
                    JugadoresJornadaPage(widget._equipo,38),
                    JugadoresJornadaPage(widget._equipo,39),
                    JugadoresJornadaPage(widget._equipo,40),


                    JugadoresJornadaPage(widget._equipo,41),
                    JugadoresJornadaPage(widget._equipo,42),
                    JugadoresJornadaPage(widget._equipo,101),
                    JugadoresJornadaPage(widget._equipo,102),
                    JugadoresJornadaPage(widget._equipo,103),



                  ],
            ),
          )
      )
      );
  }

  @override
  void dispose() {

    super.dispose();
  }
}