class Equipo {
  String id="";
  String equipo="";
  String categoria="";
  String competicion="";
  String temporada="";
  String entrenador="";
  String club="";
  int indice=0;
  int duracionMinutos=0;

  String scouter="";


  Equipo({this.id, this.equipo, this.categoria, this.temporada, this.entrenador,this.club,
      this.indice});

  Equipo.fromMap(Map snapshot,String id) :
        id = id ?? '',
        equipo= snapshot['equipo'] ?? '',
        categoria = snapshot['categoria'] ?? '',
        competicion = snapshot['competicion'] ?? '',
        temporada = snapshot['temporada'] ?? '',
        entrenador = snapshot['entrenador'] ?? '',
        club = snapshot['club'] ?? '',
        indice = snapshot['indice'] ?? 0,
        scouter = snapshot['scouter'] ?? '',
        duracionMinutos = snapshot['duracionMinutos'] ?? 0;

  toJson() {
    return {
      "equipo": equipo,
      "categoria": categoria,
      "temporada": temporada,
      "competicion": competicion,
      "entrenador": entrenador,
      "club": club,
      "indice": indice,
      "scouter": scouter,
      "duracionMinutos": duracionTiempo(categoria),

    };
  }


  int indiceCategoria(String aux){

    if(aux.toUpperCase().contains("SENIOR"))
      return 1;
    if(aux.toUpperCase().contains("JUVENIL"))
      return 2;
    if(aux.toUpperCase().contains("CADETE"))
      return 3;
    if(aux.toUpperCase().contains("INFANTIL"))
      return 4;
    if(aux.toUpperCase().contains("ALEVIN"))
      return 5;
    if(aux.toUpperCase().contains("BENJAMIN"))
      return 6;
    if(aux.toUpperCase().contains("PREBENJAMIN"))
      return 7;
    if(aux.toUpperCase().contains("FEMENINO"))
      return 8;
  }

  int duracionTiempo(String aux){

    if(aux.toUpperCase().contains("SENIOR"))
      return 90;
    if(aux.toUpperCase().contains("JUVENIL"))
      return 90;
    if(aux.toUpperCase().contains("CADETE"))
      return 80;
    if(aux.toUpperCase().contains("INFANTIL"))
      return 70;
    if(aux.toUpperCase().contains("ALEVIN"))
      return 60;
    if(aux.toUpperCase().contains("ALEVIN-7"))
      return 60;
    if(aux.toUpperCase().contains("BENJAMIN"))
      return 50;
    if(aux.toUpperCase().contains("PREBENJAMIN"))
      return 50;
    if(aux.toUpperCase().contains("CHUPETIN"))
      return 30;
  }



}
