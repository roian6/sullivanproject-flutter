import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<StatefulWidget> {
  // 낮에는 최고소음이 55, 밤에는 최고소음이 50
  final int maxDecibel = 50;
  int currentDecibel = 37;

  double currentDecibelPercent() {
    if(maxDecibel <= currentDecibel) {
      return 1;
    } else {
      return (currentDecibel / maxDecibel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설리번프로젝트"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: FAProgressBar(
              direction: Axis.vertical,
              currentValue: currentDecibel,
              maxValue: maxDecibel,
              borderRadius: 0,
              verticalDirection: VerticalDirection.up,
              progressColor: Colors.blue,
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                    value: currentDecibelPercent(),
                    strokeWidth: 12,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              Text("$currentDecibel" + "db", style: TextStyle(fontSize: 30)),
            ],
          )
        ],
      )
    );
  }
}