import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:iadvancedscout/model/jugador.dart';


/// SheetController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class SheetController {
  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbw5j_qaOtMYpAPJXhmEKWAclpnuqd71fhG7lXJ44RSqzphRg-1f/exec";
  //static const String URL =
    //  "https://script.google.com/macros/s/AKfycbw6KaeSS2vVu7-RZB1twWb48P2dmB_RCHQQc9yl9BXoqUUNCNk/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";
  List<Jugador> listJugadores=new List();
  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      Jugador jugador, void Function(String) callback)  {
    try {
      //print("SUB:${jugador.jugador}");
      //print("SUB:${jugador.toJson()}");
       http.post(URL, body: jugador.toJson()).then((response)  {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
           http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      //print(e);
    }
  }


}
