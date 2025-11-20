import 'package:flutter/material.dart';
import 'edit_song_page.dart';

class ManageSongPage extends StatefulWidget {
  const ManageSongPage({super.key});

  @override
  State<ManageSongPage> createState() => _ManageSongPageState();
}

class _ManageSongPageState extends State<ManageSongPage> {
  // Data dummy
  List<Map<String, String>> songList = [
    {"title": "Bohemian Rhapsody", "artist": "Queen"},
    {"title": "Stairway to Heaven", "artist": "Led Zeppelin"},
    {"title": "Hotel California", "artist": "Eagles"},
    {"title": "Smells Like Teen Spirit", "artist": "Nirvana"},
    {"title": "Imagine", "artist": "John Lennon"},
    {"title": "Like a Rolling Stone", "artist": "Bob Dylan"},
    {"title": "Hey Jude", "artist": "The Beatles"},
  ];

  // BottomSheet
  void _showSongOptionsSheet(BuildContext context, Map<String, String> song) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                song['title']!,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit Song Details'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditSongMobile(song: song),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                'Delete Song from System',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmationDialog(context, song);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  // Dialog konfirmasi hapus
  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, String> song) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          icon: const Icon(Icons.delete_sweep_outlined,
              size: 48, color: Colors.blueAccent),
          title: const Text('Are you sure you want to delete this song?'),
          content: const Text(
              'This action cannot be undone. All associated data, including streams and stats, will be permanently lost.'),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.all(16),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      songList.remove(song);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Confirm Deletion'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a song...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Daftar lagu
          Expanded(
            child: ListView.builder(
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[index];
                return ListTile(
                  leading: const Icon(Icons.music_note_outlined,
                      color: Colors.blue),
                  title: Text(song['title']!),
                  subtitle: Text(song['artist']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      _showSongOptionsSheet(context, song);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Tambah lagu
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const EditSongMobile(song: null),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
