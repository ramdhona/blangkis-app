import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/products_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(BlangkisApp());
}

class BlangkisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blangkis',
      theme: ThemeData(
        primaryColor: Color(0xFF114D91),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/products': (context) => ProductsScreen(),
        '/payment': (context) => PaymentScreen(
            totalPrice: 0.0), // Ganti dari totalHarga menjadi totalPriice
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
