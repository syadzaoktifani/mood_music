import 'package:flutter/material.dart';
import 'dart:async'; 
import 'halamanawal.dart'; 

void main() {
  runApp(const MoodMusicApp());
}

class MoodMusicApp extends StatelessWidget {
  const MoodMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Music',
      theme: ThemeData(
        // Mengatur tema default agar konsisten di seluruh aplikasi
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        primarySwatch: Colors.indigo,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/halamanAwal': (context) => RoleSelectionPage(),
      },
      initialRoute: '/',
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // ⏱️ TIMER: Tunggu 3 detik, lalu pindah
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/halamanAwal');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ UBAH DISINI: Menggunakan warna yang sama dengan RoleSelectionPage
      backgroundColor: const Color(0xFFF9FAFB), 
      
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/emoji.jpg',
                width: 150,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  // Icon default jika gambar error
                  return const Icon(
                    Icons.music_note_rounded, 
                    size: 100, 
                    color: Color(0xFF0D47A1)
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Mood Music',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  // ✅ UBAH DISINI: Warna teks disamakan dengan judul di halaman awal
                  color: const Color(0xFF0D47A1), 
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                // ✅ UBAH DISINI: Warna loading disamakan dengan tema
                color: Color(0xFF0D47A1), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}