import 'package:flutter/material.dart';
import 'AddPlaylist.dart';
import 'Music.dart';

class Itemcard extends StatelessWidget {
  final Music musics;
  const Itemcard({
    super.key,
    required this.musics,
  });

  // Directly using the 5-star rating
  int getStarCount(int rating) {
    if (rating >= 5) return 5;
    if (rating >= 4) return 4;
    if (rating >= 3) return 3;
    if (rating >= 2) return 2;
    return 1;  // For rating 1
  }

  @override
  Widget build(BuildContext context) {
    int stars = getStarCount(musics.rating);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          // Play button
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.pink[100]!.withOpacity(0.3), // Light red background
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.pinkAccent),
              onPressed: () {
                // Play action
              },
            ),
          ),
          const SizedBox(width: 20),

          // Music details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  musics.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black, // White text on light background
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  musics.artist,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.pink[200], // Light pink for artist name
                  ),
                ),
              ],
            ),
          ),

          // Star rating and more icon
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < stars ? Icons.star : Icons.star_border,
                    color: Colors.pinkAccent, // Pink stars
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black), // Black icon for contrast
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const AddPlaylist())
                  );
                  // More options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
