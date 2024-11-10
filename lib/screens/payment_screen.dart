import 'package:flutter/material.dart';
import 'products_screen.dart';

class PaymentScreen extends StatelessWidget {
  final double totalPrice;

  PaymentScreen({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    TextEditingController cashController = TextEditingController();
    TextEditingController changeController = TextEditingController();

    // Fungsi untuk memformat angka menjadi format Rupiah
    String formatCurrency(double amount) {
      return "Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.")}";
    }

    // Fungsi untuk memproses input jumlah bayar dan kembalian
    void _calculateChange(String value) {
      // Hapus karakter non-digit dan ubah ke double
      String sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
      double cash = double.tryParse(sanitizedValue) ?? 0;
      double change = cash - totalPrice;

      // Update cashController dengan format mata uang
      cashController.value = TextEditingValue(
        text: formatCurrency(cash.toDouble()),
        selection: TextSelection.collapsed(
            offset: formatCurrency(cash.toDouble()).length),
      );

      // Update kembalian
      changeController.text = formatCurrency(change);
    }

    return Scaffold(
      body: Column(
        children: [
          // Header dengan ikon back dan judul
          Container(
            padding: EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 16),
            color: Color(0xFF114D91),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "Pembayaran",
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
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Harga:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatCurrency(totalPrice),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Jumlah Bayar:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: cashController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan jumlah bayar',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: _calculateChange,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Kembalian:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: changeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Kembalian',
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: Text("Kembali ke Home"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
