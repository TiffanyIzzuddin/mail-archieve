import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            margin: const EdgeInsets.all(60),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 220, vertical: 130),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Desa Karangduren",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Desa Karangduren di kecamatan Pakisaji",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/archieve'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 12),
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                    child: const Text("Archieve Surat Resmi"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
