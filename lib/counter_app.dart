import 'dart:math';

import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;
  void _plusCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  void _minusCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  Color _randomColor() {
    var rand = Random();
    return Color.fromARGB(
      255,
      rand.nextInt(256),
      rand.nextInt(256),
      rand.nextInt(256),
    );
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
          title: Text("Ứng dụng đếm số"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: myBody(),
      ),
    );
  }

  // Widget myBody() {
  Widget myBody() {
    return block1();
  }

  Widget block1() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Giá trị hiện tại"),
          Text(
            "$_counter",
            style: TextStyle(fontSize: 30, color: _randomColor()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _minusCounter();
                  });
                },
                child: Text("Giảm"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _resetCounter();
                  });
                },
                child: Text("Đặt lại"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _plusCounter();
                  });
                },
                child: Text("Tăng"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
