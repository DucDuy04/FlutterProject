import 'dart:math';

import 'package:flutter/material.dart';

class ChangeColorApp extends StatefulWidget {
  ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}

class _ChangeColorAppState extends State<ChangeColorApp> {
  Color bgColor = Colors.yellow;
  String bgColorName = "Vàng";
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.lime,
  ];
  List<String> colorNameList = [
    "Đỏ",
    "Xanh lá",
    "Xanh dương",
    "Vàng",
    "Cam",
    "Tím",
    "Hồng",
    "Nâu",
    "Xanh nước biển",
    "Chanh",
  ];

  void _changeColor() {
    var rand = Random();
    var i = rand.nextInt(colorList.length);
    setState(() {
      bgColor = colorList[i];
      bgColorName = colorNameList[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent, //loại bỏ hiệu ứng splash
        highlightColor: Colors.transparent, //loại bỏ hiệu ứng nhấn nút
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Color App"),
          backgroundColor: Colors.blue,
        ),
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    // return Column(children: [Expanded(child: block2())]);
    return block2();
  }

  // Widget block1() {
  Widget block2() {
    return Container(
      decoration: BoxDecoration(color: bgColor),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Màu hiện tại"),
          Text(bgColorName, style: TextStyle(fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _changeColor();
                },
                child: Text("Đổi màu nền"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    bgColor = Colors.yellow;
                    bgColorName = "Vàng";
                  });
                },
                child: Text("Mặc định"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
