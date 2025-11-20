import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class MusicPage extends StatefulWidget {
  final String mood; // mood mentah dari screen sebelumnya

  const MusicPage({
    super.key,
    required this.mood,
  });

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AudioPlayer player = AudioPlayer();

  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  List tracks = [];
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    setupAudio();
    fetchTracks();
  }

  /// ====================================================
  ///  KONVERSI MOOD → FORMAT YANG DITERIMA BACKEND
  /// ====================================================
  String convertMoodForBackend(String input) {
    input = input.toLowerCase();

    if (input.contains("senang") ||
        input.contains("happy") ||
        input.contains("😄") ||
        input.contains("🙂")) {
      return "happy";
    }

    if (input.contains("sedih") ||
        input.contains("sad") ||
        input.contains("😟") ||
        input.contains("😠")) {
      return "sad";
    }

    if (input.contains("neutral") || input.contains("😐")) {
      return "neutral";
    }

    if (input.contains("marah") || input.contains("angry")) {
      return "angry";
    }

    if (input.contains("romantic") ||
        input.contains("love") ||
        input.contains("romantis")) {
      return "romantic";
    }

    if (input.contains("energetic") ||
        input.contains("semangat") ||
        input.contains("energy")) {
      return "energetic";
    }

    return "neutral"; // fallback default
  }

  /// SETUP AUDIO (WAJIB)
  Future<void> setupAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  /// FETCH KE BACKEND (SAMA PERSIS FE WEB)
  Future<void> fetchTracks() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    final moodKey = convertMoodForBackend(widget.mood);

    try {
      // SESUAIKAN IP LAN / HOST BACKEND KAMU
      final uri = Uri.parse("https://mood-music-backend.vercel.app/mood").replace(
        queryParameters: {
          "q": moodKey, // mood hasil konversi
        },
      );

      final res = await http.get(uri);

      if (res.statusCode != 200) {
        setState(() {
          isError = true;
          errorMessage =
              "Server error ${res.statusCode}: ${res.reasonPhrase}";
          isLoading = false;
        });
        return;
      }

      final data = jsonDecode(res.body);
      tracks = data["tracks"] ?? [];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = "Gagal fetch: $e";
        isLoading = false;
      });
    }
  }

  /// PLAY PREVIEW 30 DETIK
  Future<void> playPreview(int index) async {
    final track = tracks[index];
    final url = track["preview"];

    if (url == null || url.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preview tidak tersedia")),
      );
      return;
    }

    try {
      await player.setUrl(url);
      player.play();

      setState(() {
        currentIndex = index;
      });
    } catch (e) {
      print("Play error: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moodLabel = convertMoodForBackend(widget.mood);

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        title: Text("Music for mood $moodLabel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : isError
                ? Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  )
                : tracks.isEmpty
                    ? const Center(
                        child: Text(
                          "Tidak ada musik untuk mood ini.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tracks.length,
                        itemBuilder: (context, index) {
                          final t = tracks[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: const Color(0xFF374151), width: 1),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF1F2937),
                                  Color(0xFF020617),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  t["cover"] ?? "",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                t["title"] ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                t["artist"] ?? "",
                                style: const TextStyle(
                                  color: Color(0xFFC7D2FE),
                                  fontSize: 12,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  currentIndex == index
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  color: Colors.greenAccent,
                                  size: 30,
                                ),
                                onPressed: () => playPreview(index),
                              ),
                              onTap: () => playPreview(index),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}