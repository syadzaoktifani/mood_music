import 'package:flutter/material.dart';

class MoodTrendsPage extends StatefulWidget {
  const MoodTrendsPage({super.key});

  @override
  State<MoodTrendsPage> createState() => _MoodTrendsPageState();
}

class _MoodTrendsPageState extends State<MoodTrendsPage> {
  int selected = 1; // Month default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Mood Trends",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E6CFF),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              // Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab("Week", 0),
                  _buildTab("Month", 1),
                  _buildTab("Year", 2),
                  _buildTab("All", 3),
                ],
              ),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "This Month's Moods",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Graph
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomPaint(
                  painter: MoodGraphPainter(),
                  child: Container(),
                ),
              ),

              const SizedBox(height: 25),

              // Summary Card
              _summaryCard("Most Frequent Mood", "Happy"),
              _summaryCard("Average Mood", "Positive"),
              _summaryCard("Total Entries", "28"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Text(
            data,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    bool active = selected == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF1E6CFF) : const Color(0xFFF2F6FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ---------------- GRAPH CUSTOM PAINTER ---------------- //

class MoodGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = const Color(0xFF1E6CFF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Dummy line points
    Path path = Path();
    path.moveTo(0, size.height * 0.6);
    path.lineTo(size.width * 0.2, size.height * 0.4);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.35);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
