import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.tealAccent,
      elevation: 1,
      automaticallyImplyLeading: false, // hilangkan arrow back
      titleSpacing: 50, // jarak title dari kiri
      title: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: const Text(
          'Karangduren Official',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/kategori');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF360153), // warna ungu tua
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Kategori",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/about');
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  side: const BorderSide(color: Color(0xFF360153), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.white70,
                ),
                child: const Text(
                  "About",
                  style: TextStyle(color: Color(0xFF360153), fontSize: 16),
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
