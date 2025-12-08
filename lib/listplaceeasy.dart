import 'dart:math';

import 'package:flutter/material.dart';

class ListPlaceEasy extends StatelessWidget {
  ListPlaceEasy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: myBody()));
  }

  Widget myBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          header(),
          SizedBox(height: 10),
          titleSection(),
          search(),
          SizedBox(height: 10),
          titlePlace(),
          Expanded(child: placeList()),
        ],
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        IconButton(onPressed: () {}, icon: Icon(Icons.extension)),
      ],
    );
  }

  Widget titleSection() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Welcome!,\n",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Charlie",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 62, 61, 61),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget titlePlace() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Save Places",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget placeList() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10, // khoảng cách ngang giữa các ô
      mainAxisSpacing: 10, // khoảng cách dọc giữa các ô
      childAspectRatio: 1.5,

      children: List.generate(4, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/${index + 1}.jpg'),
        );
      }),
    );
  }
}
