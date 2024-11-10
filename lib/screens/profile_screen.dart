import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaLengkapController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fungsi untuk memuat data user dari SharedPreferences
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? namaLengkap = prefs.getString('namaLengkap');

    setState(() {
      _usernameController.text = username ?? '';
      _namaLengkapController.text = namaLengkap ?? '';
    });
  }

  // Fungsi untuk menyimpan perubahan data user
  _saveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = _usernameController.text;
    String namaLengkap = _namaLengkapController.text;

    if (username.isNotEmpty && namaLengkap.isNotEmpty) {
      bool usernameSaved = await prefs.setString('username', username);
      bool namaLengkapSaved = await prefs.setString('namaLengkap', namaLengkap);

      if (usernameSaved && namaLengkapSaved) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data berhasil diupdate")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan data")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field harus diisi")),
      );
    }
  }

  // Fungsi untuk mengubah password baru
  _changePassword() async {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedPassword = prefs.getString('password');
      if (_oldPasswordController.text == savedPassword) {
        bool passwordSaved =
            await prefs.setString('password', _newPasswordController.text);

        if (passwordSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password berhasil diubah")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Gagal menyimpan password baru")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password lama salah")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password baru dan konfirmasi tidak cocok")),
      );
    }
  }

  _updateData() async {
    await _saveChanges();
    if (_newPasswordController.text.isNotEmpty) {
      await _changePassword();
    }
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _togglePasswordVisibility(int field) {
    setState(() {
      if (field == 1) {
        _obscureOldPassword = !_obscureOldPassword;
      } else if (field == 2) {
        _obscureNewPassword = !_obscureNewPassword;
      } else if (field == 3) {
        _obscureConfirmPassword = !_obscureConfirmPassword;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFF114D91),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 8),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _namaLengkapController,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _oldPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Password Lama',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureOldPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => _togglePasswordVisibility(1),
                      ),
                    ),
                    obscureText: _obscureOldPassword,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Password Baru',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => _togglePasswordVisibility(2),
                      ),
                    ),
                    obscureText: _obscureNewPassword,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password Baru',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => _togglePasswordVisibility(3),
                      ),
                    ),
                    obscureText: _obscureConfirmPassword,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Update Data dengan ukuran lebih besar
                      SizedBox(
                        width: 150, // Mengatur lebar tombol
                        height: 50, // Mengatur tinggi tombol
                        child: ElevatedButton(
                          onPressed: _updateData,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    12), // Mengatur padding untuk memperbesar tombol
                            textStyle: TextStyle(
                                fontSize:
                                    18), // Mengatur ukuran teks lebih besar
                          ),
                          child: Text('Update Data'),
                        ),
                      ),
                      // Tombol Logout dengan ukuran lebih besar
                      SizedBox(
                        width: 150, // Mengatur lebar tombol
                        height: 50, // Mengatur tinggi tombol
                        child: ElevatedButton(
                          onPressed: _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    12), // Mengatur padding untuk memperbesar tombol
                            textStyle: TextStyle(
                                fontSize:
                                    18), // Mengatur ukuran teks lebih besar
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (index == 1) Navigator.pushReplacementNamed(context, '/products');
          if (index == 2) Navigator.pushReplacementNamed(context, '/profile');
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Produk"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
