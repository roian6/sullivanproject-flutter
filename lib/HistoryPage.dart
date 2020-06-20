import 'package:flutter/material.dart';
import 'package:flutterapp/SoundData.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<StatefulWidget> {
  List<SoundData> history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("층간소음 녹음내역")),
      body: ListView(),
    );
  }

  List<Widget> listItems() {
    return history.map((item) => {
      Row(
        children: <Widget>[
          Text(""),
          Text(""),
        ],
      )

    });
  }
}