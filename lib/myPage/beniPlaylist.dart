import 'package:flutter/material.dart';
import 'liked_songs.dart';

class BeniPlaylistManager {
  static List<Map<String, String>> songs = [];
}

class BeniPlaylist extends StatefulWidget {
  final String initialName;

  const BeniPlaylist({super.key, required this.initialName});

  @override
  State<BeniPlaylist> createState() => _BeniPlaylistState();
}

class _BeniPlaylistState extends State<BeniPlaylist> {
  late String playlistName;

  @override
  void initState() {
    super.initState();
    playlistName = widget.initialName;
  }

  void _removeSong(int index) {
    setState(() {
      BeniPlaylistManager.songs.removeAt(index);
    });
    Navigator.pop(context);
  }

  void _addToLiked(Map<String, String> song) {
    final alreadyLiked = LikedSongsManager.likedSongs.any((liked) =>
    liked['title'] == song['title'] && liked['artist'] == song['artist']);

    if (!alreadyLiked) {
      LikedSongsManager.likedSongs.add(song);
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${song['title']} added to liked songs!')),
    );
  }

  void _addSong() {
    setState(() {
      BeniPlaylistManager.songs.add({
        'title': 'New Song Title',
        'artist': 'New Artist',
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, playlistName);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 60, left: 28, right: 16, bottom: 20),
                  color: const Color(0xFFFFE4EC),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://s3.amazonaws.com/comicgeeks/characters/avatars/39945.jpg?t=1740428435',
                          width: 95,
                          height: 95,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playlistName,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'My loml',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context, playlistName);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: BeniPlaylistManager.songs.isEmpty
                    ? const Center(child: Text('No songs in playlist.'))
                    : ListView.builder(
                  itemCount: BeniPlaylistManager.songs.length,
                  itemBuilder: (context, index) {
                    final song = BeniPlaylistManager.songs[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      leading: const Icon(Icons.music_note,
                          color: Colors.pinkAccent),
                      title: Text(song['title']!,
                          style: const TextStyle(color: Colors.black)),
                      subtitle: Text(song['artist']!,
                          style: const TextStyle(color: Colors.black54)),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert,
                            color: Colors.grey),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (_) => _buildSongOptions(
                                context, song, index),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongOptions(
      BuildContext context, Map<String, String> song, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
            title: const Text("Add to Liked Songs",
                style: TextStyle(color: Colors.black)),
            onTap: () => _addToLiked(song),
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.redAccent),
            title: const Text("Remove this Song from Playlist",
                style: TextStyle(color: Colors.black)),
            onTap: () => _removeSong(index),
          ),
        ],
      ),
    );
  }
}
