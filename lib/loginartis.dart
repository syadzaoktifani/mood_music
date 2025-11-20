import 'package:flutter/material.dart';
import 'package:mood_music/register.dart';
import 'artis_home_page.dart'; // pastikan nama file dan class sesuai

class LoginArtis extends StatefulWidget {
  const LoginArtis({super.key});

  @override
  State<LoginArtis> createState() => _LoginArtisState();
}

class _LoginArtisState extends State<LoginArtis> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi Login
  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // login sederhana (dummy login)
    if (username == "artis" && password == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardArtist()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username atau password salah!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ikon mikrofon
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mic,
                    size: 45,
                    color: Color(0xFF9C27B0),
                  ),
                ),
                const SizedBox(height: 24),

                // Judul
                const Text(
                  'Mood Music',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 8),

                // Subjudul
                const Text(
                  'Login Artis',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                const SizedBox(height: 40),

                // Label Username
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Kolom input username
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan username artis',
                    hintStyle: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person, color: Color(0xFF9E9E9E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Label Password
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Kolom input password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Masukkan password',
                    hintStyle: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF9E9E9E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // =======================
                // Belum punya akun? Daftar
                // =======================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun? ",
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage()
                          ));
                      },
                      child: const Text(
                        "Daftar di sini",
                        style: TextStyle(
                          color: Color(0xFF9C27B0),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Footer
                const Text(
                  '© 2025 Mood Music App by Syadza & Tasya',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
