import 'package:flutter/material.dart';
import 'admin_home.dart';

// Halaman ini digunakan untuk gambar "Artist Account Verified" DAN "Verification Failed"
class VerifyStatusPage extends StatelessWidget {
  final bool isSuccess;
  const VerifyStatusPage({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isSuccess, // Tombol back hanya jika gagal
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
                color: isSuccess ? Colors.blueAccent : Colors.redAccent,
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                isSuccess ? 'Artist Account Verified!' : 'Verification Failed',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                isSuccess
                    ? 'Congratulations! Your account is now officially verified. You can now access all artist features and start sharing your music.'
                    : 'We were unable to verify your artist account at this time. Please check your information and try again.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (isSuccess) {
                    // HUBUNGKAN: Kembali ke Dashboard utama
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomeScreenAdmin()),
                      (route) => false,
                    );
                  } else {
                    // HUBUNGKAN: Kembali ke halaman list (Retry)
                    Navigator.pop(context);
                  }
                },
                child: Text(isSuccess ? 'Go to Dashboard' : 'Retry Verification'),
              ),
              if (!isSuccess) // Tampilkan tombol 'Go Back' hanya jika gagal
                OutlinedButton(
                  onPressed: () {
                    // HUBUNGKAN: Kembali ke Dashboard utama
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomeScreenAdmin()),
                      (route) => false,
                    );
                  },
                  child: const Text('Go Back'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}