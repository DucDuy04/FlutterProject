import 'dart:math';

import 'package:flutter/material.dart';

class ClassRoom extends StatelessWidget {
  ClassRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: myBody()));
  }

  // Widget myBody() {
  //   return Column(children: [block1(), block2(), block3(), block4()]);
  // }

  Widget myBody() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(10, (index) => block1()),
    );
  }

  Widget block1() {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: randomRGB(),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [leftChild(), rightChild()],
      ),
    );
  }

  Widget rightChild() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.more_horiz),
      padding: EdgeInsets.zero, //bỏ padding mặc định của iconbutton
      constraints: BoxConstraints(), //bỏ kích thước mặc định
    );
  }

  Widget leftChild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("XML và ứng dụng - Nhóm 1"),
            Text("2025-2026.1 TIN4583.001"),
          ],
        ),
        Text("58 học sinh"),
      ],
    );
  }

  var randomRGB = () {
    Random random = Random();
    var r = random.nextInt(256);
    var g = random.nextInt(256);
    var b = random.nextInt(256);
    return Color.fromRGBO(r, g, b, 1);
  };
}
