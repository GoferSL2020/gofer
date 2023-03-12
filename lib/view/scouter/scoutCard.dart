import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/modelo/userScout.dart';
import 'package:iafootfeel/view/scouter/scoutEquiposView.dart';

class ScoutCard extends StatefulWidget {
  final UserScout scout;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  ScoutCard({required this.scout});

  final productProvider = new CRUDUserScout();
  @override
  _ScoutCardState createState() => new _ScoutCardState();
}

class _ScoutCardState extends State<ScoutCard> {
  List<String> categoriasString = [];

  @override
  void initState() {
    //_cogerScouts();
  }

  void inicial() async {
    setState(() {});
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    inicial();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            ScoutEquiposView(widget.scout)));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          shadowColor: Config.colorFootFeel,
          color: Config.colorCard,
          elevation: 50,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.scout.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Config.colorFootFeel,
                                fontSize: 16,
                                fontFamily: 'Roboto')),
                        Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Image.asset(
                              Config.icono,
                              height: 30,
                            )),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
