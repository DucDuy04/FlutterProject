import 'dart:math';

import 'package:flutter/material.dart';

class FormDangNhap extends StatefulWidget {
  FormDangNhap({super.key});

  @override
  State<FormDangNhap> createState() => _FormDangNhapState();
}

class _FormDangNhapState extends State<FormDangNhap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Đăng Nhập"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 25, 110, 239),
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Column(children: [Expanded(child: _buildForm())]);
  }

  final _formKey = GlobalKey<FormState>();
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên đăng nhập';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (value.length < 6) {
                  return 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //điều hướng sang đường dẫn khác
                  Navigator.pushNamed(context, '/detail');
                  // if (_formKey.currentState!.validate()) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Đăng nhập thành công')),
                  //   );
                  // }
                },
                child: Text('Đăng Nhập'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: Center(child: Text('Welcome to the Profile Page!')),
    );
  }
}
