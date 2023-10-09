
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gls/conf/config.dart';
import 'package:url_launcher/url_launcher.dart';

class Politica extends StatelessWidget {
  String descripcion =
      "<html><div>"
      "</p><b>Recogida y​ ​tratamiento​ ​de​ ​datos​ ​de​ ​carácter​ ​personal</b></p>"
      "Los datos de carácter personal son los que pueden ser utilizados para"
      "identificar​ ​a​ ​una​ ​persona​ ​o​ ​ponerse​ ​en​ ​contacto​ ​con​ ​ella.</p>"
      "_______________________ ​​​​​puede​ ​solicitar ​​datos​ ​personales de ​​usuarios ​ ​al​ ​acceder​​a aplicaciones​ ​de​"
      " ​la empresa o de otras​ ​empresas​ ​afiliadas​ ​así​ ​como​ ​la posibilidad​ ​de​ ​que​ ​entre​ "
      "​estas​ ​empresas​ ​puedan​ ​compartir​ ​esos​ ​datos para​ ​mejorar​ ​los​ ​productos​ ​y​ ​servicios​ "
      "​ofrecidos.​ ​Si​ ​no​ ​se​ ​facilitan​ ​esos datos​ ​personales,​ ​en​ ​muchos​ ​casos​ ​no​ ​podremos​ ​ofrecer​ ​los​ ​productos​ ​o servicios​ ​solicitados."
      "Estos son algunos ejemplos de las categorías de datos de carácter personal que "
      "________________________ puede recoger y la finalidad para los que puede llevar​ ​a​ ​cabo​ ​el​ ​tratamiento​ ​de​ ​estos​ ​datos."
      "</p><b>¿Qué​ ​datos​ ​de​ ​carácter​ ​personal​ ​se​ ​pueden​ ​recopilar</b>"
      "</p>   - Al crear un ID, solicitar un crédito comercial, comprar un mercancía, "
      "descargar una actualización de software, se recopilan diferentes datos, como "
      "nombre, dirección postal, número de teléfono, dirección​ ​de​ ​correo​ ​electrónico​ ​o​ ​los​ ​datos​ ​de​ ​la tarjeta​ ​de​ ​crédito."
      "</p>   - Cuando se comparten contenidos con familiares y amigos o se invita "
      "a otras personas a participar en los servicios o foros, pueden recogerse los datos que "
      "facilitamos sobre esas personas, como su nombre, domicilio, correo electrónico y número de teléfono. Se utilizarán dichos datos para completar sus pedidos, mostrarle el mercancía o servicio correspondiente o para combatir el​ ​fraude."
      "</p><b>Propósito del​ ​tratamiento​ ​de​ ​datos​ ​de​ ​carácter​ ​personal</b></p> InAdvanced by Equalia  S.L. ​​​​​podrá ​​utilizar "
      "​​los ​​datos ​​personales​ ​recabados​ ​para:"
      "</p>   - Los datos de carácter personal recopilados permiten mantenerle informado "
      "acerca de los últimos productos, las actualizaciones de​ ​software​ ​disponibles​ ​y​ ​los​ ​próximos​ ​eventos."
      "</p>   - También se utilizan los datos de carácter personal como ayuda para elaborar, "
      "perfeccionar, gestionar, proporcionar y mejorar los productos, servicios, contenidos y "
      "publicidad,​ ​y​ ​con​ ​el​ ​propósito​ ​de​ ​evitar​ ​pérdidas​ ​y​ ​fraudes."
      "</p>   - Pueden utilizarse los datos de carácter personal para comprobarla identidad, "
      "colaborar en la identificación de usuarios​ ​y​ ​decidir los​ ​servicios​ ​apropiados."
      "</p>   - También se utilizan esos datos de carácter personal con propósitos internos, "
      "incluyendo auditorías, análisis de datos y sondeos, para mejorar los productos, servicios y comunicaciones​ ​a​ ​clientes."
      "</p>   - Si participa en un sorteo, un concurso o una promoción, pueden usarse los datos "
      "proporcionados para administrar estos programas."
      "</p><b>Recopilación y tratamiento de datos de carácter no personal</b></p>"
      " InAdvanced by Equalia  S.L. también recopilará datos de un modo que, porsí mismos, no pueden ser asociados "
      "directamente a una persona determinada. Estos datos de carácter no personal se pueden recopilar,"
      " tratar, transferir y publicar con cualquier intención. Estos son algunos ejemplos de las clases de "
      "datos de carácter no personal que InAdvanced by Equalia  S.L. puede recopilar y los fines para los que se realiza su tratamiento:"
      "</p>   - Datos tales como profesión, idioma, código postal, identificador único de dispositivo,"
      " etc. para comprender mejor la conducta de nuestros clientes y mejorar nuestros productos, servicios y anuncios​ ​publicitarios."
      "</p>   - Datos sobre cómo se usan determinados servicios, incluidas las consultas de búsqueda."
      " Esta información se puede utilizar para incrementar la importancia de los resultados que aportan los servicios​ ​ofrecidos."
      "</p>   - Datos sobre cómo usa su dispositivo y las aplicaciones para facilitar a​ ​los​ "
      "​desarrolladores​ ​la mejora​ ​de esas aplicaciones."
      "Si juntamos datos de carácter no personal con datos personales, los datos mezclados serán "
      "tratados como datos personales mientras sigan estando​ ​combinados."
      "</p><b>Divulgación​ ​a​ ​terceros</b></p>"
      "Ocasionalmente InAdvanced  by  EqualiaS.L. puede facilitar determinados datos de carácter personal a socios "
      "estratégicos que trabajen con nosotros para proveer productos y servicios o nos ayudan en "
      "nuestras actividades de marketing. No se compartirán los datos con ningún tercero para sus propios​ ​fines​ ​de​ ​marketing."
      "</p><b>Proveedores​ ​de​ ​servicios</b></p>"
      " InAdvanced by Equalia  S.L. compartirá datos de carácter personal con empresas que se ocupan, entre otras "
      "actividades, de prestar servicios de tratamiento de datos, conceder créditos, tramitar "
      "pedidos de clientes, presentar sus productos, mejorar datos de clientes, suministrar servicios "
      "de atención al cliente, evaluarsu interés en productos y servicios y realizar investigaciones "
      "sobre​ ​clientes​ ​o​ ​su​ ​grado de​ ​satisfacción."
      "</p><b>Otros​ ​terceros</b></p>"
      "Es posible que InAdvanced by Equalia S.L.​ divulgue datos de carácter personal por mandato legal, en el "
      "marco de un proceso judicial o por petición de una autoridad pública, tanto dentro como fuera "
      "de su país de residencia. Igualmente se puede publicar información personal si es necesaria o "
      "conveniente por motivos de seguridad nacional, para acatar la legislación vigente​ ​o​ ​por​ ​otras​ "
      "​razones relevantes​ ​de​ ​orden​ ​público."
      "</p><b>Protección​ ​de​ ​datos​ ​de​ ​carácter​ ​personal</b></p>"
      " InAdvanced by Equalia  S.L. garantizará la protección de los datos personales mediante cifrado durante "
      "el tránsito y, los alojados en instalaciones, con medidas​ ​de​ ​seguridad​ ​físicas. Al usarciertos "
      "productos, servicios o aplicaciones o al publicar opiniones en foros, salas de chat o redes sociales, el contenido y los datos de carácter personal que se comparta serán visible para otros usuarios, que tendrán la posibilidad de leerlos, compilarlos o usarlos. Usted será responsable de los datos de carácter personal que distribuya o​ ​proporcione​ ​en​ ​estos​ ​casos."
      "</p><b>Integridad​ ​y​ ​conservación​ ​de​ ​datos​ ​de​ ​carácter​ ​personal</b></p>"
      " InAdvanced by Equalia  S.L. garantizará la exactitud y la calidad de los datos personales, se conservarán "
      "durante el tiempo necesario para cumplir los fines para los que fueron recabados, salvo que "
      "la ley exija conservarlos durante​ ​más​ ​tiempo."
      "</p><b>Acceso​ ​a​ ​los​ ​datos​ ​de​ ​carácter​ ​personal</b></p>"
      "Respecto a los datos de carácter personal que conservamos, ______________________. le ofrece acceso a "
      "ellos para cualquier fin, incluyendolas solicitudes de rectificación en caso de que sean incorrectos "
      "o de eliminación en caso de no estar obligados a conservarlos por imperativo legal o por razones legítimas de negocio. "
      "Nos reservamos el derecho a no tramitar aquellas solicitudes que sean improcedentes o vejatorias, que pongan en riesgo "
      "la privacidad de terceros, que resulten inviables o para las que la legislación local no exija derecho de acceso. "
      "Las solicitudes de acceso, rectificación o eliminación podrán enviarse a nuestra dirección "
      "<b><i>Calle Nogal 1, Torrelodnes (28250) MADRID</i></b> o en la cuenta de correo electrónico <a href='mailto:gofersl2020@gmail.com'>gofersl2020@gmail.com</a> "
      "</p><b>​Niños​ ​y​ ​educación</b></p>"
      "________________ es consciente de la necesidad de establecer precauciones adicionales para preservar "
      "la privacidad y la seguridad de los menores que utilizan las aplicaciones y exigir consentimiento"
      " de sus progenitores en caso de que no tengan la edad mínima exigida por la legislación (en España,​ ​14​ ​años)."
      "Si se han recopilado datos personales de un menor de 14 años, sin el consentimiento necesario, "
      "se debe eliminar esa información lo antes posible."
      "</p><b>Servicios​ ​de​ ​localización</b></p>"
      "Para prestar servicios de localización__________________ podrá reunir, utilizar y compartir datos exactos sobre "
      "ubicaciones, incluyendo la situación geográfica en tiempo real de su ordenador o de su dispositivo. Salvo "
      "que nos den su consentimiento, estos datos de localización se recogen de manera anónima de forma que no "
      "pueden utilizarse para identificarlo personalmente, y son usados para suministrar y mejorar sus productos​ "
      "y ​servicios​ ​de​ ​localización. "
      "</p><b>Páginas​ ​web​ ​y​ ​servicios​ ​de​ ​terceros. </b></p>"
      "Las aplicaciones pueden contener enlaces a páginas web, productos y servicios de terceros. "
      "También pueden utilizar u ofrecer productos o servicios de terceros. "
      "La recogida de datos por parte de terceros, introduciendo de datos sobre ubicaciones geográficas "
      "o datos de contacto, se guiará por sus respectivas políticas de privacidad. Le recomendamos​ "
      "​consultar​ ​las políticas​ ​de​ ​privacidad​ ​de​ ​esos terceros.</p></div></html>";


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

              appBar: AppBar(
          actions: <Widget>[
            Container(
                width: 50,
                child: IconButton(
                  icon: new Image.asset(Config.icono),
                  onPressed: () {},
                )),
          ],
          backgroundColor: Config.fondo,
          title: Text("Politica de Privacidad",
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
                 margin: new EdgeInsets.only(bottom: 0.0,top: 0.0, left: 10.0, right: 10.0),

                child: Html(
                    data: descripcion,
                    style: {"span": Style(
                      backgroundColor: Colors.black,
                    )}
                ),
              ),
              Container(
                  margin: new EdgeInsets.only(bottom: 20.0,top: 5.0, left: 20.0, right: 20.0),
                  child: new
                TextButton(
                  onPressed: _sendingMails,
                  child: Row( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.mail_outline, color: Config.mail,),
                      Text("_____________@____.com", style: TextStyle(color: Config.mail), )
                    ],
                  ),
                ),
              ),
              ]),
        )
    );
  }

}