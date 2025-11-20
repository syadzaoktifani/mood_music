import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login.dart';
import 'halamanawal.dart';
import 'loginadmin.dart';
import 'loginartis.dart';
import 'splashscreen.dart'; // Pastikan file splashscreen.dart ada di folder lib/

void main() {
  runApp(const MoodMusicApp());
}

class MoodMusicApp extends StatelessWidget {
  const MoodMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodMusic 🎵',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // 🔹 Halaman pertama kali dibuka
      initialRoute: '/', // mulai dari SplashScreen

      // 🔹 Daftar semua rute navigasi
      routes: {
        '/': (context) => const SplashScreen(),         // Splash screen awal
        
        // ✅ PERBAIKAN DI SINI: 'const' dihapus agar error hilang
        '/halamanAwal': (context) => RoleSelectionPage(), 
        
        // Saya juga menyarankan menghapus const di bawah ini untuk menghindari error di masa depan
        // jika kamu mengubah halaman tersebut menjadi StatefulWidget atau menambahkan variabel non-final.
        '/loginUser': (context) => const LoginScreen(),
        '/loginAdmin': (context) => const LoginAdmin(),
        '/loginArtis': (context) => const LoginArtis(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}