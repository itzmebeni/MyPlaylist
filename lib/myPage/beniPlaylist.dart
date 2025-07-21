import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BeniPlaylist extends StatefulWidget {
  const BeniPlaylist({super.key});

  @override
  State<BeniPlaylist> createState() => _BeniPlaylistState();
}

class _BeniPlaylistState extends State<BeniPlaylist> {
  List<Map<String, String>> songs = [
    {'title': 'Pangarap lang kita', 'artist': 'Parokya ni Edgar'},
    {'title': 'Buko', 'artist': 'Jireh Lim'},
    {'title': 'Kursunada', 'artist': 'Adie'},
    {'title': 'When I met you', 'artist': 'Apo Hiking Society'},
    {'title': 'Naiilang', 'artist': 'Le John'},
    {'title': 'Sino', 'artist': 'Unique Salonga'},
    {'title': 'With a Smile', 'artist': 'Eraserheads'},
    {'title': 'Borrowed Time', 'artist': 'Cueshé'},
  ];

  String playlistName = "Mylove's Playlist";

  void _removeSong(int index) {
    setState(() {
      songs.removeAt(index);
    });
    Navigator.pop(context);
  }

  void _shareSong(Map<String, String> song) async {
    final shareText =
        'Check out this song: ${song['title']} by ${song['artist']} 🎶';
    await Share.share(shareText);
    Navigator.pop(context);
  }

  void _addToLiked(Map<String, String> song) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${song['title']} added to liked songs!')),
    );
  }

  void _addToQueue(Map<String, String> song) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${song['title']} added to queue!')),
    );
  }

  void _addSong() {
    setState(() {
      songs.add({
        'title': 'New Song Title',
        'artist': 'New Artist',
      });
    });
    Navigator.pop(context);
  }

  void _openPlaylistOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.library_music, color: Colors.pinkAccent),
            title: const Text("Add Song"),
            onTap: _addSong,
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.pinkAccent),
            title: const Text("Share Playlist"),
            onTap: () async {
              await Share.share('Listen to my playlist: $playlistName 🎶');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.pinkAccent),
            title: const Text("Rename Playlist"),
            onTap: () {
              Navigator.pop(context);
              _showRenameDialog();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.redAccent),
            title: const Text("Delete Playlist"),
            onTap: () {
              Navigator.pop(context);
              _confirmDeletePlaylist();
            },
          ),
        ],
      ),
    );
  }

  void _showRenameDialog() {
    final controller = TextEditingController(text: playlistName);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rename Playlist'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter new name',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Rename'),
            onPressed: () {
              setState(() {
                playlistName = controller.text;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeletePlaylist() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Playlist'),
        content: const Text('Are you sure you want to delete this playlist?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              setState(() {
                songs.clear();
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with picture + back button + playlist info
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 60, left: 28, right: 16, bottom: 20), // moved left padding slightly inward (was 20)
                color: const Color(0xFFFFE4EC),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://scontent.fmnl17-6.fna.fbcdn.net/v/t39.30808-1/481795242_991437823048509_6335269304964202936_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=109&ccb=1-7&_nc_sid=e99d92&_nc_eui2=AeGFsp7ebzKn3M2zDCqkuY0osn1YigxAgaSyfViKDECBpFauuPY4veUDCzTsdJzzs0u5tfEpIamktgDfKUZcfQW5&_nc_ohc=buwgLvVQJkEQ7kNvwFsEHiL&_nc_oc=AdldrmJnYUX0fFzVOlqD2DthImJ5Y74MGWvfK9wvlIXnPnHM1aGM-lrDdpN0J-gHthM&_nc_zt=24&_nc_ht=scontent.fmnl17-6.fna&_nc_gid=ArtZ7iLLFhfSmfvJZhN52g&oh=00_AfSZe9_GbBSKNx0mxM4Gho_ctKHtDirfALB4U_5P2fpkwg&oe=68840E8B',
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  playlistName,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.black),
                                onPressed: _openPlaylistOptions,
                              ),
                            ],
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
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20), // nudged left padding inward from 10 to 20
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    leading: const Icon(Icons.music_note,
                        color: Colors.pinkAccent),
                    title: Text(
                      songs[index]['title']!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      songs[index]['artist']!,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.grey),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20)),
                          ),
                          builder: (_) => _buildSongOptions(
                              context, songs[index], index),
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
            leading: const Icon(Icons.share, color: Colors.pinkAccent),
            title: const Text("Share", style: TextStyle(color: Colors.black)),
            onTap: () => _shareSong(song),
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
            title: const Text("Add to Liked Songs",
                style: TextStyle(color: Colors.black)),
            onTap: () => _addToLiked(song),
          ),
          ListTile(
            leading: const Icon(Icons.queue_music, color: Colors.pinkAccent),
            title: const Text("Add to Queue",
                style: TextStyle(color: Colors.black)),
            onTap: () => _addToQueue(song),
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
