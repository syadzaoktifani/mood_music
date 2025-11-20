import 'package:flutter/material.dart';

class ProfileAdminPage extends StatelessWidget {
  const ProfileAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text("Admin User", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("admin@musicapp.com", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
