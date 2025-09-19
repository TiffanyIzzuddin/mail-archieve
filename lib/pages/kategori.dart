import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  final TextEditingController _kategoriController = TextEditingController();
  final CollectionReference _kategoriCollection =
      FirebaseFirestore.instance.collection('kategori');

  /// Tambah kategori
  void _tambahKategori() async {
    if (_kategoriController.text.isNotEmpty) {
      await _kategoriCollection.add({
        'kategori': _kategoriController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _kategoriController.clear();
    }
  }

  /// Edit kategori
  void _editKategori(String docId, String currentValue) {
    final TextEditingController editController =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF360153), width: 1),
        ),
        title: const Center(
          child: Text(
            "Edit Kategori",
            style: TextStyle(color: Color(0xFF360153)),
            textAlign: TextAlign.center,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editController,
              decoration: InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFA503FC)),
                ),
              ),
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
                    await _kategoriCollection.doc(docId).update({
                      'kategori': editController.text,
                    });
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
      ),
    );
  }

  /// Hapus kategori
  void _hapusKategori(String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Anda yakin akan menghapus kategori ini ?"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _kategoriCollection.doc(docId).delete();
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
              "Halaman Kategori",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _kategoriController,
                      decoration: InputDecoration(
                        hintText: "Tambahkan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFA503FC)),
                        ),
                        enabledBorder: OutlineInputBorder(
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
                    onPressed: _tambahKategori,
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

            /// DataTable dari Firebase
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _kategoriCollection.orderBy('createdAt').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error mengambil data"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // final docs = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFF360153), width: 2),
                      ),
                      clipBehavior: Clip.hardEdge, // ✅ isi tabel ter-clip
                      child: DataTable(
                        // border: TableBorder.all(
                        //     color: const Color(0xFF360153), width: 2),
                        headingRowColor:
                            MaterialStateProperty.all(const Color(0xFF360153)),
                        columns: const [
                          DataColumn(
                              label: Text("ID",
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
                        rows: snapshot.data!.docs.asMap().entries.map(
                          (entry) {
                            final index = entry.key; // index mulai dari 0
                            final doc = entry.value;
                            final nomorUrut = index + 1; // increment visual ID

                            return DataRow(
                              cells: [
                                DataCell(Text(nomorUrut
                                    .toString())), // ✅ increment visual
                                DataCell(Text(doc['kategori'] ?? '')),
                                DataCell(
                                  Row(
                                    children: [
                                      OutlinedButton(
                                        onPressed: () => _editKategori(
                                            doc.id, doc['kategori']),
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: Color(0xFF7FDCB7),
                                              width: 2),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                        ),
                                        child: const Text("Edit",
                                            style: TextStyle(
                                                color: Color(0xFF360153))),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () => _hapusKategori(doc.id),
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: Color(0xFF7FDCB7),
                                              width: 2),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                        ),
                                        child: const Text("Hapus",
                                            style: TextStyle(
                                                color: Color(0xFF360153))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
