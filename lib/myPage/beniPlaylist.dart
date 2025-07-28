import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'liked_songs.dart'; // ✅ Import this

class BeniPlaylist extends StatefulWidget {
  final String initialName;

  const BeniPlaylist({super.key, required this.initialName});

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

  late String playlistName;

  @override
  void initState() {
    super.initState();
    playlistName = widget.initialName;
  }

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

  void _playNow(Map<String, String> song) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Now playing: ${song['title']}')),
    );
  }

  void _addSong() {
    setState(() {
      songs.add({'title': 'New Song Title', 'artist': 'New Artist'});
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
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Rename Playlist'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter new playlist name',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Rename', style: TextStyle(color: Colors.pinkAccent)),
            onPressed: () {
              final newName = controller.text.trim();

              if (newName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Playlist name cannot be empty')),
                );
                return;
              }

              setState(() {
                playlistName = newName;
              });

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Playlist renamed to "$playlistName"')),
              );
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
                  padding: const EdgeInsets.only(top: 60, left: 28, right: 16, bottom: 20),
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
                            Row(
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
                                  icon: const Icon(Icons.more_vert, color: Colors.black),
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
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      leading: const Icon(Icons.music_note, color: Colors.pinkAccent),
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
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (_) => _buildSongOptions(context, songs[index], index),
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
            leading: const Icon(Icons.share, color: Colors.pinkAccent),
            title: const Text("Share", style: TextStyle(color: Colors.black)),
            onTap: () => _shareSong(song),
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
            title: const Text("Add to Liked Songs", style: TextStyle(color: Colors.black)),
            onTap: () => _addToLiked(song),
          ),
          ListTile(
            leading: const Icon(Icons.play_arrow, color: Colors.pinkAccent),
            title: const Text("Play Now", style: TextStyle(color: Colors.black)),
            onTap: () => _playNow(song),
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.redAccent),
            title: const Text("Remove this Song from Playlist", style: TextStyle(color: Colors.black)),
            onTap: () => _removeSong(index),
          ),
        ],
      ),
    );
  }
}
