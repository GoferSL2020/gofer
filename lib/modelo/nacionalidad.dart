class Nacionalidad {
  String id="";
  String nacionalidad="";


  Nacionalidad({this.id, this.nacionalidad, });

  Nacionalidad.fromMap(Map snapshot,String id) :
        id = id ?? '',
        nacionalidad= snapshot['nacionalidad'] ?? '';


  toJson() {
    return {
      "nacionalidad": nacionalidad,
    };
  }


}