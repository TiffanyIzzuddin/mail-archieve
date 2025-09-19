import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mail_archieve_web/pages/about.dart';
import 'package:mail_archieve_web/pages/archieve.dart';
import 'package:mail_archieve_web/pages/home.dart';
import 'package:mail_archieve_web/pages/kategori.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Archieve',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/kategori': (context) => const KategoriPage(),
        '/about': (context) => const AboutPage(),
        '/archieve': (context) => const ArchievePage(),
      },
    );
  }
}
