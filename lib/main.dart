import 'package:flutter/material.dart';
import 'package:flutter_nhom6/bookhotelroom.dart';
import 'package:flutter_nhom6/changecolorapp.dart';
import 'package:flutter_nhom6/classroom.dart';
import 'package:flutter_nhom6/count_down.dart';
import 'package:flutter_nhom6/form_dang_ki.dart';
import 'package:flutter_nhom6/listplaceeasy.dart';
import 'package:flutter_nhom6/counter_app.dart';
import 'package:flutter_nhom6/form_dang_nhap.dart';
import 'package:flutter_nhom6/form_dang_ki.dart';
import 'package:flutter_nhom6/my_product.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // home: MyProduct(),
//       initialRoute: '/',

//       // Định nghĩa tất cả các routes
//       routes: {
//         '/': (context) => MyProduct(),
//         '/detail': (context) => DetailScreen(),
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MyProduct(),
      initialRoute: '/',

      // Định nghĩa tất cả các routes
      routes: {
        '/': (context) => FormDangNhap(),
        '/detail': (context) => ProfilePage(),
      },
    );
  }
}
