import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Masuk Sebagai Siapa?',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Silakan pilih peran Anda untuk melanjutkan.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView(
                  children: [
                    _buildRoleCard(
                      context,
                      title: 'Admin',
                      icon: Icons.workspace_premium_rounded,
                      color: Colors.indigo.shade700,
                      onTap: () {
                        Navigator.pushNamed(context, '/loginAdmin');
                      },
                    ),
                    _buildRoleCard(
                      context,
                      title: 'User',
                      icon: Icons.person_rounded,
                      color: Colors.indigo.shade500,
                      onTap: () {
                        Navigator.pushNamed(context, '/loginUser');
                      },
                    ),
                    _buildRoleCard(
                      context,
                      title: 'Artis',
                      icon: Icons.mic_rounded,
                      color: Colors.indigo.shade400,
                      onTap: () {
                        Navigator.pushNamed(context, '/loginArtis');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                radius: 28,
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
