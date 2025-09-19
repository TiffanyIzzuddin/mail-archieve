import 'dart:html' as html; // untuk upload PDF di Flutter Web

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class ArchievePage extends StatefulWidget {
  const ArchievePage({super.key});

  @override
  State<ArchievePage> createState() => _ArchievePageState();
}

class _ArchievePageState extends State<ArchievePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  void _showUploadDialog({DocumentSnapshot? doc}) {
    final TextEditingController noController =
        TextEditingController(text: doc?['no'] ?? '');
    final TextEditingController judulController =
        TextEditingController(text: doc?['judul'] ?? '');
    String? kategoriValue = doc?['kategori'];
    html.File? selectedFile;
    String? fileName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF360153), width: 1),
        ),
        title: Container(
          padding: const EdgeInsets.all(12),
          child: const Text(
            "Upload Surat Resmi",
            style: TextStyle(color: Color(0xFF360153)),
            textAlign: TextAlign.center,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: noController,
                    decoration: InputDecoration(
                      labelText: "No",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFA503FC)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: judulController,
                    decoration: InputDecoration(
                      labelText: "Judul",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFA503FC)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('kategori')
                        .orderBy('kategori')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final items = snapshot.data!.docs;
                      return DropdownButtonFormField<String>(
                        value: kategoriValue,
                        decoration: InputDecoration(
                          labelText: "Kategori",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFA503FC)),
                          ),
                        ),
                        items: items
                            .map((e) => DropdownMenuItem<String>(
                                  value: e['kategori'],
                                  child: Text(e['kategori']),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setStateDialog(() {
                            kategoriValue = val;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      final uploadInput = html.FileUploadInputElement()
                        ..accept = '.pdf';
                      uploadInput.click();
                      uploadInput.onChange.listen((event) {
                        final file = uploadInput.files!.first;
                        if (file.type == "application/pdf") {
                          setStateDialog(() {
                            selectedFile = file;
                            fileName = file.name;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Hanya file PDF yang diperbolehkan.")),
                          );
                        }
                      });
                    },
                    child: Text(fileName ?? "Upload File"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Kembali"),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () async {
                          String? fileUrl = doc?['fileUrl'];
                          if (selectedFile != null) {
                            final storageRef = FirebaseStorage.instance
                                .ref()
                                .child('suratResmi/${selectedFile!.name}');
                            final uploadTask =
                                await storageRef.putBlob(selectedFile!);
                            fileUrl = await uploadTask.ref.getDownloadURL();
                          }

                          if (doc == null) {
                            await FirebaseFirestore.instance
                                .collection('suratResmi')
                                .add({
                              'no': noController.text,
                              'judul': judulController.text,
                              'kategori': kategoriValue,
                              'fileUrl': fileUrl,
                              'createdAt': FieldValue.serverTimestamp(),
                            });
                          } else {
                            await FirebaseFirestore.instance
                                .collection('suratResmi')
                                .doc(doc.id)
                                .update({
                              'no': noController.text,
                              'judul': judulController.text,
                              'kategori': kategoriValue,
                              'fileUrl': fileUrl,
                            });
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7FDCB7),
                        ),
                        child: const Text("Simpan",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _hapusSurat(DocumentSnapshot doc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Anda yakin akan menghapus surat ini ?"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('suratResmi')
                        .doc(doc.id)
                        .delete();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7FDCB7),
                  ),
                  child:
                      const Text("Ya", style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _lihatSurat(DocumentSnapshot doc) {
    final url = doc['fileUrl'];
    if (url != null) {
      html.window.open(url, '_blank');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File belum tersedia.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Archieve Surat Resmi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Cari",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFA503FC)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFA503FC), width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () => _showUploadDialog(),
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(color: Color(0xFFA503FC), width: 2),
                    ),
                    child: const Text(
                      "Tambah",
                      style: TextStyle(color: Color(0xFFA503FC)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('suratResmi')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs.where((doc) {
                    final judul = (doc['judul'] ?? '').toString().toLowerCase();
                    return judul.contains(_searchText);
                  }).toList();

                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFF360153), width: 2),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(const Color(0xFF360153)),
                        columns: const [
                          DataColumn(
                              label: Text("No",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text("Judul",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text("Kategori",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text("Action",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: docs.asMap().entries.map((entry) {
                          final doc = entry.value;
                          return DataRow(cells: [
                            DataCell(Text(doc['no'] ?? '')),
                            DataCell(Text(doc['judul'] ?? '')),
                            DataCell(Text(doc['kategori'] ?? '')),
                            DataCell(Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () => _showUploadDialog(doc: doc),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xFF7FDCB7), width: 2),
                                  ),
                                  child: const Text("Edit",
                                      style:
                                          TextStyle(color: Color(0xFF7FDCB7))),
                                ),
                                const SizedBox(width: 6),
                                OutlinedButton(
                                  onPressed: () => _hapusSurat(doc),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xFF7FDCB7), width: 2),
                                  ),
                                  child: const Text("Hapus",
                                      style:
                                          TextStyle(color: Color(0xFF7FDCB7))),
                                ),
                                const SizedBox(width: 6),
                                ElevatedButton(
                                  onPressed: () => _lihatSurat(doc),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7FDCB7),
                                  ),
                                  child: const Text("Lihat",
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
