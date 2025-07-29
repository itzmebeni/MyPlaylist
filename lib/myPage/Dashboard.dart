import 'package:flutter/material.dart';
import 'ListItems.dart';
import 'beniPlaylist.dart';
import 'liked_songs.dart';

// -------------------- HOME PAGE --------------------
class HomePage extends StatefulWidget {
  final List<Map<String, String>> songs;
  final void Function(String, String) addSong;
  final void Function(String) removeSong;

  const HomePage({
    super.key,
    required this.songs,
    required this.addSong,
    required this.removeSong,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _filteredSongs = List.from(widget.songs);
    _searchController.addListener(_filterSongs);
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _filterSongs();
  }

  void _filterSongs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSongs = widget.songs.where((song) {
        return song['title']!.toLowerCase().contains(query) ||
            song['artist']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Color _getColorForIndex(int index) {
    final colors = [
      Colors.pinkAccent,
      Colors.purple[200]!,
      Colors.blue[200]!,
      Colors.orange[200]!,
      Colors.pink[100]!,
      Colors.green[200]!,
    ];
    return colors[index % colors.length];
  }

  Widget musicCard(BuildContext context, String title, String artist, Color color) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.music_note, color: Colors.white, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(artist, style: const TextStyle(fontSize: 12)),
        trailing: IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black),
          onPressed: () => showBottomSheetOptions(
            context,
            title,
            artist,
            widget.removeSong,
            refresh: () => setState(() {}),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text('My Musics', style: TextStyle(fontSize: 32, color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
          ),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search for a song or artist',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
          const SizedBox(height: 20),
          if (_filteredSongs.isEmpty)
            const Center(child: Text('No songs found')),
          for (int i = 0; i < _filteredSongs.length; i++)
            musicCard(context, _filteredSongs[i]['title']!, _filteredSongs[i]['artist']!, _getColorForIndex(i)),
        ],
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ListItems();
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Map<String, String>> _songs = [
    {'title': 'Pangarap Lang Kita', 'artist': 'Parokya ni Edgar'},
    {'title': 'Buko', 'artist': 'Jireh Lim'},
    {'title': 'Kursunada', 'artist': 'Adie'},
    {'title': 'With a Smile', 'artist': 'Eraserheads'},
    {'title': 'Sino', 'artist': 'Unique Salonga'},
  ];

  void _addSong(String title, String artist) {
    setState(() {
      _songs.insert(0, {'title': title, 'artist': artist});
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$title" added successfully!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeSong(String title) {
    setState(() {
      _songs.removeWhere((song) => song['title'] == title);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed "$title"')),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showAddSongPopup(BuildContext context) {
    final titleController = TextEditingController();
    final artistController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a Song'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Song Title')),
            TextField(controller: artistController, decoration: const InputDecoration(labelText: 'Artist')),
          ],
        ),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              final artist = artistController.text.trim();
              if (title.isNotEmpty && artist.isNotEmpty) {
                Navigator.pop(context);
                _addSong(title, artist);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(songs: _songs, addSong: _addSong, removeSong: _removeSong),
      const LibraryPage(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music List',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.pinkAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pinkAccent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.grey,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Music List'),
          actions: _currentIndex == 0
              ? [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddSongPopup(context),
            ),
          ]
              : null,
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          ],
        ),
      ),
    );
  }
}

// -------------------- BOTTOM SHEET --------------------
void showBottomSheetOptions(
    BuildContext context,
    String title,
    String artist,
    void Function(String) removeSong, {
      VoidCallback? refresh,
    }) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      final List<Map<String, dynamic>> options = [
        {'label': 'Add to Liked Songs', 'icon': Icons.favorite_border},
        {'label': "Add to Beni's Playlist", 'icon': Icons.playlist_add},
        {'label': 'Remove This Song', 'icon': Icons.delete},
      ];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              leading: Icon(option['icon'], color: Colors.pinkAccent),
              title: Text(option['label']),
              onTap: () {
                Navigator.pop(context);
                if (option['label'] == 'Add to Liked Songs') {
                  final alreadyLiked = LikedSongsManager.likedSongs.any(
                        (song) => song['title'] == title && song['artist'] == artist,
                  );
                  if (!alreadyLiked) {
                    LikedSongsManager.likedSongs.add({'title': title, 'artist': artist});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"$title" added to Liked Songs')),
                    );
                  }
                } else if (option['label'] == "Add to Beni's Playlist") {
                  final alreadyExists = BeniPlaylistManager.songs.any(
                        (song) => song['title'] == title && song['artist'] == artist,
                  );
                  if (!alreadyExists) {
                    BeniPlaylistManager.songs.add({'title': title, 'artist': artist});
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('"$title" added to Beni\'s Playlist')),
                  );
                } else if (option['label'] == "Remove This Song") {
                  removeSong(title);
                  if (refresh != null) refresh();
                }
              },
            );
          }).toList(),
        ),
      );
    },
  );
}
