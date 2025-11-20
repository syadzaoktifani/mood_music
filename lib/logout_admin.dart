import 'package:flutter/material.dart';
import 'loginadmin.dart';

class LogoutSuccessPage extends StatelessWidget {
  const LogoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.music_note_outlined,
                  color: Colors.blueAccent, size: 80),
              const SizedBox(height: 24),
              const Text(
                'Anda telah keluar dari aplikasi.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Terima kasih telah menggunakan aplikasi ini.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // HUBUNGKAN: Kembali ke halaman Login
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginAdmin()),
                    (route) => false,
                  );
                },
                child: const Text('Kembali ke Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}