
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/dao/CRUDPais.dart';
import 'package:iafootfeel/modelo/pais.dart';
import 'package:iafootfeel/modelo/temporada.dart';
import 'package:iafootfeel/service/BBDDService.dart';
import 'package:iafootfeel/view/pais/paisCard.dart';
import 'package:iafootfeel/wigdet/abajo.dart';


class PaisView extends StatefulWidget {
  final bool _menu;
  PaisView(this._menu);

  @override
  _PaisViewState createState() => new _PaisViewState();
}

class _PaisViewState extends State<PaisView> {
  late List<Pais> paises;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final paisProvider = new CRUDPais();

    return new Scaffold(
        key: _scaffoldkey,
        appBar: new AppBar(
          actions: <Widget>[
            Container(
                    width: 50,
                    child: IconButton(
                      icon: new Image.asset(Config.icono),onPressed: () {},

                    )),
          ],
          backgroundColor: Colors.black,
          title: Text("FootFeel - Word",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Config.colorFootFeel,
              )),
          elevation: 0,
          centerTitle: true,
        ),
      bottomNavigationBar: Abajo(),
      body:
      Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text("Paises",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),),
              Expanded(
                child: StreamBuilder(
                    stream:  paisProvider.getDataCollectionPaises(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        paises = snapshot.data!.docs
                            .map((doc) => Pais.fromMap(doc.data(), doc.id))
                            .toList();

                        return ListView.builder(
                          itemCount: paises.length,
                          itemBuilder: (buildContext, index) =>
                          (BBDDService().getUserScout().tengoPais(paises[index].pais))==true?
                              PaisCard(paisDetails: paises[index],
                                  menu: widget._menu):Container()
                        );
                      } else {
                        return Text('fetching');

                      }
                    }),
              ),
            ]
        ),
      ),
    );
  }
}
