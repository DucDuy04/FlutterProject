import 'package:flutter/material.dart';
import 'package:flutter_nhom6/api_profile.dart';
import 'package:flutter_nhom6/model/user.dart';

class FormDangNhap extends StatefulWidget {
  FormDangNhap({super.key});

  @override
  State<FormDangNhap> createState() => _FormDangNhapState();
}

class _FormDangNhapState extends State<FormDangNhap> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? _currentUser;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final loginResult = await test_api.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (loginResult != null) {
        final user = await test_api.getMyProfile();

        if (user != null) {
          setState(() {
            _currentUser = user;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sai tên đăng nhập hoặc mật khẩu')),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentUser == null ? "Đăng Nhập" : "Thông tin cá nhân"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 25, 110, 239),
      ),
      body: _currentUser == null ? _buildLoginForm() : _buildUserProfile(),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Container(
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Tên đăng nhập',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
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
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 25, 110, 239),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Đăng Nhập',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Thử: emilys / emilyspass',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile() {
    final u = _currentUser!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue[100],
            child: Text(
              '${u.firstName[0]}${u.lastName[0]}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
          SizedBox(height: 24),

          Text(
            '${u.firstName} ${u.lastName}',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 20, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                '@${u.username}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
          SizedBox(height: 24),

          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(Icons.email, 'Email', u.email),
                  Divider(),
                  _buildInfoRow(
                    u.gender == 'male' ? Icons.male : Icons.female,
                    'Giới tính',
                    u.gender == 'male' ? 'Nam' : 'Nữ',
                  ),
                  Divider(),
                  _buildInfoRow(Icons.cake, 'Tuổi', '${u.age} tuổi'),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          // Card thông tin liên hệ
          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.phone,
                    'Số điện thoại',
                    u.phone.isNotEmpty ? u.phone : 'Chưa cập nhật',
                  ),
                  Divider(),
                  _buildInfoRow(
                    Icons.home,
                    'Địa chỉ',
                    u.address.address.isNotEmpty
                        ? u.address.address
                        : 'Chưa cập nhật',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Card thông tin công ty
          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.business,
                    'Công ty',
                    u.company.name.isNotEmpty
                        ? u.company.name
                        : 'Chưa cập nhật',
                  ),
                  Divider(),
                  _buildInfoRow(
                    Icons.work,
                    'Ngành nghề',
                    u.company.department.isNotEmpty
                        ? u.company.department
                        : 'Chưa cập nhật',
                  ),
                  Divider(),
                  _buildInfoRow(
                    Icons.location_city,
                    'Chức vụ',
                    u.company.title.isNotEmpty
                        ? u.company.title
                        : 'Chưa cập nhật',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Nút đăng xuất
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _currentUser = null;
                  _usernameController.clear();
                  _passwordController.clear();
                });
              },
              child: Text('Đăng xuất', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700]),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
