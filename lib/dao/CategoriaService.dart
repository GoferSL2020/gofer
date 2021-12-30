//import 'package:firebase_course/models/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadvancedscout/model/categoria.dart';
import 'package:iadvancedscout/model/pais.dart';
import 'package:iadvancedscout/service/BBDDService.dart';


class CategoriaService{
  String nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  CategoriaService(Pais pais){
    nodeName = "temporadas/${BBDDService().getUserScout().temporada}/paises/${pais.pais}";
  }

  addCategoria(Categoria categoria){
//    this is going to give a reference to the posts node
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(nodeName+"/${categoria.categoria.toUpperCase()}");
    //print(dbRef.toString());
    dbRef.set({
      "categoria": categoria.categoria.toUpperCase(),
    });
  // database.reference().child(nodeName).set(post);
  }

  deleteCategoria(Categoria categoria){
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(nodeName);
    //print('$nodeName/${categoria.categoria}');
    dbRef.child('${categoria.categoria}').remove();
  }

  updateCategoria(){
    database.reference().child('$nodeName/${post['pais']}').update(
      {"pais": post['pais'], "body": post['body'], "imagen":post['imagen']}
    );
  }
}