import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gls/conf/config.dart';
import 'package:gls/view/menuGLS.dart';
class Abajo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Config.fondo,
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Config.letras,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => MenuGLS(),
              ));
            },
          ),
        ],
      ),
    );
  }
}