import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure to add url_launcher to pubspec.yaml

class DashboardScreen extends StatelessWidget {
  final List<String> images = [
    "assets/images/slider1.png",
    "assets/images/slider2.png"
  ];

  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/product1.jpg",
      "category": "Aksesoris",
      "name": "Blangkon",
      "price": 25500,
      "description":
          "Blangkon ini adalah simbol kebudayaan Indonesia yang terbuat dari bahan berkualitas tinggi. Didesain dengan motif tradisional yang memikat."
    },
    {
      "image": "assets/images/product2.jpg",
      "category": "Pakaian",
      "name": "Kemeja Batik",
      "price": 75750,
      "description":
          "Kemeja Batik ini menampilkan keindahan pola batik yang khas, menggambarkan kekayaan budaya Indonesia."
    },
    {
      "image": "assets/images/product3.jpg",
      "category": "Makanan",
      "name": "Keripik Tempe",
      "price": 18000,
      "description":
          "Keripik Tempe ini adalah camilan sehat yang tidak hanya lezat, tetapi juga bergizi."
    },
    {
      "image": "assets/images/product4.jpg",
      "category": "Aksesoris",
      "name": "Tas anyaman",
      "price": 23500,
      "description":
          "Tas anyaman ini adalah perpaduan antara estetika dan fungsionalitas."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                "UMKM Blangkis",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 10),
          // Image slider section
          Container(
            height: 200,
            child: PageView(
              children: images.map((image) {
                return Image.asset(image, fit: BoxFit.cover);
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          // Contact icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.map, color: Colors.blue, size: 30),
                onPressed: () async {
                  final Uri url =
                      Uri.parse('https://maps.app.goo.gl/QGLF7ehfJtnMmUKF7');
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.phone, color: Colors.green, size: 30),
                onPressed: () async {
                  final Uri url = Uri.parse(
                      'https://api.whatsapp.com/send?phone=6287878462003');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.message, color: Colors.red, size: 30),
                onPressed: () async {
                  final Uri url = Uri.parse(
                      'https://api.whatsapp.com/send?phone=6287878462003&text=Halo%20Blangkis');
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          // Welcome description
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Selamat datang di Blangkis! Kami menawarkan berbagai produk berkualitas, seperti blangkon, batik, kripik tempe, dan tas anyaman, semua dengan harga terjangkau. Dapatkan keindahan dan keunikan produk lokal sambil mendukung pengrajin kami. Bergabunglah merayakan budaya bersama kami!",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Daftar Produk Terbaru:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Product Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        products[index]["image"],
                        fit: BoxFit.cover,
                        height: 120, // Adjust height as needed
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index]["name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1, // Limit to 1 line
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                          Text(
                            products[index]["category"],
                            style: TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Rp ${products[index]["price"].toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.")}",
                            style: TextStyle(
                              color: Color(0xFF114D91),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(), // Spacer to create distance within card
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 20),
          // Additional Info
          Text(
            "Alamat: Jl. Imam Bonjol No.207, Pendrikan Kidul, Kec. Semarang Tengah, Kota Semarang, Jawa Tengah 50131",
          ),
          SizedBox(height: 8),
          Text("Jam Buka: Senin - Sabtu, 08:00 - 17:00"),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/products');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
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
