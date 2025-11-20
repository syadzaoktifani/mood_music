import 'package:flutter/material.dart';

class DeleteSongPage extends StatefulWidget {
  final List<Map<String, dynamic>> songList;

  const DeleteSongPage({super.key, required this.songList});

  @override
  State<DeleteSongPage> createState() => _DeleteSongPageState();
}

class _DeleteSongPageState extends State<DeleteSongPage> {
  late List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = List.from(widget.songList);
  }

  void deleteSong(int index) {
    setState(() {
      data.removeAt(index);
    });
    // Kembalikan data ke halaman sebelumnya
    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D18),

      // 🔥 AppBar lebih jelas
      appBar: AppBar(
        backgroundColor: const Color(0xff141424),
        title: const Text(
          "Delete Song",
          style: TextStyle(
            color: Colors.white,      // 🔥 teks AppBar jelas
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,        // 🔥 icon back putih
        ),
      ),

      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) {
          final song = data[i];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xff1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                song["title"],
                style: const TextStyle(
                  color: Colors.white,      // 🔥 teks lebih jelas
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                song["artist"],
                style: const TextStyle(
                  color: Colors.white60,    // 🔥 teks lebih jelas
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => deleteSong(i),
                tooltip: "Delete Song",
              ),
            ),
          );
        },
      ),
    );
  }
}
