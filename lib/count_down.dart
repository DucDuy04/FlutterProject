import 'dart:async';

import 'package:flutter/material.dart';

class CountDownApp extends StatefulWidget {
  CountDownApp({super.key});

  @override
  State<CountDownApp> createState() => _CountDownAppState();
}

class _CountDownAppState extends State<CountDownApp> {
  int _counter = 10;
  final TextEditingController _controller = TextEditingController();

  Timer? _timer;

  int _initial = 10;

  void _startCountDown() {
    if (_counter <= 0) {
      _counter = _initial;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        t.cancel();
        _timer = null;
      }
    });
  }

  void _togglePause() {
    setState(() {
      if (_timer != null && _timer!.isActive) {
        _timer?.cancel();
        _timer = null;
      } else {
        _startCountDown();
      }
    });
  }

  void _resetCounter() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _counter = _initial;
    });
  }

  void _applyInput() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final value = int.tryParse(text);
    if (value == null || value < 0) return;
    setState(() {
      _initial = value;
      _counter = value;
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final mStr = minutes.toString().padLeft(2, '0');
    final sStr = seconds.toString().padLeft(2, '0');
    return '$mStr:$sStr';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bộ đếm thời gian"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [block1()]),
        ),
      ),
    );
  }

  Widget block1() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nhập số giây cần đếm ngược"),
          SizedBox(height: 12),
          SizedBox(
            width: 320,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nhập số giây',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: _applyInput, child: Text('Áp dụng')),
              ],
            ),
          ),

          SizedBox(height: 20),

          Text(
            _formatTime(_counter),
            style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _counter == 0 ? null : _togglePause,
                child: Text(
                  _timer != null && _timer!.isActive ? 'Pause' : 'Start',
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(onPressed: _resetCounter, child: Text('Reset')),
            ],
          ),
        ],
      ),
    );
  }
}
