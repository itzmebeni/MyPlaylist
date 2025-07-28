import 'package:flutter/material.dart';

class LikedSongsManager {
  static List<Map<String, String>> likedSongs = [];
}

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  void _playSong(Map<String, String> song) {
    // TODO: Replace with actual playback using just_audio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Now playing: ${song['title']}')),
    );
  }

  void _removeSong(int index) async {
    final song = LikedSongsManager.likedSongs[index];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Liked Song'),
        content: Text('Remove "${song['title']}" from liked songs?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Remove', style: TextStyle(color: Colors.red)))
        ],
      ),
    );

    if (confirmed ?? false) {
      setState(() {
        LikedSongsManager.likedSongs.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${song['title']} removed from liked songs')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final liked = LikedSongsManager.likedSongs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Songs"),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: liked.isNotEmpty
            ? [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear All Liked Songs'),
                  content: const Text('Delete all liked songs?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );
              if (confirmed ?? false) {
                setState(() {
                  LikedSongsManager.likedSongs.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All liked songs removed')),
                );
              }
            },
          )
        ]
            : null,
      ),
      body: liked.isEmpty
          ? const Center(child: Text("No liked songs yet."))
          : ListView.builder(
        itemCount: liked.length,
        itemBuilder: (context, index) {
          final song = liked[index];
          return ListTile(
            leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
            title: Text(song['title'] ?? ''),
            subtitle: Text(song['artist'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.pink),
                  onPressed: () => _playSong(song),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () => _removeSong(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
