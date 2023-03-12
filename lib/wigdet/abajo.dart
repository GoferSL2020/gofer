import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/view/menuFootFeel.dart';
class Abajo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => MenuFootFeel(),
              ));
            },
          ),
        ],
      ),
    );
  }
}