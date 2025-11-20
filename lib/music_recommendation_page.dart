import 'package:flutter/material.dart';

class MusicRecommendationPage extends StatelessWidget {
  const MusicRecommendationPage({super.key});

  // Data dummy untuk rekomendasi
  final Map<String, List<Map<String, String>>> recommendations = const {
    'Happy': [
      {'title': 'Good as Hell', 'artist': 'Lizzo', 'cover': 'https://placehold.co/130x120/f9e79f/c0392b?text=GAH'},
      {'title': 'Don\'t Stop Me Now', 'artist': 'Queen', 'cover': 'https://placehold.co/130x120/aed6f1/283747?text=DSM'},
      {'title': 'Walking on Sunshine', 'artist': 'Katrina & The Waves', 'cover': 'https://placehold.co/130x120/f5b7b1/641e16?text=WOS'},
    ],
    'Calm': [
      {'title': 'Weightless', 'artist': 'Marconi Union', 'cover': 'https://placehold.co/130x120/d4e6f1/1a5276?text=W'},
      {'title': 'Clair de Lune', 'artist': 'Claude Debussy', 'cover': 'https://placehold.co/130x120/e8daef/4a235a?text=CDL'},
      {'title': 'Ho Hey', 'artist': 'The Lumineers', 'cover': 'https://placehold.co/130x120/d5f5e3/186a3b?text=HH'},
    ],
    'Sad': [
      {'title': 'Fix You', 'artist': 'Coldplay', 'cover': 'https://placehold.co/130x120/d6dbdf/1b2631?text=FY'},
      {'title': 'Someone Like You', 'artist': 'Adele', 'cover': 'https://placehold.co/130x120/aeb6bf/212f3c?text=SLY'},
      {'title': 'Hallelujah', 'artist': 'Jeff Buckley', 'cover': 'https://placehold.co/130x120/d5d8dc/283747?text=H'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol back otomatis ada
        iconTheme: const IconThemeData(color: Colors.black), 
        title: const Text(
          'Music Recommendation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian "Happy"
              _buildMoodSection(
                context,
                mood: "Happy",
                songs: recommendations['Happy']!,
              ),
              const SizedBox(height: 24),
              
              // Bagian "Calm"
              _buildMoodSection(
                context,
                mood: "Calm",
                songs: recommendations['Calm']!,
              ),
              const SizedBox(height: 24),

              // Bagian "Sad"
              _buildMoodSection(
                context,
                mood: "Sad",
                songs: recommendations['Sad']!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk satu bagian mood (misal: "Happy")
  Widget _buildMoodSection(BuildContext context, {
    required String mood,
    required List<Map<String, String>> songs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Based on your '$mood' mood",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180, // Tinggi untuk list horizontal
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return _buildSongCard(context, song: songs[index]);
            },
          ),
        ),
      ],
    );
  }

  // Widget untuk satu kartu lagu
  Widget _buildSongCard(BuildContext context, {
    required Map<String, String> song,
  }) {
    return Container(
      width: 130, // Lebar kartu lagu
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Cover
          Container(
            height: 120,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(song['cover']!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Judul Lagu
          Text(
            song['title']!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF2D2D2D),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          // Nama Artis
          Text(
            song['artist']!,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}