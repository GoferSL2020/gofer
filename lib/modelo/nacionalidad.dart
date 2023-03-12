class Nacionalidad {
  String id="";
  String nacionalidad="";

  Nacionalidad();



  Nacionalidad.fromMap(dynamic snapshot,String id) :
        id = id ?? '',
        nacionalidad= snapshot['nacionalidad'] ?? '';


  toJson() {
    return {
      "nacionalidad": nacionalidad,
    };
  }


}