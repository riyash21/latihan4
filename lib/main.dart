import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Navigasi Flutter',
      home: const MenuScreen(),
      // Named routes untuk Latihan 3
      routes: {
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    );
  }
}

// Halaman Menu Utama untuk memilih latihan
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Latihan Navigasi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePageL1()));
            },
            child: const Text('Latihan 1: Push & Pop'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreenL2()));
            },
            child: const Text('Latihan 2: Kirim Data Produk'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second', arguments: 'Halo dari Menu!');
            },
            child: const Text('Latihan 3: Named Routes'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MainNavigationScreenBonus()));
            },
            child: const Text('Bonus: BottomNavigationBar'),
          ),
        ],
      ),
    );
  }
}

// --- KODE LATIHAN 1 ---
class HomePageL1 extends StatelessWidget {
  const HomePageL1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latihan 1 - Beranda')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPageL1())),
          child: const Text('Ke Halaman Tentang'),
        ),
      ),
    );
  }
}

class AboutPageL1 extends StatelessWidget {
  const AboutPageL1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latihan 1 - Tentang')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali ke Beranda'),
        ),
      ),
    );
  }
}

// --- KODE LATIHAN 2 ---
class Product {
  final String name;
  final int price;
  Product(this.name, this.price);
}

class ProductListScreenL2 extends StatelessWidget {
  const ProductListScreenL2({super.key});

  final List<Product> products = const [
    // Menggunakan const dengan constructor memerlukan konstanta atau inisialisasi yang sesuai,
    // namun karena Product memiliki non-const constructor, kita buat list biasa:
  ];

  @override
  Widget build(BuildContext context) {
    final List<Product> productList = [
      Product('Laptop Gaming', 15000000),
      Product('Smartphone', 5000000),
      Product('Headphone Wireless', 1200000),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Latihan 2 - Daftar Produk')),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Rp ${product.price}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreenL2(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreenL2 extends StatelessWidget {
  final Product product;
  const DetailScreenL2({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk: ${product.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Harga: Rp ${product.price}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// --- KODE LATIHAN 3 ---
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments as String? ?? 'Tidak ada data';
    return Scaffold(
      appBar: AppBar(title: const Text('Latihan 3 - Halaman 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Argumen: $message'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/third'),
              child: const Text('Ke Halaman 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latihan 3 - Halaman 3')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          child: const Text('Kembali ke Menu Utama'),
        ),
      ),
    );
  }
}

// --- KODE BONUS (BottomNavigationBar) ---
class MainNavigationScreenBonus extends StatefulWidget {
  const MainNavigationScreenBonus({super.key});

  @override
  State<MainNavigationScreenBonus> createState() => _MainNavigationScreenBonusState();
}

class _MainNavigationScreenBonusState extends State<MainNavigationScreenBonus> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Halaman Beranda', style: TextStyle(fontSize: 24))),
    Center(child: Text('Halaman Cari', style: TextStyle(fontSize: 24))),
    Center(child: Text('Halaman Profil', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bonus - Navigasi Bawah')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}