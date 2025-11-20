import 'package:flutter/material.dart';
import 'song_delete_artis.dart';

class MySongListPage extends StatelessWidget {
  const MySongListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> songs = [
      "Midnight Serenade",
      "Echoes in the Rain",
      "Starlight Whispers",
      "Sunset Boulevard",
      "Fading Memories",
      "Velvet Nights",
      "Wired Emotions",
      "Concrete Jungle"
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        title: const Text("My Songs",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return _songTile(
            title: songs[index],
            onDelete: () {
              showDialog(
                context: context,
                builder: (_) => const DeleteSongDialog(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _songTile({
    required String title,
    required VoidCallback onDelete,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit, size: 20, color: Colors.blue),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(Icons.delete, size: 20, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
