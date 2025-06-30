import 'package:flutter/material.dart';
import 'Music.dart';

class Itemcard extends StatelessWidget {
  final Music musics;
  const Itemcard({
    super.key,
    required this.musics,
  });

  // Converts 10-scale rating to 5-star equivalent
  int getStarCount(int rating) {
    if (rating >= 10) return 5;
    if (rating >= 9) return 4;
    if (rating >= 8) return 4;
    if (rating >= 7) return 3;
    if (rating >= 6) return 3;
    return 2;
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
              color: Colors.pinkAccent.withOpacity(0.2),
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  musics.artist,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.purpleAccent[100],
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
                    color: Colors.pinkAccent,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
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
