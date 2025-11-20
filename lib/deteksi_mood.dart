import 'dart:io';
import 'dart:ui' as ui; // untuk PathMetric
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:audioplayers/audioplayers.dart';
import 'login.dart';
import 'musik_page.dart';

class MoodDetectorScreen extends StatefulWidget {
  const MoodDetectorScreen({super.key});

  @override
  State<MoodDetectorScreen> createState() => _MoodDetectorScreenState();
}

class _MoodDetectorScreenState extends State<MoodDetectorScreen> {
  File? _image;
  String _detectedMood = "";
  final ImagePicker _picker = ImagePicker();
  final FaceDetector _faceDetector =
      FaceDetector(options: FaceDetectorOptions(enableClassification: true));
  final AudioPlayer _audioPlayer = AudioPlayer();

  final Color primaryBlue = const Color(0xFF4285F4);
  final Color lightBlue = const Color(0xFFE3F2FD);

  // Map normalisasi mood bahasa Indonesia -> English + Emoji
  final Map<String, String> moodMapping = {
    "SENANG": "Senang 🙂",
    "SANGAT SENANG": "Sangat Senang 😄",
    "NETRAL": "Neutral 😐",
    "SEDIH": "Sedih 😟",
    "SANGAT SEDIH": "Sangat Sedih 😠",
  };

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return;

      setState(() {
        _image = File(pickedFile.path);
        _detectedMood = "Menganalisis...";
      });

      await _analyzeFace();
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> _analyzeFace() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFile(_image!);
    try {
      final faces = await _faceDetector.processImage(inputImage);

      String moodResult;
      if (faces.isEmpty) {
        moodResult = "Wajah tidak terdeteksi";
      } else {
        final face = faces.first;
        final smileProb = face.smilingProbability ?? 0.0;

        // Normalisasi ke mood Bahasa Indonesia terlebih dahulu
        String tempMood;
        if (smileProb > 0.8) {
          tempMood = "SANGAT SENANG";
        } else if (smileProb > 0.6) {
          tempMood = "SENANG";
        } else if (smileProb >= 0.3) {
          tempMood = "NETRAL";
        } else if (smileProb >= 0.1) {
          tempMood = "SEDIH";
        } else {
          tempMood = "SANGAT SEDIH";
        }

        // Convert ke English + Emoji
        moodResult = moodMapping[tempMood] ?? tempMood;
      }

      setState(() {
        _detectedMood = moodResult;
      });
    } catch (e) {
      debugPrint("Error analyzing face: $e");
      setState(() {
        _detectedMood = "Gagal menganalisis";
      });
    }
  }

  void _showMusicRecommendation() {
    if (_detectedMood.isEmpty ||
        _detectedMood.contains("tidak terdeteksi") ||
        _detectedMood.contains("Gagal")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mood belum tersedia.")),
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

  void _resetProcess() {
    setState(() {
      _image = null;
      _detectedMood = "";
    });
    _audioPlayer.stop();
  }

  @override
  void dispose() {
    _faceDetector.close();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
        title: Text(
          _image == null ? "Deteksi Mood dari Wajah" : "Hasil Analisis",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _image == null ? _buildInputView() : _buildResultView(),
        ),
      ),
    );
  }

  Widget _buildInputView() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          flex: 3,
          child: CustomPaint(
            painter: DashedRectPainter(color: primaryBlue, strokeWidth: 2.0, gap: 10.0),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 60,
                color: primaryBlue.withOpacity(0.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Posisikan wajah Anda di dalam bingkai untuk\ndeteksi yang akurat.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text("Ambil Foto", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(Icons.image, color: primaryBlue),
                label: Text("Galeri", style: TextStyle(color: primaryBlue)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: primaryBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildResultView() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            image: DecorationImage(
              image: FileImage(_image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "Ekspresi: $_detectedMood",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _showMusicRecommendation,
            icon: const Icon(Icons.music_note, color: Colors.white),
            label: const Text("Lihat Rekomendasi Musik",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _resetProcess,
            icon: Icon(Icons.camera_alt_outlined, color: primaryBlue),
            label: Text("Ambil Foto Lagi", style: TextStyle(color: primaryBlue, fontSize: 16)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: primaryBlue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Utility: Dashed border
class DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;

  DashedRectPainter({this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = Path()..moveTo(0, 0)..lineTo(x, 0);
    Path _bottomPath = Path()..moveTo(0, y)..lineTo(x, y);
    Path _rightPath = Path()..moveTo(x, 0)..lineTo(x, y);
    Path _leftPath = Path()..moveTo(0, 0)..lineTo(0, y);

    canvas.drawPath(_dashPath(_topPath, dashWidth: 10.0, dashSpace: gap), dashedPaint);
    canvas.drawPath(_dashPath(_bottomPath, dashWidth: 10.0, dashSpace: gap), dashedPaint);
    canvas.drawPath(_dashPath(_rightPath, dashWidth: 10.0, dashSpace: gap), dashedPaint);
    canvas.drawPath(_dashPath(_leftPath, dashWidth: 10.0, dashSpace: gap), dashedPaint);
  }

  Path _dashPath(Path source, {required double dashWidth, required double dashSpace}) {
    final Path path = Path();
    for (final ui.PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        path.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
