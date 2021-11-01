import 'package:iadvancedscout/conf/config.dart';
import 'package:iadvancedscout/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Afasia extends StatelessWidget {
  String descripcion =
      "\nEste tipo de terapia nace de las observaciones de un médico en 1833, que vio"
      " como una persona con afasia comenzó a mejorar gracias a la repetición de palabras. Desde entonces "
      "se ha visto la terapia de repetición como una técnica interesante con efectos en el lenguaje de ellas personas con afasia. "
      "Existen estudios, por ejemplo, con efectos demostrados en Afasia de Conducción, donde se demostraron beneficios en "
      "la planificación fonética de las palabras (Berthier, 2014)."
      "\n\nTambién, se ha visto el beneficio del entrenamiento en repetición de palabras como mejora de acceso al léxico en personas "
      "con la capacidad de repetir pseudopalabras conservada (Nozari, 2010). "
      "En algún caso de estudio único (y no observándose esos efectos en población más abundante), "
      "parece haberse observado que la repetición de palabras puede haber estimulado procesos similares "
      "a los estimulados en tareas de tratamiento semántico (Boo,2011). "
      "\n\nExisten diferentes formas de generar tareas basadas en repetición. "
      "Podemos realizarla repetición de palabras reales, pseudopalabras, no palabras, frases sencillas, "
      "frases complejas y frases abstractas. En cada tarea estaremos proponiendo material verbal diversos "
      "que favorecerá el uso de unos u otros procesos lingüísticos al combinar diversas variables "
      "(longitud de palabra, imaginabilidad, frecuencia, complejidad articulatoria) con el consecuente "
      "trabajo de diferentes circuito neuronales que puede favorecer la creación de nuevas conexiones "
      "sinópticas de a cuerdo a los principios de neuroplasticidad (Kleim, 2008).";


  _sendingMails() async {
    const url = 'mailto:gofersl2020@gmail.com';
    if (await canLaunch(url)) {

      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    //var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor:Config.fondo ,
        appBar: AppBar(backgroundColor: Config.colorAPP,
          /*actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),
          )
        ],*/
          title: Text(AppLocalization.of(context).terapia,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
        ),
        body:
        new SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
               new
               Container(
                 margin: new EdgeInsets.only(bottom: 10.0,top: 20.0, left: 20.0, right: 20.0),
                  child: new Text(
                  descripcion,
                  style: const TextStyle(
                    fontFamily: "Lato",
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF56575a)),
              ),
              ),
              Container(
                  margin: new EdgeInsets.only(bottom: 20.0,top: 5.0, left: 20.0, right: 20.0),
                  child: new
                FlatButton(
                  onPressed: _sendingMails,
                  color: Config.fondo,
                  padding: EdgeInsets.all(10.0),
                  child: Row( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.mail_outline, color: Config.mail,),
                      Text("gofersl2020@gmail.com", style: TextStyle(color: Config.mail), )
                    ],
                  ),
                ),
              ),
              ]),
        )
    );
  }

}