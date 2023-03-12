import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:url_launcher/url_launcher.dart';

class Termino extends StatelessWidget {
  String descripcion =
      "<html><div>"
      "</p><b>TÉRMINOS Y CONDICIONES DE USO APP</b>"
"</p>1. Estos Términos y Condiciones de Uso regulan las reglas a que se sujeta la utilización de la APP ____________________ (en adelante, la APP), que puede descargarse desde el dominio _______________________________ La descarga o utilización de la APP atribuye la condición de Usuario a quien lo haga e implica la aceptación de todas las condiciones incluidas en este documento y en la Política de Privacidad y el Aviso Legal de dicha página Web. El Usuario debería leer estas condiciones cada vez que utilice la APP, ya que podrían ser modificadas en lo sucesivo."
"</p>2. Únicamente los Usuarios expresamente autorizados por InAdvanced by Equalia  S.L. podrán acceder a la descarga y uso de la APP. Los Usuarios que no dispongan de autorización, no podrán acceder a dicho contenido."
"</p>3. Cargos: eres responsable del pago de todos los costes o gastos en los que incurras como resultado de descargar y usar la Aplicación de InAdvanced by Equalia  S.L., incluido cualquier cargo de red de operador o itinerancia. Consulta con tu proveedor de servicios los detalles al respecto."
"</p>4. Estadísticas anónimas: InAdvanced by Equalia  S.L. se reserva el derecho a realizar un seguimiento de tu actividad en la Aplicación de y a informar de ello a nuestros proveedores de servicios estadísticos de terceros. Todo ello de forma anónima."
"</p>5. Protección de tu información personal: queremos ayudarte a llevar a cabo todos los pasos necesarios para proteger tu privacidad e información. Consulta la Política de privacidad de InAdvanced by Equalia  S.L. y los avisos sobre privacidad de la Aplicación para conocer qué tipo de información recopilamos y las medidas que tomamos para proteger tu información personal."
"</p>6. Queda prohibido alterar o modificar ninguna parte de la APP a de los contenidas de la misma, eludir, desactivar o manipular de cualquier otra forma (o tratar de eludir, desactivar o manipular) las funciones de seguridad u otras funciones del programa y utilizar la APP o sus contenidos para un fin comercial o publicitario. Queda prohibido el uso de la APP con la finalidad de lesionar bienes, derechos o intereses de InAdvanced by Equalia  S.L. o de terceros. Queda igualmente prohibido realizar cualquier otro uso que altere, dañe o inutilice las redes, servidores, equipos, productos y programas informáticos de InAdvanced by Equalia  S.L. o de terceros."
"</p>7. La APP y sus contenidos (textos, fotografías, gráficos, imágenes, tecnología, software, links, contenidos, diseño gráfico, código fuente, etc.), así como las marcas y demás signos distintivos son propiedad de InAdvanced by Equalia  S.L. o de terceros, no adquiriendo el Usuario ningún derecho sobre ellos por el mero uso de la APP. El Usuario, deberá abstenerse de:"
"</p>&nbsp&nbsp&nbsp&nbsp a) Reproducir, copiar, distribuir, poner a disposición de terceros, comunicar públicamente, transformar o modificar la APP o sus contenidos, salvo en los casos contemplados en la ley o expresamente autorizados por InAdvanced by Equalia  S.L. o por el titular de dichos derechos."
"</p>&nbsp&nbsp&nbsp&nbsp b) Reproducir o copiar para uso privado la APP o sus contenidos, así como comunicarlos públicamente o ponerlos a disposición de terceros cuando ello conlleve su reproducción."
      "</p>&nbsp&nbsp&nbsp&nbsp  c) Extraer o reutilizar todo o parte sustancial de los contenidos integrantes de la APP."
"</p>8. Con sujeción a las condiciones establecidas en el apartado anterior, InAdvanced by Equalia  S.L. concede al Usuario una licencia de uso de la APP, no exclusiva, gratuita, para uso personal, circunscrita al territorio nacional y con carácter indefinido. Dicha licencia se concede también en los mismos términos con respecto a las actualizaciones y mejoras que se realizasen en la aplicación. Dichas licencias de uso podrán ser revocadas por InAdvanced by Equalia  S.L. unilateralmente en cualquier momento, mediante la mera notificación al Usuario."
"</p>9. Corresponde al Usuario, en todo caso, disponer de herramientas adecuadas para la detección y desinfección de programas maliciosos o cualquier otro elemento informático dañino. InAdvanced by Equalia  S.L. no se responsabiliza de los daños producidos a equipos informáticos durante el uso de la APP. Igualmente, InAdvanced by Equalia  S.L. no será responsable de los daños producidos a los Usuarios cuando dichos daños tengan su origen en fallos o desconexiones en las redes de telecomunicaciones que interrumpan el servicio."
"</p>10. IMPORTANTE: Podemos, sin que esto suponga ninguna obligación contigo, modificar estas Condiciones de uso sin avisar en cualquier momento. Si continúas utilizando la aplicación una vez realizada cualquier modificación en estas Condiciones de uso, esa utilización continuada constituirá la aceptación por tu parte de tales modificaciones. Si no aceptas estas condiciones de uso ni aceptas quedar sujeto a ellas, no debes utilizar la aplicación ni descargar o utilizar cualquier software relacionado. El uso que hagas de la aplicación queda bajo tu única "
      "responsabilidad. No tenemos responsabilidad alguna por la eliminación o la incapacidad de almacenar o trasmitir cualquier contenido u otra información mantenida o trasmitida por la aplicación. No somos responsables de la precisión o la fiabilidad de cualquier información o consejo trasmitidos a través de la aplicación. Podemos, en cualquier momento, limitar o interrumpir tu uso a nuestra única discreción. Hasta el máximo que permite la ley, en ningún caso seremos responsables por cualquier pérdida o daño relacionados."
"</p>11. El Usuario se compromete a hacer un uso correcto de la APP, de conformidad con la Ley, con los presentes Términos y Condiciones de Uso y con las demás reglamentos e instrucciones que, en su caso, pudieran ser de aplicación El Usuario responderá frente a InAdvanced by Equalia  S.L. y frente a terceros de cualesquiera daños o perjuicios que pudieran causarse por incumplimiento de estas obligaciones."
"</p>12. Estos Términos y Condiciones de Uso se rigen íntegramente por la legislación española. Para la resolución de cualquier conflicto relativo a su interpretación o aplicación, el Usuario se somete expresamente a la jurisdicción de los tribunales de _____________________________ (España).</div></html>";


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

    return Scaffold(
        backgroundColor:Config.fondo ,
        appBar: AppBar(
          /*actions: <Widget>[
          IconButton(
            icon: new Image.asset(Config.icono),
          )
        ],*/
          title: Text("Termino de Privacidad",
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

              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                new
                Container(
                  margin: new EdgeInsets.only(bottom: 0.0,top: 0.0, left: 10.0, right: 10.0),

                  child: Html(
                    data: descripcion,
                    style: {"span": Style(
                      backgroundColor: Colors.black,
                    )}
                )),
                Container(
                  margin: new EdgeInsets.only(bottom: 20.0,top: 5.0, left: 20.0, right: 20.0),
                  child: new
                  TextButton(
                    onPressed: _sendingMails,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.mail_outline, color: Config.mail,),
                        Text("inadvanced@inadvanced.com", style: TextStyle(color: Config.mail), )
                      ],
                    ),
                  ),
                ),
              ]),
        )
    );
  }

}