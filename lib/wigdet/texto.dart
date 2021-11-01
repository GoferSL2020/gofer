import 'package:flutter/cupertino.dart';

class Texto extends StatelessWidget {
  final Color _color;
  final String _texto;
  final double _size;
  final Color _colorFondo;
  final bool  _italic;


  Texto(this._color, this._texto, this._size, this._colorFondo, this._italic);

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(color: _colorFondo,
            padding: EdgeInsets.all(5),
            child:new Text( _texto,
              style:new TextStyle(fontStyle:this._italic==true?FontStyle.italic:null, color: _color,fontWeight: FontWeight.bold, fontSize: _size), textAlign: TextAlign.center,),),
        ]);
  }
}