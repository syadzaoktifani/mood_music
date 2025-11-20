import 'package:flutter/material.dart';

class HappyPlaylistPage extends StatefulWidget {
  const HappyPlaylistPage({super.key});

  @override
  State<HappyPlaylistPage> createState() => _HappyPlaylistPageState();
}

class _HappyPlaylistPageState extends State<HappyPlaylistPage> {
  bool showCreatePage = false;

  final TextEditingController playlistNameController = TextEditingController();
  String? selectedMood;
  String? selectedGenre;

  final List<String> moods = ["Happy", "Sad", "Calm", "Energetic"];
  final List<String> genres = ["Pop", "Rock", "Jazz", "Lo-Fi", "Indie"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (showCreatePage == true) {
              setState(() => showCreatePage = false);
            }
          },
        ),
        title: Text(showCreatePage ? "Buat Playlist" : "Feeling Happy"),
        elevation: 0,
      ),

      // =============================================================
      //  MODE 1 → HALAMAN "YOUR HAPPY MIX"
      // =============================================================
      body: showCreatePage == false
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Happy Mix",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search for songs or playlists",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tabs
                  Row(
                    children: [
                      ChoiceChip(label: Text("Songs"), selected: true),
                      const SizedBox(width: 8),
                      ChoiceChip(label: Text("Playlists"), selected: false),
                      const SizedBox(width: 8),
                      ChoiceChip(label: Text("Albums"), selected: false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // List lagu
                  Expanded(
                    child: ListView(
                      children: [
                        songTile("Happy Song 1", "Artist Name"),
                        songTile("Happy Song 2", "Artist Name"),
                        songTile("Sunshine", "The Beatles"),
                        songTile("Good Day", "Lighthouse Family"),
                        songTile("Upbeat Beats", "Various Artists"),
                      ],
                    ),
                  ),

                  // Tombol Buat Playlist → Switch ke halaman form
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showCreatePage = true;
                        });
                      },
                      child: Text("Buat Playlist"),
                    ),
                  ),
                ],
              ),
            )

          // =============================================================
          //  MODE 2 → HALAMAN FORM "BUAT PLAYLIST"
          // =============================================================
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Text("Nama Playlist"),
                    const SizedBox(height: 6),
                    TextField(
                      controller: playlistNameController,
                      decoration: InputDecoration(
                        hintText: "Contoh: Lagu Semangat Pagi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text("Pilih Mood"),
                    const SizedBox(height: 6),
                    DropdownButtonFormField(
                      value: selectedMood,
                      items: moods
                          .map((m) =>
                              DropdownMenuItem(value: m, child: Text(m)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedMood = value),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text("Genre"),
                    const SizedBox(height: 6),
                    DropdownButtonFormField(
                      value: selectedGenre,
                      items: genres
                          .map((g) =>
                              DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedGenre = value),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Generate Playlist"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text("Simpan Playlist"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget untuk list lagu
  Widget songTile(String title, String artist) {
    return ListTile(
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      title: Text(title),
      subtitle: Text(artist),
      trailing: Icon(Icons.add),
    );
  }
}
