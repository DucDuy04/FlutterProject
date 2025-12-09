import 'package:flutter/material.dart';
import 'package:flutter_nhom6/bookhotelroom.dart';
import 'package:flutter_nhom6/changecolorapp.dart';
import 'package:flutter_nhom6/classroom.dart';
import 'package:flutter_nhom6/count_down.dart';
import 'package:flutter_nhom6/form_dang_ki.dart';
import 'package:flutter_nhom6/listplaceeasy.dart';
import 'package:flutter_nhom6/counter_app.dart';
import 'package:flutter_nhom6/form_dang_nhap.dart';
import 'package:flutter_nhom6/my_product.dart';
import 'package:flutter_nhom6/myhomepage.dart';
import 'package:flutter_nhom6/myplace.dart';

// void main() {
//   runApp(MyApp());
// }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       // home: MyProduct(),
// //       initialRoute: '/',

// //       // Định nghĩa tất cả các routes
// //       routes: {
// //         '/': (context) => MyProduct(),
// //         '/detail': (context) => DetailScreen(),
// //       },
// //     );
// //   }
// // }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // home: MyProduct(),
//       initialRoute: '/',

//       // Định nghĩa tất cả các routes
//       routes: {
//         '/': (context) => FormDangNhap(),
//         // '/detail': (context) => MyUser(),
//       },
//     );
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent, //loại bỏ hiệu ứng splash
        highlightColor: Colors.transparent, //loại bỏ hiệu ứng nhấn nút
      ),
      child: MaterialApp(
        title: 'Danh sách bài tập Flutter Nhóm 6',
        // theme: ThemeData(primarySwatch: Colors.red),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Danh sách các widget - mỗi widget là 1 "bài tập"
  final List<Widget> _pages = [
    CounterApp(),
    CountDownApp(),
    ClassRoom(),
    ChangeColorApp(),
    ListPlaceEasy(),
    BookHotelRoom(),
    MyHomePage(),
    FormDangNhap(),
    FormDangKi(),
    MyProduct(),
    MyPlace(),
  ];

  // Tiêu đề ứng với từng page
  final List<String> _titles = [
    'Counter App',
    'Count Down',
    'Class Room',
    'Change Color App',
    'List Place Easy',
    'Book Hotel Room',
    'My Home Page',
    'Form Đăng Nhập',
    'Form Đăng Kí',
    'My Product',
    'My Place',
  ];

  int _selectedIndex = 0;

  void _selectIndex(int index) {
    setState(() => _selectedIndex = index);
    // đóng Drawer
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Lê Đức Duy:22T1020585',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: _titles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      selected: index == _selectedIndex,
                      leading: Text('${index + 1}'),
                      title: Text(_titles[index]),
                      onTap: () => _selectIndex(index),
                    );
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Về đầu'),
                onTap: () {
                  _selectIndex(0);
                },
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
