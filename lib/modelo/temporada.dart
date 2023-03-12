
class Temporada {
  String id="";
  String temporada="";
  int anio=0;

  Temporada(this.id, this.temporada, this.anio);

  Temporada.fromMap(Map snapshot,String id) :
        id = id ?? '',
        temporada = snapshot['temporada'] ?? '',
        anio = snapshot['anio'] ?? 0;

  toJson() {
    return {
      "temporada": temporada,
      "anio": anio,

    };
  }




}