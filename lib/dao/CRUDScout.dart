
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadvancedscout/userScout.dart';

class CRUDUserScout {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;
  CollectionReference refNuevo;

  CRUDUserScout() {
  }

  List<UserScout> UserScouts;

  Future<QuerySnapshot> getDataCollection() {
    return _db.collection("User").get();
  }

  Future<List<UserScout>> fetchUserScouts() async {
    var result = await _db.collection("UserScouts").get();
    UserScouts = result.docs
        .map((doc) => UserScout.fromJson(doc.id, doc.data()))
        .toList();

    return UserScouts;
  }

  Stream<QuerySnapshot> fetchUserScoutsAsStream() {
    return _db.collection("UserScouts")
        .orderBy("UserScout", descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return _db.collection("UserScouts").doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return _db.collection("UserScouts").doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    ref = _db.collection("UserScouts");
    return ref.add(data);
  }

  Future<void> updateUserScout2(UserScout data, String id) {
    return ref.doc(id).update({
      "categoria": data.categoria
    });
  }


  updateUserScout(UserScout data) async {
    String path = "Users/${data.id}";
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child(path);
    print(path);
    print(data.id);
     await dbRef.update({
      "categoria": data.categoria,

    });
  }
}