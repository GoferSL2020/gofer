//import 'package:firebase_course/models/post.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadvancedscout/service/BBDDService.dart';


class PaisService{
  String nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  PaisService();

  addPais(Pais pais){
//    this is going to give a reference to the posts node
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(nodeName+"/${pais.pais.toUpperCase()}");
    //print(dbRef.toString());
    dbRef.set({
      "pais": pais.pais.toUpperCase(),
    });
  // database.reference().child(nodeName).set(post);
  }

  deletePais(Pais pais){
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(nodeName);
    //print('$nodeName/${pais.pais}');
    dbRef.child('${pais.pais}').remove();
  }

  updatePais(){
    database.reference().child('$nodeName/${post['pais']}').update(
      {"pais": post['pais'], "body": post['body'], "imagen":post['imagen']}
    );
  }
}