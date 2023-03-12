class Pais {
  String id="";
  String pais="";
  String temporada="";
  bool cantera=false;


  Pais(this.id, this.pais,  this.temporada);


  Pais.fromMap(dynamic snapshot,String? id) :
        id = id ?? '',
        pais= snapshot['pais'] ?? '',
        temporada = snapshot['temporada'] ?? '',
         cantera = snapshot['cantera'] ?? false;

  toJson() {
    return {
      "pais": pais,
      "temporada": temporada,
      "cantera": cantera,
    };
  }


}