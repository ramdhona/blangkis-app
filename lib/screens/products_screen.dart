import 'package:flutter/material.dart';
import 'payment_screen.dart';
import 'product_description_screen.dart';
import 'dashboard_screen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  double totalHarga = 0.0;

  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/product1.jpg",
      "category": "Aksesoris",
      "name": "Blangkon",
      "price": 25500.0,
      "description":
          "Blangkon ini adalah simbol kebudayaan Indonesia yang terbuat dari bahan berkualitas tinggi. Didesain dengan motif tradisional yang memikat."
    },
    {
      "image": "assets/images/product2.jpg",
      "category": "Pakaian",
      "name": "Kemeja Batik",
      "price": 75750.0,
      "description":
          "Kemeja Batik ini menampilkan keindahan pola batik yang khas, menggambarkan kekayaan budaya Indonesia."
    },
    {
      "image": "assets/images/product3.jpg",
      "category": "Makanan",
      "name": "Keripik Tempe",
      "price": 18000.0,
      "description":
          "Keripik Tempe ini adalah camilan sehat yang tidak hanya lezat, tetapi juga bergizi."
    },
    {
      "image": "assets/images/product4.jpg",
      "category": "Aksesoris",
      "name": "Tas anyaman",
      "price": 23500.0,
      "description":
          "Tas anyaman ini adalah perpaduan antara estetika dan fungsionalitas."
    },
    // Produk lainnya...
  ];

  void _addToTotal(double price) {
    setState(() {
      totalHarga += price;
    });
  }

  void _showProductDescription(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDescriptionScreen(product: product),
      ),
    );
  }

  void _navigateToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(totalPrice: totalHarga),
      ),
    );
  }

  // Fungsi untuk memformat angka menjadi format Rupiah
  String formatCurrency(double amount) {
    return "Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.")}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 16),
            color: Color(0xFF114D91),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "Produk",
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
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _addToTotal(products[index]["price"]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              products[index]["image"],
                              fit: BoxFit.cover,
                              height: 120,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    _showProductDescription(products[index]),
                                child: Text(
                                  products[index]["name"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                products[index]["category"],
                                style: TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                formatCurrency(products[index]["price"]),
                                style: TextStyle(
                                  color: Color(0xFF114D91),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Harga",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(formatCurrency(totalHarga),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF114D91),
                        )),
                  ],
                ),
                ElevatedButton(
                  onPressed: _navigateToPayment,
                  child: Text("Bayar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF114D91),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
