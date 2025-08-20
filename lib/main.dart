import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:psb/pendaftaran_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PSBScreen(),
    );
  }
}

class PSBScreen extends StatelessWidget {
  const PSBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SMKN GRINGGOS 2',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    // Aksi untuk menampilkan informasi
                    Fluttertoast.showToast(
                      msg: "Informasi PSB",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // PSB Gel 1
          _PSBCard(
            title: 'PSB\nSMKN GRINGGOS 2\n2026 - 2027 GEL 1',
            buttonText: 'Masuk',
            buttonColor: Colors.red,
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                // Ganti dengan rute yang sesuai
                MaterialPageRoute(builder: (context) => RegistrasiPage()),
              ); // Ganti dengan rute yang sesuai
              // Aksi masuk gelombang 1
            },
          ),

          const SizedBox(height: 20),

          // PSB Gel 2
          _PSBCard(
            title: 'PSB\nSMKN GRINGGOS 2\n2026 - 2027 GEL 2',
            buttonText: 'Masuk',
            buttonColor: Colors.grey,
            textColor: Colors.white70,
            onPressed: () {
              // Aksi masuk gelombang 2
              Fluttertoast.showToast(
                msg: "Gelombang 2 belum dibuka",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }, // null = tombol nonaktif
          ),
        ],
      ),
    );
  }
}

class _PSBCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const _PSBCard({
    required this.title,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 150,
          height: 40,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
