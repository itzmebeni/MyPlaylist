import 'package:flutter/material.dart';
import 'addplaylist.dart';
import 'Music.dart';
import 'ItemCard.dart';
import 'beniPlaylist.dart';
import 'liked_songs.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemState();
}

class _ListItemState extends State<ListItems> {
  List<Music> musics = [
    Music(name: 'Pangarap lang kita', artist: 'Parokya ni Edgar', rating: 5),
    Music(name: 'Buko', artist: 'Jireh Lim', rating: 5),
    Music(name: 'Kursunada', artist: 'Adie', rating: 5),
    Music(name: 'When I met you', artist: 'Apo Hiking Society', rating: 5),
    Music(name: 'Naiilang', artist: 'Le John', rating: 5),
    Music(name: 'Sino', artist: 'Unique Salonga', rating: 5),
    Music(name: 'With a Smile', artist: 'Eraserheads', rating: 5),
    Music(name: 'Borrowed Time', artist: 'Cueshé', rating: 5),
  ];

  String playlistName = "Beni's Playlist";
  List<Map<String, dynamic>> playlists = [];

  void _openLikedSongsScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LikedSongsScreen()),
    );
    setState(() {}); // Refresh count when returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Library",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Albums",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              AlbumCard(
                title: playlistName,
                count: musics.length,
                onTap: () async {
                  final updatedName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BeniPlaylist(initialName: playlistName),
                    ),
                  );

                  if (updatedName != null && updatedName is String) {
                    setState(() {
                      playlistName = updatedName;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),

              for (var playlist in playlists)
                AlbumCard(
                  title: playlist['name'],
                  count: playlist['count'] ?? 0,
                  onTap: () {},
                ),

              const SizedBox(height: 10),

              AlbumCard(
                title: "Liked Songs",
                count: LikedSongsManager.likedSongs.length,
                icon: Icons.favorite,
                onTap: () => _openLikedSongsScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;
  final IconData icon;

  const AlbumCard({
    super.key,
    required this.title,
    required this.count,
    required this.onTap,
    this.icon = Icons.album,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title),
        subtitle: Text('$count songs'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
