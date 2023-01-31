import 'package:flutter/cupertino.dart';

class TextoExpanded extends StatelessWidget {
  final Color _color;
  final String _TextoExpanded;
  final double _size;
  final Color _colorFondo;
  final bool  _italic;


  TextoExpanded(this._color, this._TextoExpanded, this._size, this._colorFondo, this._italic);

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:new Text( _TextoExpanded,softWrap: true,
              style:new TextStyle(fontStyle:this._italic==true?FontStyle.italic:null,
                  color: _color, fontSize: _size, fontWeight: FontWeight.bold),
             textAlign: TextAlign.center,),),
        ]);
  }
}