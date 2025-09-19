import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // untuk kIsWeb
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
      title: 'Mail Archieve Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/kategori': (context) => const KategoriPage(),
        '/about': (context) => const AboutPage(),
        // '/archieve': (context) => const UploadPage(),
        '/archieve': (context) => const ArchievePage(),
      },
    );
  }
}

Future<PlatformFile?> pickPdfFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    withData: true,
  );
  if (result != null && result.files.isNotEmpty) {
    return result.files.first; // ambil file pertama
  }
  return null;
}

Future<void> uploadPdfFile(PlatformFile file) async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final pdfsRef = storageRef
        .child("pdfs/${DateTime.now().millisecondsSinceEpoch}_${file.name}");

    UploadTask uploadTask;

    if (kIsWeb) {
      // Web pakai bytes
      uploadTask = pdfsRef.putData(
          file.bytes!, SettableMetadata(contentType: 'application/pdf'));
    } else {
      // Mobile / desktop pakai File
      uploadTask = pdfsRef.putFile(File(file.path!));
    }

    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('pdfs').add({
      'filename': file.name,
      'storagePath': pdfsRef.fullPath,
      'downloadURL': downloadUrl,
      'size': file.size,
      'uploadedAt': FieldValue.serverTimestamp(),
    });

    print("Upload sukses: $downloadUrl");
  } catch (e) {
    print("Error upload: $e");
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool loading = false;

  Future<void> handleUpload() async {
    final file = await pickPdfFile();
    if (file == null) return;

    setState(() => loading = true);
    await uploadPdfFile(file);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload PDF")),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: handleUpload,
                child: const Text("Pilih & Upload PDF"),
              ),
      ),
    );
  }
}
