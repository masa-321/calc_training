import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';

class TestScreen extends StatefulWidget {
  final numberOfQuestions;

  TestScreen({@required this.numberOfQuestions});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int numberOfRemaining =
      0; //varではなく、intにする。変数は名前をつける場所によって使える範囲が変わる。今回はクラス直下。どこでも使える。
  int numberOfCorrect = 0;
  int correctRate = 0;

  int questionLeft = 0;
  int questionRight = 0;
  String operator = "-";
  String answerString = "100";

  int soundIdCorrect = 0;
  int soundIdInCorrect = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //問題スタート時に、正答数と正答率を0から開始したい。そのための前準備
    numberOfCorrect = 0;
    correctRate = 0;
    numberOfRemaining = widget.numberOfQuestions;

    //TODO 効果音を鳴らす
    _initSounds();

    //問題を作るメソッド
    setQuestion();
  }

  //メモリのロードは非同期処理で行う。
  //上のinitStateは非同期処理にしてはいけない。
  _initSounds() async{
    try{
      //②soundpoolクラスのインスタンス作成
      _soundpool = Soundpool(); //initStateの外でも良い？
      _soundIds[0] = await loadSound("assets/sounds/sound_correct.mp3");

    } on IOException catch(error){
      print("エラーの内容は：$error")
    }
  }

  Future<void> loadSound(String SoundPath){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                //スコア表示部分
                _scorePart(),
                //問題表示部分
                _questionPart(),
                //電卓ボタン部分
                _calcButtons(),
                //答え合わせボタン
                _answerCheckButton(),
                //戻るボタン
                _backButton(),
              ],
            ),
            _correctIncorrectImage(), //上に重ねたいものは、コード上は下の方に記述する。
            _endMessage()
          ],
        ),
      ),
    );
  }

  //スコア表示部分
  Widget _scorePart() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Table(
        children: [
          TableRow(children: [
            Center(
                child: Text(
              "残りの問題数",
              style: TextStyle(fontSize: 10.0),
            )),
            Center(
                child: Text(
              "正解率",
              style: TextStyle(fontSize: 10.0),
            )),
            Center(
                child: Text(
              "正答率",
              style: TextStyle(fontSize: 10.0),
            )),
          ]),
          TableRow(children: [
            Center(
                child: Text(numberOfRemaining.toString(),
                    style: TextStyle(fontSize: 20.0))),
            Center(
                child: Text(numberOfCorrect.toString(),
                    style: TextStyle(fontSize: 20.0))),
            Center(
                child: Text(correctRate.toString(),
                    style: TextStyle(fontSize: 20.0))),
          ])
        ],
      ),
    );
  }

  //問題表示部分
  Widget _questionPart() {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 80.0, right: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Center(
                    child: Text(questionLeft.toString(),
                        style: TextStyle(fontSize: 36.0)))),
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(operator, style: TextStyle(fontSize: 30.0)))),
            Expanded(
                flex: 2,
                child: Center(
                    child: Text(questionRight.toString(),
                        style: TextStyle(fontSize: 36.0)))),
            Expanded(
                flex: 2,
                child:
                    Center(child: Text("=", style: TextStyle(fontSize: 30.0)))),
            Expanded(
                flex: 3,
                child: Center(
                    child:
                        Text(answerString, style: TextStyle(fontSize: 60.0)))),
          ],
        ));
  }

  //電卓ボタン部分
  Widget _calcButtons() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          children: [
            TableRow(
              children: [
                _calcButton("7"),
                _calcButton("8"),
                _calcButton("9"),
              ]
            ),
            TableRow(
                children: [
                  _calcButton("4"),
                  _calcButton("5"),
                  _calcButton("6"),
                ]
            ),
            TableRow(
                children: [
                  _calcButton("1"),
                  _calcButton("2"),
                  _calcButton("3"),
                ]
            ),
            TableRow(
                children: [
                  _calcButton("0"),
                  _calcButton("-"),
                  _calcButton("C"),
                ]
            )
          ],
        ),
      ),
    );
  }

  //答え合わせボタン
  Widget _answerCheckButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () => print("答え合わせ"), //TODO
          color: Colors.brown,
          child: Text(
            "答え合わせ",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  //戻るボタン
  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () => print("戻る"), //TODO
          color: Colors.grey,
          child: Text(
            "戻る",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _calcButton(String numString) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: Colors.brown,
        onPressed: () => print("$numString"), //TODO
        child: Text("$numString"),
      ),
    );
  }

  //TODO
  Widget _correctIncorrectImage() {
    return Image(
      image: AssetImage("assets/images/pic_correct.png"),
    );
  }

  //TODO
  Widget _endMessage() {
    return Text("テスト終了", style: TextStyle(fontSize: 30.0),);
  }


}
