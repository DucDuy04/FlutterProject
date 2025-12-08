import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }

  Widget myBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Xin chào các bạn",
            style: TextStyle(
              color: const Color.fromARGB(255, 3, 69, 184),
              fontSize: 100,
            ),
          ),
        ),
        Icon(Icons.thumb_up, size: 70, color: Colors.red),
        Text(
          "Lớp LTDĐ Nhóm 6",
          style: TextStyle(
            color: Color.fromARGB(255, 3, 69, 184),
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
