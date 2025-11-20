import 'package:flutter/material.dart';
import 'package:mood_music/mood_history.page.dart';

import 'deteksi_mood.dart';
import 'detect_from_screen.dart';
import 'profileuser.dart';
import 'play_list.dart';
import 'music_recommendation_page.dart'; // PERBAIKAN: Import halaman baru

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // PERBAIKAN NAVIGASI BOTTOM NAVBAR
  void _onItemTapped(int index) {
    if (index == 2) {
      // Profile
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else if (index == 1) {
      // Music Playlist
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HappyPlaylistPage()),
      );
    } else {
      // Home
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              const Text(
                'Welcome User,',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              const SizedBox(height: 24),

              // GRID MENU
              Row(
                children: [
                  Expanded(
                    child: _buildMenuCard(
                      icon: Icons.text_fields,
                      title: 'Detect From Text',
                      color: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF2196F3),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetectFromTextScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMenuCard(
                      icon: Icons.camera_alt_outlined,
                      title: 'Detect From Face',
                      color: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF2196F3),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MoodDetectorScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildMenuCard(
                      icon: Icons.pie_chart_outline,
                      title: 'View Mood History',
                      color: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF2196F3),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MoodHistoryPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMenuCard(
                      icon: Icons.music_note,
                      title: 'Music Recommendation',
                      color: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF2196F3),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MusicRecommendationPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVBAR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF2196F3),
          unselectedItemColor: const Color(0xFFBDBDBD),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note_outlined),
              activeIcon: Icon(Icons.music_note),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // BUILD MENU CARD
  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                    height: 1.3,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
