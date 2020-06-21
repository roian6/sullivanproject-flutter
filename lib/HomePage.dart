import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutterapp/HistoryPage.dart';
import 'package:flutterapp/SoundClip.dart';
import 'package:noise_meter/noise_meter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<StatefulWidget> {
  NoiseMeter noiseMeter = new NoiseMeter();
  StreamSubscription<NoiseReading> subscription;
  SoundClip clip = new SoundClip();

  final int limitDecibel = 100;
  int currentDecibel = 0;

  @override
  void initState() {
    super.initState();
    this.subscription = noiseMeter.noiseStream.listen(this.onData);
  }

  @override
  void onData(NoiseReading sound) {
    setState(() {
      var decibel = sound.maxDecibel.toInt();
      this.currentDecibel = decibel;
      this.clip.addSound(decibel);
    });
  }

  bool isSafeDecibel() {
    return currentDecibel < limitDecibel;
  }

  // 0.0 ~ 1.0 사이의 숫자가 반환됩니다.
  double currentDecibelPercent() {
    if (currentDecibel > limitDecibel) {
      return 1;
    } else {
      return currentDecibel / limitDecibel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("설리번프로젝트"), actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.search),
          highlightColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HistoryPage(),
              ),
            );
          },
        ),
      ]),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: FAProgressBar(
              direction: Axis.vertical,
              currentValue: currentDecibel,
              maxValue: limitDecibel,
              borderRadius: 0,
              verticalDirection: VerticalDirection.up,
              progressColor: isSafeDecibel() ? Colors.blue : Colors.red,
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
                  valueColor: AlwaysStoppedAnimation(
                      isSafeDecibel() ? Colors.blue : Colors.red),
                ),
              ),
              Text("$currentDecibel db", style: TextStyle(fontSize: 30)),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          if (clip.isRecoding)
            {print(clip.finishRecoding().maxDecibel)}
          else
            {clip.startRecoding()}
        },
        child: clip.isRecoding ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
    );
  }
}
