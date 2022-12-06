import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iafootfeel/conf/config.dart';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {

  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle =  TextStyle(fontSize:25.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = new Dependencies();

  void leftButtonPressed() {
    setState(() {
        dependencies.stopwatch.reset();
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  Widget play(String text, VoidCallback callback) {
    return IconButton(
        icon: Icon(dependencies.stopwatch.isRunning ?Icons.play_circle_outline:Icons.stop_circle_outlined),
        tooltip: 'Increase volume by 10',
        iconSize: 25,
        onPressed: callback
      );
  }


  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: Config.fondo),
          alignment: Alignment.center,
          /*decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.white, Colors.lightBlueAccent],
                              begin: FractionalOffset(0.1, 0.0),
                              end: FractionalOffset(1.0, 0.6),
                              stops: [0.1, 0.6],
                              tileMode: TileMode.mirror)),*/
          child:Container(width: 250  ,
              padding: const EdgeInsets.only(left: 0.0, top:  0.0),
              child: new Table(
                  defaultVerticalAlignment:
                  TableCellVerticalAlignment.middle,
                  //border: TableBorder.all(),
                   children: [
                    TableRow(
                        children: [
                            new TimerText(dependencies: dependencies),
                            IconButton(
                            icon: Icon(Icons.loop_outlined),
                            tooltip: 'Increase volume by 10',
                            iconSize: 25,
                            onPressed: () {
                            setState(() {leftButtonPressed();
                            });
                            },
                            ),
                            IconButton(
                            icon: Icon(!dependencies.stopwatch.isRunning ?Icons.play_circle_outline:Icons.stop_circle_outlined),
                            tooltip: 'Increase volume by 10',
                            iconSize: 25,
                            onPressed: () {
                            setState(() {rightButtonPressed();});
                            }
                            ),
                      ]),
                  ]),),),
          ]);
        }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() => new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          new RepaintBoundary(
            child: new SizedBox(
              height: 30.0,
              child: new MinutesAndSeconds(dependencies: dependencies),
            ),
          ),

      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() => new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr', style: dependencies.textStyle);
  }

}
