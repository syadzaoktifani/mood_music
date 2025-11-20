import 'package:flutter/material.dart';

class DeleteSongDialog extends StatelessWidget {
  const DeleteSongDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.delete_forever, size: 60, color: Colors.red),
          const SizedBox(height: 12),
          const Text(
            "Hapus Lagu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            "Apakah Anda yakin ingin menghapus lagu ini?\nTindakan ini tidak dapat dibatalkan.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 45),
            ),
            onPressed: () {},
            child: const Text("Hapus Lagu"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batalkan"),
          )
        ],
      ),
    );
  }
}
