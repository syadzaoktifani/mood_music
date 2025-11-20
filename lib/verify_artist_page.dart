import 'package:flutter/material.dart';
import 'verify_status_page.dart';

class VerifyArtist extends StatefulWidget {
  const VerifyArtist({super.key});

  @override
  State<VerifyArtist> createState() => _VerifyArtistListMobileState();
}

class _VerifyArtistListMobileState extends State<VerifyArtist> {
  // Data dummy (dari file desktop Anda)
  List<Map<String, String>> pendingArtists = [
    {"name": "Adele", "info": "Requested 2 days ago"},
    {"name": "Ed Sheeran", "info": "Requested 1 day ago"},
    {"name": "Imagine Dragons", "info": "Requested 5 hours ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Artist Accounts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: pendingArtists.length,
        itemBuilder: (context, index) {
          final artist = pendingArtists[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist['name']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artist['info']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          // HUBUNGKAN: Pindah ke halaman status Gagal
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const VerifyStatusPage(isSuccess: false),
                            ),
                          );
                        },
                        child: const Text('Reject'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          // HUBUNGKAN: Pindah ke halaman status Sukses
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const VerifyStatusPage(isSuccess: true),
                            ),
                          );
                        },
                        child: const Text('Approve'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}