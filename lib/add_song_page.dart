import 'package:flutter/material.dart';

class AddSongPage extends StatefulWidget {
  const AddSongPage({super.key});

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  late TextEditingController titleController;
  late TextEditingController artistController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    artistController = TextEditingController();
    categoryController = TextEditingController();
  }

  InputDecoration _input(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: const Color(0xff1A1A2E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
    );
  }

  void submit() {
    Navigator.pop(context, {
      "title": titleController.text,
      "artist": artistController.text,
      "category": categoryController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D18),

      // 🔥 AppBar diperbaiki: teks putih agar jelas
      appBar: AppBar(
        backgroundColor: const Color(0xff141424),
        title: const Text(
          "Add Song",
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: _input("Title"),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: artistController,
              style: const TextStyle(color: Colors.white),
              decoration: _input("Artist"),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: categoryController,
              style: const TextStyle(color: Colors.white),
              decoration: _input("Category"),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5566FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Song",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,   // 🔥 teks tombol putih
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
