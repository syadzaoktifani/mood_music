import 'package:flutter/material.dart';
import 'package:sentiment_dart/sentiment_dart.dart'; // Paket analisis sentimen
import 'package:mood_music/musik_page.dart';

class DetectFromTextScreen extends StatefulWidget {
  const DetectFromTextScreen({super.key});

  @override
  State<DetectFromTextScreen> createState() => _DetectFromTextScreenState();
}

class _DetectFromTextScreenState extends State<DetectFromTextScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  String _detectedMood = '';

  // Contoh daftar lagu per mood
  final Map<String, List<Map<String, String>>> moodSongs = {
    "Sangat Senang 😄": [
      {"title": "Happy Song 1", "file": "music/happy1.mp3"},
      {"title": "Happy Song 2", "file": "music/happy2.mp3"},
    ],
    "Senang 🙂": [
      {"title": "Joy Song 1", "file": "music/joy1.mp3"},
      {"title": "Joy Song 2", "file": "music/joy2.mp3"},
    ],
    "Neutral 😐": [
      {"title": "Neutral Song 1", "file": "music/neutral1.mp3"},
    ],
    "Sedih 😟": [
      {"title": "Sad Song 1", "file": "music/sad1.mp3"},
      {"title": "Sad Song 2", "file": "music/sad2.mp3"},
    ],
    "Sangat Sedih 😠": [
      {"title": "Very Sad Song 1", "file": "music/verysad1.mp3"},
    ],
  };

  // Fungsi deteksi mood dari teks
  Future<void> _detectMood() async {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _detectedMood = '';
    });

    try {
      final analysis = Sentiment.analysis(
        _textController.text,
        languageCode: 'en',
      );

      double score = analysis.score;
      String moodResult;

      if (score > 1) {
        moodResult = "Sangat Senang 😄";
      } else if (score > 0) {
        moodResult = "Senang 🙂";
      } else if (score == 0) {
        moodResult = "Neutral 😐";
      } else if (score < -1) {
        moodResult = "Sangat Sedih 😠";
      } else {
        moodResult = "Sedih 😟";
      }

      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _detectedMood = moodResult;
        _isLoading = false;
      });
    } catch (e) {
      print("Error saat analisis sentimen: $e");
      setState(() {
        _detectedMood = "Error: Gagal menganalisis";
        _isLoading = false;
      });
    }
  }

  // Fungsi menampilkan rekomendasi musik sesuai mood
  void _showMusicRecommendation() {
    if (_detectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mood belum terdeteksi.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicPage(mood: _detectedMood),
      ),
    );
  }


  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Detect From Text',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your text',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Write down how you are feeling right now.',
                style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _textController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Saya merasa...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _detectMood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                        )
                      : const Text(
                          'Detect Mood',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              if (_detectedMood.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _showMusicRecommendation,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF2196F3)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    child: const Text(
                      'Lihat Rekomendasi Musik',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              if (_detectedMood.isNotEmpty)
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Detected Mood:',
                        style: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _detectedMood,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
