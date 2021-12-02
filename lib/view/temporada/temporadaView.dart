import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/dao/CRUDTemporada.dart';

import 'package:iadvancedscout/modelo/temporada.dart';
import 'package:iadvancedscout/view/temporada/temporadaCard.dart';
import 'package:iadvancedscout/view/temporadas.dart';

class TemporadaView extends StatefulWidget {
  @override
  _TemporadaViewState createState() => new _TemporadaViewState();
}

class _TemporadaViewState extends State<TemporadaView> {
  List<Temporada> temporada;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  var mymap = {};
  var title = '';
  var body = {};
  var mytoken = '';

  final FirebaseFirestore _db = FirebaseFirestore.instance;
 // final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;



  @override
  void initState() {
    super.initState();
   /* if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        print("DADADA");
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // Scaffold.of(context).showSnackBar(snackbar);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content:
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    new  Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/iaclub.appspot.com/o/equipos%2F${BBDDService().getUsuario().idClub}?alt=media",
                      height: 50,width: 50,
                    ),
                  ]),
                   //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                  new Text(message['NOTIFICACIONES']==null?"":message['NOTIFICACIONES'],softWrap: true,
                    style:new TextStyle(fontStyle:FontStyle.normal,
                        color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
              ],),
            actions: <Widget>[
              FlatButton(
                color: Colors.black,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        return
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                new Text(message['NOTIFICACIONES'],softWrap: true,
                  style:new TextStyle(fontStyle:FontStyle.normal,
                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,)
            ],);
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        return
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                //Image.asset('assets/${snap.value['equipo'].toString()}/${snap.value['jugador'].toString()}.png', height: 25.0, width: 25.0),
                new Text(message['NOTIFICACIONES'],softWrap: true,
                  style:new TextStyle(fontStyle:FontStyle.normal,
                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
            ],);
        // TODO optional
      },
    );*/
  }
  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  /*
  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    //String uid = 'jeffd23';
    User user = FirebaseAuth.instance.currentUser;
    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .doc(user.uid)
          .collection('tokens')
          .doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });

      _subscribeToTopic();
    }
  }

  /// Subscribe the user to a topic
  _subscribeToTopic() async {
    // Subscribe the user to a topic
    print("futbolIASCOUT");
    _fcm.subscribeToTopic('futbolIASCOUT');

  }*/
  iniciar() async{
   //await BBDDService().getClubIniciar(BBDDService().getUsuario().idClub);

  }

  @override
  Widget build(BuildContext context) {

    final temporadaProvider = new CRUDTemporada();
    iniciar();
    return new Scaffold(
        key: _scaffoldkey,
        drawer: MenuLateral(),
        appBar: new AppBar(
          actions: <Widget>[
            Container(
                    width: 50,
                    child: IconButton(
                      icon: new Image.asset(Config.icono),onPressed: () {},

                    )),
          ],
          backgroundColor: Colors.black,
          title: Text("IAScout - Temporadas",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.black,
              child: Text(
                "TEMPORADAS",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Config.colorAPP,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              height: 600,
              child: StreamBuilder(
                  stream: temporadaProvider.fetchTemporadasAsStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      temporada = snapshot.data.docs
                          .map((doc) => Temporada.fromMap(doc.data(), doc.id))
                          .toList();

                      return ListView.builder(
                        itemCount: temporada.length,
                        itemBuilder: (buildContext, index) =>
                            TemporadaCard(temporadaDetails: temporada[index]),
                      );
                    } else {
                      return Text('fetching');
                    }
                  }),
            ),
          ]),
        ));
  }


}
