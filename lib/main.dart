import 'package:calc_training/screens/home_screen.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "シンプル過ぎる計算脳トレ",
      home: HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}
