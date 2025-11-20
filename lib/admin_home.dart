import 'package:flutter/material.dart';
import 'manage_song_page.dart';
import 'verify_artist_page.dart';
import 'search_admin_page.dart';
import 'profileadmin.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      // ================= BODY BERUBAH TIAP TAB =================
      body: _buildBody(),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // ======================================================
  // =============== BAGIAN BODY (TIAP TAB) ================
  // ======================================================
  Widget _buildBody() {
    // Tab 0 → Home menu
    if (_selectedIndex == 0) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _menuCard(
              icon: Icons.music_note,
              iconColor: Colors.blue,
              title: "Manage Song Content",
              subtitle: "Edit, upload, or remove songs from the platform.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManageSongPage()),
                );
              },
            ),

            const SizedBox(height: 18),

            _menuCard(
              icon: Icons.verified_user,
              iconColor: Colors.blue,
              title: "Verify Artist Accounts",
              subtitle:
                  "Review and approve new artist verification requests.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VerifyArtist()),
                );
              },
            ),
          ],
        ),
      );
    }

    // Tab 1 → Search Page
    else if (_selectedIndex == 1) {
      return const SearchAdminPage();
    }

    // Tab 2 → Profile Page
    else {
      return const ProfileAdminPage();
    }
  }

  // ================= WIDGET CARD MENU =================
  Widget _menuCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 30),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
