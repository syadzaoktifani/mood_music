import 'package:flutter/material.dart';
import 'manage_song_artis.dart';
import 'profileartis.dart';

class DashboardArtist extends StatelessWidget {
  const DashboardArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat datang, [Artist Name]!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Upload Lagu
            _menuButton(
              title: "Upload Lagu",
              color: Colors.blue,
              textColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(height: 12),

            // Kelola Lagu
            _menuButton(
              title: "Edit/Hapus Lagu",
              color: Colors.white,
              border: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManageSongMainPage()),
                );
              },
            ),
            const SizedBox(height: 12),

            // Kelola Profil
            _menuButton(
              title: "Kelola Profil",
              color: Colors.white,
              border: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileArtistPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton({
    required String title,
    required Color color,
    bool border = false,
    Color textColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: border ? Border.all(color: Colors.grey.shade300) : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
