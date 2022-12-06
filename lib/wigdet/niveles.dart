

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';
import 'package:iafootfeel/locale/app_localization.dart';
import 'package:iafootfeel/wigdet/texto.dart';

import '../conf/config.dart';


class Niveles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Niveles();
  }

}

class _Niveles extends State<Niveles> {

  int letrasAux=Config.letrasPalabra;

Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      padding: EdgeInsets.all(10),

    child: Column(

      children:[
        Container(
          child:Texto(Colors.white, AppLocalization.of(context).nivel, 10, Config.colorAPP,false),
        ),Container(height: 5,
        ),
     /* Row(
          children:
          [
            Icon(Icons.volume_up, color: Config.colorAPP,),
            _volume(),
          ]
      ),
        Row(
            children:
            [
              Icon(Icons.tune_sharp, color: Config.colorAPP,),
              _pitch(),
            ]
        ),
        Row(
            children:
            [
              Icon(Icons.speed_outlined, color: Config.colorAPP,),
              _rate(),
            ]
        ),*/

        CupertinoSegmentedControl(
           /*borderColor: Config.colorAPP,
           pressedColor: Colors.red,
           selectedColor: Colors.black,
           unselectedColor: Colors.grey,*/
            groupValue: letrasAux,

            children:  <int, Widget>{
              3: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3")),
              4: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("4")),
              5: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("5")),
              6: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("6")),
              7: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("7")),
              8: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("8")),
              9: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("9")),
              10: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("10")),
              30: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Max",style: TextStyle(fontSize: 9),)),

            },
            onValueChanged: (value) {
                setState(() {
                  letrasAux=value;
                  Config.letrasPalabra = value;
                });
                // TODO: - fix it
              ;}),
        Container(height: 2,
        ),
        Container(
          child:Texto(Colors.black, "Nivel (${AppLocalization.of(context).letras}}", 10, Colors.white,false),
        )

    ])
    );
  }



Widget _volume() {
  return  SliderTheme(
    data: SliderTheme.of(context).copyWith(
      activeTrackColor: Config.colorAPP,
      inactiveTrackColor: Config.colorAPP,
      trackHeight: 1.0,
      thumbColor: Config.colorAPP,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: Colors.purple.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
    ),
    child:Slider(
        value: Config.volume,
        onChanged: (newVolume) {
          setState(() => Config.volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: ${Config.volume}"
    ),
  );
}

Widget _pitch() {
  return SliderTheme(
    data: SliderTheme.of(context).copyWith(
      activeTrackColor: Config.colorAPP,
      inactiveTrackColor: Config.colorAPP,
      trackHeight: 1.0,
      thumbColor: Config.colorAPP,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: Colors.purple.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
    ),
    child: Slider(

      value: Config.pitch,
      onChanged: (newPitch) {
        setState(() => Config.pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: ${Config.pitch}",
      activeColor: Config.colorAPP,
    ),
  );

}
Widget _rate() {
  return SliderTheme(
    data: SliderTheme.of(context).copyWith(
      activeTrackColor: Config.colorAPP,
      inactiveTrackColor: Config.colorAPP,
      trackHeight: 0.5,
      thumbColor: Config.colorAPP,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      overlayColor: Colors.purple.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
    ),
    child:Slider(
      value: Config.rate,
      onChanged: (newRate) {
        setState(() => Config.rate = newRate);
      },
      min: 0.0,
      max: 0.5,
      divisions: 2,
      label: "Rate: ${Config.rate}",
      activeColor: Config.colorAPP,
    ),
  );
}




}




