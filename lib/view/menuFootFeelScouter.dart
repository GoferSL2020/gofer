import 'package:flutter/material.dart';
import 'package:iafootfeel/dao/CRUDScout.dart';
import 'package:iafootfeel/modelo/FiltroJugadores.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/userScout.dart';
import 'package:iafootfeel/view/jugadores/jugadoresView.dart';
import 'package:iafootfeel/conf/config.dart';

import '../custom_icon_icons.dart';

class MenuFootFeelScouter extends StatefulWidget {
  MenuFootFeelScouter();
  @override
  _MenuFootFeelScouterState createState() => new _MenuFootFeelScouterState();
}

class _MenuFootFeelScouterState extends State<MenuFootFeelScouter> {

  String contador="";
  List<UserScout> scout=new List<UserScout>();
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });
    setState(() {
      _cogerScout();
    });
    super.initState();
  }

  _getRequests()async{
    setState(() {
      _cogerScout();
    });
  }


  _cogerScout() async {
    //print("PAIS");
    //print(_temporadaAux.id);
    List<UserScout> datos;
      datos = await CRUDUserScout().fetchUserScouts();
    setState(() {
      print("SCOYTER:${datos.length}");
      scout=datos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //backgroundColor: Colors.black,
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: new Image.asset(Config.icono),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.black,
          title: Text("FootFeel - Agentes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18  ,
              color: Config.colorFootFeel,
            )),
          elevation: 0,
          centerTitle: true,
        ),
        body:
        Container(
            child: Column(children: <Widget>[
              Container(
                height: 25,
                width: double.infinity,
                color:Colors.black,
                child:Text("Lista de Agentes FootFeel",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),),
              Visibility(
                  visible: scout.isNotEmpty,
                  child: Flexible(
                      child:
                      ListView.separated(
                        itemCount: scout.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 0,
                            color: Colors.green,
                          );
                        },
                          itemBuilder: (buildContext, index) {
                            return
                            (BBDDService().getUserScout().puesto=="FootFeel" ||
                                BBDDService().getUserScout().puesto=="Marketing" ||
                                BBDDService().getUserScout().name=="${scout[index].name}")?
                             ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => JugadoresView(FiltroJugadores(scout[index].name,true,"","Agentes - ${scout[index].name}","",""),null)));
                                },

                                 title: Row(children: [
                                      //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                                      Expanded(child: Text("Agente FootFeel",
                                        style: TextStyle(

                                            color: Colors.blue.shade800,
                                            fontSize: 12.0,fontWeight: FontWeight.bold
                                            ),
                                      ),),
                                    ]),
                                    trailing: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 1, right: 5),
                                          height: 15.0,
                                          child: Text("",

                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          new Container(
                                              padding:
                                              EdgeInsets.only(top: 1, right: 5),
                                              height: 25.0,
                                              child: Text(
                                                "${scout[index].apellido}",
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                            ],
                                          ),
                               leading: CircleAvatar(
                                 backgroundImage: AssetImage("assets/img/scouter.png"),
                               )
                             ):Container(height: 0,);

                          },
                      ),
                  )
              )
            ])
        )
    );
  }
}
