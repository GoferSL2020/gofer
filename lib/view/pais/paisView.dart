
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDPais.dart';
import 'package:iadvancedscout/modelo/pais.dart';
import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/pais/paisCard.dart';
import 'package:iadvancedscout/wigdet/abajo.dart';


class PaisView extends StatefulWidget {
  final Temporada temporada;

  PaisView({@required this.temporada});

  @override
  _PaisViewState createState() => new _PaisViewState();
}

class _PaisViewState extends State<PaisView> {
  List<Pais> paises;
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
          title: Text("IAScout - Países",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
      bottomNavigationBar: Abajo(temporada: widget.temporada,),
      body:
      Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 20,
                width: double.infinity,
                color:Colors.black,
                child:Text(
                  widget.temporada.temporada,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Config.colorAPP,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),),
              Expanded(
                child: StreamBuilder(
                    stream:  paisProvider.getDataCollectionPaises(widget.temporada),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        paises = snapshot.data.docs
                            .map((doc) => Pais.fromMap(doc.data(), doc.id))
                            .toList();

                        return ListView.builder(
                          itemCount: paises.length,
                          itemBuilder: (buildContext, index) =>
                              PaisCard(temporada: widget.temporada, paisDetails: paises[index]),
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
