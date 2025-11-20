import 'package:flutter/material.dart';

// ==========================================
// HALAMAN 1: PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Color primaryBlue = const Color(0xFF2563EB);
  final Color lightBlueBg = const Color(0xFFF0F9FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol Back (Opsional: Hapus leading jika ini halaman utama di BottomNav)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
             // Cek jika bisa di-pop (misal dipush dari Home), maka kembali
             if (Navigator.canPop(context)) {
               Navigator.pop(context);
             }
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // 1. Foto Profil
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300?img=5'), // Gambar placeholder
              ),
              const SizedBox(height: 16),
              
              // 2. Nama & Email
              Text(
                "Maya Rodriguez",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "maya.rodriguez@email.com",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // 3. Tombol Edit Profile
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 4. Your Listening Habits
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Listening Habits",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Kartu Statistik
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.music_note,
                      title: "Songs Listened",
                      value: "1,204",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.emoji_emotions_outlined,
                      title: "Moods Tracked",
                      value: "58",
                    ),
                  ),
                ],
              ),
              
              const Spacer(),

              // 5. Tombol Logout
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika logout di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              
              // 6. Delete Account
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightBlueBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryBlue, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: primaryBlue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// HALAMAN 2: EDIT PROFILE SCREEN
// ==========================================
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  final Color primaryBlue = const Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // 1. Foto dengan Icon Edit
              Stack(
                children: [
                   const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFFFD580),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Change Photo",
                  style: TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 2. Form Fields
              _buildLabel("Username"),
              _buildTextField("Enter your username"),
              const SizedBox(height: 20),

              _buildLabel("Email"),
              _buildTextField("Enter your email"),
              const SizedBox(height: 20),

              _buildLabel("Nomor Telepon"),
              _buildTextField("enter your phone number"),
              
              const SizedBox(height: 40),

              // 3. Tombol Save Changes
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Tombol Cancel
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0E0E0), // Warna Abu-abu
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryBlue),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}