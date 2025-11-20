import 'package:flutter/material.dart';

class MoodHistoryPage extends StatelessWidget {
  const MoodHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Mood History",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Search Bar
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Search by date, mood, or keyword",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Today",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),
              _buildMoodTile("Joyful", "Had a great meeting with the team today..", "3:45 PM"),
              _buildMoodTile("Sad", "Detected from photo", "1:55 PM"),

              const SizedBox(height: 25),

              const Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildMoodTile("Neutral", "Just a regular day at the office, nothing...", "6:20 PM"),
              _buildMoodTile("Angry", "Frustrated with the traffic on the way home.", "5:55 PM"),

              const SizedBox(height: 25),

              const Text(
                "October 26, 2023",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildMoodTile("Excited", "Booked tickets for the concert next month!", "8:10 PM"),

              const SizedBox(height: 25),

              // Load More Button
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF3FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Load More",
                    style: TextStyle(
                      color: Color(0xFF1E6CFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Item Mood
  Widget _buildMoodTile(String mood, String desc, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF3FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.emoji_emotions, size: 28, color: Colors.blue),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
