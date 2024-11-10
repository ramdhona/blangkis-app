import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel state untuk mengatur visibilitas password
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn(); // Cek apakah user sudah login
  }

  // Fungsi untuk mengecek apakah user sudah login sebelumnya
  _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Memastikan data yang terbaru dimuat sebelum berpindah ke Dashboard
      String? savedUsername = prefs.getString('username');
      String? savedPassword = prefs.getString('password');

      // Update validasi untuk mencocokkan username dan password
      if (_usernameController.text == savedUsername &&
          _passwordController.text == savedPassword) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Tampilkan pesan error jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Username atau password salah")),
        );
      }
    }
  }

  // Fungsi login
  _login() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ambil data terbaru dari SharedPreferences
      String? savedUsername = prefs.getString('username');
      String? savedPassword = prefs.getString('password');

      // Debugging: Cek apakah username dan password sudah benar
      print("Username yang tersimpan: $savedUsername");
      print("Password yang tersimpan: $savedPassword");

      // Cek apakah username dan password sesuai dengan yang tersimpan
      if (_usernameController.text == savedUsername &&
          _passwordController.text == savedPassword) {
        // Simpan status login ke SharedPreferences
        await prefs.setBool('isLoggedIn', true);
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Tampilkan pesan error jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username atau password salah"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF114D91),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Silahkan Masuk",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Input Username
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Username wajib diisi'
                          : null,
                    ),
                    SizedBox(height: 16),
                    // Input Password dengan Show/Hide Icon
                    TextFormField(
                      controller: _passwordController,
                      obscureText:
                          _obscurePassword, // Mengatur visibilitas password
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Password wajib diisi'
                          : null,
                    ),
                    SizedBox(height: 20),
                    // Button Login
                    ElevatedButton(
                      onPressed: _login,
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Color(0xFF114D91),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Button Register
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text("Belum punya akun? Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
