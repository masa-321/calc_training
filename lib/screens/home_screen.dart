import 'package:calc_training/screens/test_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget { //産みの親の方
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<DropdownMenuItem<int>> _menuItems = List();
  int _numberOfQuestions = 0; //nullを回避するために、数字を入れておいた方が良い。

  @override
  void initState() {
    super.initState();
    setMenuItems();
    _numberOfQuestions = _menuItems[0].value; //value属性にない値を入れるとエラーになる。
  }

  void setMenuItems() {
    //以下のように記載することもできる
    //cascade notation
    _menuItems
      ..add(DropdownMenuItem(value: 10, child: Text(10.toString()),))
      ..add(DropdownMenuItem(value: 20, child: Text(20.toString()),))
      ..add(DropdownMenuItem(value: 30, child: Text(30.toString()),));
  }

  @override
  Widget build(BuildContext context) {
//    var screenWidth = MediaQuery.of(context).size.width;
//    var screenHeight = MediaQuery.of(context).size.height;
//    print("ヨコ幅の論理ピクセル：$screenWidth");
//    print("タテ幅の論理ピクセル：$screenHeight");
    
    return Scaffold(
     body:SafeArea(
       child: Center(
         child: Column(
           children: <Widget>[
             Image.asset("assets/images/image_title.png"), //このカンマはリストの区切りのカンマ
             const SizedBox(height: 50.0,),
             const Text(
                 "問題数を選択して「スタート」ボタンを押してください",
                  style: TextStyle(fontSize: 12.0),
             ),
             const SizedBox(height: 75.0,),
             DropdownButton(
                value: _numberOfQuestions,
                onChanged: (selectedValue){
                  setState(() {
                    _numberOfQuestions = selectedValue;
                  });
                },
                items: _menuItems,
             ),
             Expanded(
               child: Container(
                 alignment: Alignment.bottomCenter, //特定の位置に配置したい場合alignmentが使える。
                 padding: EdgeInsets.only(bottom: 12.0),//下に隙間を少し欲しいケース
                 child: RaisedButton.icon(
                   color: Colors.brown,
                   onPressed: () => startTestScreen(context),
                   label: Text("スタート"),
                   icon: Icon(Icons.skip_next),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10.0))
                   ),
                 ),
               ),
             )
           ],
         ),
       ),
       )
    );
  }

  startTestScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestScreen(numberOfQuestions: _numberOfQuestions)));
  }
}
