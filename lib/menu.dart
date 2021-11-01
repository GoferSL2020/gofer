
import 'package:iadvancedscout/main.dart';
import 'package:iadvancedscout/service/BBDDService.dart';
import 'package:iadvancedscout/userScout.dart';
import 'package:iadvancedscout/wigdet/texto.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conf/config.dart';


class Menu extends StatefulWidget {
  Menu({this.uid});
  final String uid;
  final String title = "Menu";
  UserScout _user;
  @override
  _MenuState createState() => _MenuState();

  set user(UserScout value) {
    _user = value;
  }


}



class _MenuState extends State<Menu> {

  IconData selectedItem = Icons.dashboard;

  List<IconData> get itemsList => _items.keys;

  Map<IconData, String> _items = {
    Icons.home: 'Filtro',
    Icons.drive_eta: 'Delivery',
    Icons.shopping_basket: 'Products',
    Icons.mail: 'Messages'
  };

  ScrollController _controller;
  final scrollDirection = Axis.vertical;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  void initState() {
    super.initState();

  }




  @override
  void dispose() {
    super.dispose();

  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }
  Future<void>  singOut() async {
    try{
     return FirebaseAuth.instance
          .signOut();
    }
    catch(e){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
   return null;

  }


    @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
            IconButton(
          icon: Icon(Icons.power_settings_new_rounded),
            onPressed: (){
              var a=singOut();
              if(a!=null) {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => MyApp(),
                ));
              }
            },
          ),
          IconButton(
            icon: new Image.asset(Config.icono),

          )
        ],
        title:Text("IAScout"),
      ),



    );
  }
}

class Page extends StatelessWidget {
  const Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MenuLateral extends StatelessWidget{
  final  UserScout user;

  MenuLateral(this.user);

  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new Drawer(
      child:Container(color: Config.fondo,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("inadvanced@inadvanced.com"),
              accountName: Text("InAdvanced by Equalia S.L."),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(110),
                child: Image.asset("assets/img/icono.png", fit: BoxFit.cover,),
              ),
              decoration: BoxDecoration(
                  color: Config.colorAPP
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
              Container(width: 400,color: Config.colorAPP,
              child:Texto(Colors.white, this.user.name, 10, Config.colorAPP,false),
              ),
            ]),
        ),
    );

  }

  void cara(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => Menu(),
    ));
  }


}


