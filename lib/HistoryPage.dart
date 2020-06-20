import 'package:flutter/material.dart';
import 'package:flutterapp/RealmUtil.dart';
import 'package:flutterapp/SoundData.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<StatefulWidget> {
  List<SoundData> history;

  @override
  void initState() {
    RealmUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("층간소음 녹음내역")),
      body: generateRows(),
    );
  }

  /// 헤더가 있는 리스트뷰를 만든다. */
  Widget generateRows() {
    return Column(
      children: <Widget>[
        generateRow(-1),
        Expanded(
            child: ListView.builder(
              itemCount: 30,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) => generateRow(index),
            ))
      ],
    );
  }

  /// 한 줄에 보여줄 데이터를 만든다. */
  Widget generateRow(int index) {
    if (index == -1)
      return Row(children: <Widget>[
        generateBorderText('시간'),
        generateBorderText('평균 데시벨'),
        generateBorderText('피크 데시벨')
      ]);
    else
      return Row(children: <Widget>[
        generateBorderText('20.02.03 12:34'),
        generateBorderText('3.14 db'),
        generateBorderText('53.45 db')
      ]);
  }

  /// 스타일링된 텍스트뷰를 반환한다. */
  Widget generateBorderText(String text) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Text(text),
    );
  }
}
