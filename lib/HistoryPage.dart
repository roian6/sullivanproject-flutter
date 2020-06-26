import 'package:flutter/material.dart';
import 'package:flutterapp/SoundData.dart';
import 'package:flutterapp/SqliteUtil.dart';
import 'package:sqflite/sqflite.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<StatefulWidget> {
  List<SoundData> history;
  Database dataBase;

  @override
  void initState() {
    SqliteUtil.getSoundData().then((value) => this.afterAction(value));
  }

  /// 데이터를 받아온 후의 행동을 정의한다.
  void afterAction(List<SoundData> value) {
    setState(() {
      history = value;
    });

    // print(value.length);
    // value.forEach((element) {
    //   print("sId : ${element.sId}\n");
    //   print("averageDecibel : ${element.averageDecibel}\n");
    //   print("maxDecibel : ${element.maxDecibel}\n");
    //   print("date : ${element.date}\n");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("층간소음 녹음내역")),
      body: generateBody(),
    );
  }

  /// 헤더가 있는 리스트뷰를 만든다. */
  Widget generateBody() {
    if (history != null)
      return Column(
        children: <Widget>[
          generateRow(-1),
          Expanded(
              child: ListView.builder(
            itemCount: history.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => generateRow(index),
          ))
        ],
      );
    else
      Center(child: CircularProgressIndicator());
  }

  /// 한 줄에 보여줄 데이터를 만든다. */
  Widget generateRow(int index) {
    if (index == -1)
      return Row(children: <Widget>[
        generateBorderText(1, '시간 '),
        generateBorderText(2, '평균 데시벨'),
        generateBorderText(3, '피크 데시벨')
      ]);
    else
      return Row(children: <Widget>[
        generateBorderText(1, history[index].date),
        generateBorderText(2, "${history[index].averageDecibel}"),
        generateBorderText(3, "${history[index].maxDecibel}")
      ]);
  }

  /// 스타일링된 텍스트뷰를 반환한다. */
  Widget generateBorderText(int type, String text) {
    double ratio;
    switch (type) {
      case 1:
        ratio = 0.5;
        break;
      case 2:
        ratio = 0.25;
        break;
      default:
        ratio = 0.25;
        break;
    }

    return Container(
      width: MediaQuery.of(context).size.width * ratio,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
