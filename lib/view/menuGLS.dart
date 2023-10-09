import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gls/auth/signup.dart';
import 'package:gls/modelo/categoria.dart';
import 'package:gls/service/UserService.dart';
import 'package:gls/view/categoria/categoriasView.dart';
import 'package:gls/view/mercancia/mercanciasView.dart';
import 'package:gls/wigdet/politica.dart';
import 'package:gls/wigdet/termino.dart';
import 'package:gls/conf/config.dart';


class MenuGLS extends StatefulWidget {
  MenuGLS();
  @override
  _MenuGLSState createState() => new _MenuGLSState();

}

class _MenuGLSState extends State<MenuGLS> {
  Key key = UniqueKey();
  String textoNombre="";
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  void inicio() async {
    await UserService().getUsuarioIniciar();
    setState(() {
      String pla=UserService.userOficina.plataforma==true?"PLATAFORMA":"OFICINA:";
      textoNombre="$pla ${UserService.userOficina.numeroOficina}-${UserService.userOficina.nombre.toUpperCase()}";
    });
  }

  @override
  void initState() {
    inicio();
   super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: new Image.asset(Config.icono),
              onPressed: () {},
            )
          ],
          backgroundColor: Config.fondo,
          title: Text("GLS - Menú",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Config.letras,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        drawer: MenuLateral(),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2, 1.0],
                  tileMode: TileMode.repeated),
            ),
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left:20,top:30.0,right: 20),
                    child: Image.asset(Config.logo2)
                ),
                Container(
                    padding: EdgeInsets.only(left:25,top:30.0,right: 20),
                    child: Text(textoNombre,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Config.fondo,
                        ),
                ),),
                UserService.userOficina.plataforma ==true?
                Padding(
                  padding: EdgeInsets.only(top:30, left:20, right: 20, bottom: 0),
                  child:
                  Container(
                    width: 250,
                    height: 85,
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(
                          width: 2,
                          color: Config.letras,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text("Subir un paquete perdido"),
                      color:  Config.fondo,
                      textColor: Config.letras,
                      splashColor: Config.fondo,

                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CategoriasView(true,"SUBIR UN mercancía")));
                        }

                    ),
                  ),
                ):Container(),
                Padding(
                  padding: EdgeInsets.only(top:25, left:20, right: 20, bottom: 0),
                  child:
                  Container(
                    width: 250,
                    height: 85,
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(
                            width: 2,
                            color: Config.fondo,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text("Paquetes perdidos"),
                        color:  Config.letras,
                        textColor: Config.fondo,
                        splashColor: Config.fondo,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CategoriasView(false,"PRODUCTOS PERDIDOS")));
                        }

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:25, left:20, right: 20, bottom: 0),
                  child:
                  Container(
                    width: 250,
                    height: 85,
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(
                            width: 2,
                            color: Config.fondo,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text("Paquetes recogidos"),
                        color:  Config.letras,
                        textColor: Config.fondo,
                        splashColor: Config.letras,
                        onPressed: () {
                          Categoria categoria=new Categoria();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MercanciaView(categoria,"PRODUCTOS RECOGIDOS")));
                        }

                    ),
                  ),
                ),
              ],
            )));
  }
}

class MenuLateral extends StatelessWidget {
  MenuLateral();

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(

        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              Config.logoGLS,
            ),

          ),
          Container(
            height: 1,
            color: Config.fondo,
          ),
          Ink(

            child: ListTile(
              title: Text(
                UserService.userOficina.nombre,
                style: TextStyle(color: Config.fondo),
              ),
              onTap: () {},
              leading:  Icon(Icons.account_box_outlined, color: Config.fondo),
            ),
          ),
          Ink(

            child: ListTile(
              title: Text(
                UserService.userOficina.lugar,
                style: TextStyle(color: Config.fondo),
              ),
              onTap: () {},
              leading:  Icon(Icons.room, color: Config.fondo),
            ),
          ),
          Ink(

            child: ListTile(
              title: Text(
                UserService.userOficina.email,
                style: TextStyle(color: Config.fondo),
              ),
              onTap: () {},
              leading:  Icon(Icons.mail, color: Config.fondo),
            ),
          ),
          Container(
            height: 1,
            color: Config.fondo,
          ),
          Ink(

            child: ListTile(
              title: Text(
                "Politica de Privacidad",
                style: TextStyle(color: Config.fondo),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Politica()),
                );
              },
              leading:  Icon(Icons.assignment_turned_in_sharp,
                  color: Config.fondo),
            ),
          ),
          Ink(

            child: ListTile(
              title: Text(
                "Término de Privacidad",
                style: TextStyle(color: Config.fondo),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Termino()),
                );
              },
              leading:  Icon(Icons.verified_user, color: Config.fondo),
            ),
          ),
          Container(
            height: 1,
            color: Config.fondo,
          ),
          Ink(

            child: ListTile(
                title: Text(
                  "Salir",
                  style: TextStyle(color: Config.fondo, fontSize: 14),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignUp()),(route) => false));
                },
                leading: Icon(
                  Icons.power_settings_new,
                  size: 20,
                  color: Colors.red,
                )),
          ),
        ]),
      ),
    );
  }


  void closeApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }
}
