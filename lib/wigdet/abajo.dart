import 'package:iadvancedscout/conf/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class abajo extends StatelessWidget {
  const abajo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Config.colorMenu,
        primaryColor: Config.fondo,
      ),
      child: Container(
        height: 50,
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage("assets/img/bottom2.png"), fit: BoxFit.cover,),
        ),),
    );
  }
}