import 'package:flutter/material.dart';

class EditSongMobile extends StatefulWidget {
  // Terima data lagu. Jika null, berarti ini halaman 'Add Song'
  final Map<String, dynamic>? song;
  const EditSongMobile({super.key, required this.song});

  @override
  State<EditSongMobile> createState() => _EditSongMobileState();
}

class _EditSongMobileState extends State<EditSongMobile> {
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _albumController;
  // ... tambahkan controller lain sesuai kebutuhan

  bool get isEditing => widget.song != null; // Cek apakah ini mode Edit

  @override
  void initState() {
    super.initState();
    // Isi controller dengan data lagu jika mode Edit
    _titleController = TextEditingController(text: widget.song?['title'] ?? '');
    _artistController =
        TextEditingController(text: widget.song?['artist'] ?? '');
    _albumController =
        TextEditingController(text: widget.song?['album'] ?? 'Neon Dreams');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Song Detail' : 'Add New Song'),
        actions: [
          // Tambahkan tombol Save
          TextButton(
            onPressed: () {
              // Logika untuk save
              Navigator.pop(context); // Kembali ke halaman list
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      // Gambar placeholder
                      image: const DecorationImage(
                        image: NetworkImage('https://placehold.co/150x150/e0e0e0/9e9e9e?text=Cover'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Logika ganti gambar
                    },
                    child: const Text('Change Cover Image'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(_titleController, 'Song Title'),
            _buildTextField(_artistController, 'Artist'),
            _buildTextField(_albumController, 'Album'),
            // Tambahkan field lain dari gambar
            _buildInfoRow('Duration', '3:45'),
            _buildInfoRow('Genre', 'Synthwave'),
            _buildInfoRow('Release Date', '10/27/2023'),
            const SizedBox(height: 16),
            const Text(
              'Audio File',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.audiotrack, color: Colors.blue),
              title: const Text('starlight_master_v2.wav'),
              trailing: TextButton(
                onPressed: () {
                  // Logika ganti file audio
                },
                child: const Text('Change'),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                ),
                onPressed: () {
                  Navigator.pop(context); // Tombol Cancel
                },
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat text field
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Widget helper untuk info (duration, genre, dll)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}