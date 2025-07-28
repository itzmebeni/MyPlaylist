import 'package:flutter/material.dart';
import 'ListItems.dart';
import 'beniPlaylist.dart';
import 'liked_songs.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Playlist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.pinkAccent,
        fontFamily: 'Helvetica',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pinkAccent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontSize: 14),
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 13),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.pinkAccent,
          secondary: Colors.purpleAccent,
        ),
      ),
      home: const AppleMusicHomePage(),
      routes: {
        '/beni': (context) => BeniPlaylist(initialName: ''),
      },
    );
  }
}

class AppleMusicHomePage extends StatefulWidget {
  const AppleMusicHomePage({super.key});

  @override
  State<AppleMusicHomePage> createState() => _AppleMusicHomePageState();
}

class _AppleMusicHomePageState extends State<AppleMusicHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BrowsePage(),
    const SearchPage(),
    const LibraryPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
        ],
      ),
    );
  }
}

void playSong(BuildContext context, String title, String artist) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Now playing: $title by $artist'),
      duration: const Duration(seconds: 2),
    ),
  );
}

void showBottomSheetOptions(
    BuildContext context, String title, String artist, bool isSearch) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      final List<Map<String, dynamic>> options = isSearch
          ? [
        {'label': 'Play this Song', 'icon': Icons.play_arrow},
        {'label': 'Add to Liked Songs', 'icon': Icons.favorite_border},
        {'label': "Add to Beni's Playlist", 'icon': Icons.playlist_add},
      ]
          : [
        {'label': 'Play this Song', 'icon': Icons.play_arrow},
        {'label': 'Share', 'icon': Icons.share},
        {'label': 'Add to Liked Songs', 'icon': Icons.favorite_border},
        {'label': "Add to Beni's Playlist", 'icon': Icons.playlist_add},
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

                if (option['label'] == 'Play this Song') {
                  playSong(context, title, artist);
                } else if (option['label'] == 'Add to Liked Songs') {
                  // ✅ Add to liked songs if not already there
                  final alreadyLiked = LikedSongsManager.likedSongs.any(
                        (song) => song['title'] == title && song['artist'] == artist,
                  );
                  if (!alreadyLiked) {
                    LikedSongsManager.likedSongs.add({
                      'title': title,
                      'artist': artist,
                    });
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('"$title" added to Liked Songs')),
                  );
                } else if (option['label'] == "Add to Beni's Playlist") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('"$title" added to Beni\'s Playlist')),
                  );
                }
              },
            );
          }).toList(),
        ),
      );
    },
  );
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allSongs = [
    {'title': 'With a Smile', 'artist': 'Eraserheads'},
    {'title': 'Sino', 'artist': 'Unique Salonga'},
    {'title': 'Pangarap Lang Kita', 'artist': 'Parokya ni Edgar'},
    {'title': 'Buko', 'artist': 'Jireh Lim'},
    {'title': 'Kursunada', 'artist': 'Adie'},
    {'title': 'When I Met You', 'artist': 'Apo Hiking Society'},
  ];

  List<Map<String, String>> _filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _filteredSongs = List.from(_allSongs);
    _searchController.addListener(_filterSongs);
  }

  void _filterSongs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSongs = _allSongs.where((song) {
        return song['title']!.toLowerCase().contains(query) ||
            song['artist']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Widget musicCard(BuildContext context, String title, String artist, Color color) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
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
          onPressed: () => showBottomSheetOptions(context, title, artist, true),
        ),
        onTap: () => playSong(context, title, artist),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search for a song',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Recommended', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _filteredSongs.isEmpty
                  ? const Center(child: Text('No songs found', style: TextStyle(fontSize: 13)))
                  : ListView.builder(
                itemCount: _filteredSongs.length,
                itemBuilder: (context, index) {
                  final song = _filteredSongs[index];
                  return musicCard(
                      context, song['title']!, song['artist']!, _getColorForIndex(index));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

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
          onPressed: () => showBottomSheetOptions(context, title, artist, false),
        ),
        onTap: () => playSong(context, title, artist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Browse', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          musicCard(context, 'Pangarap Lang Kita', 'Parokya ni Edgar', Colors.pinkAccent),
          musicCard(context, 'Buko', 'Jireh Lim', Colors.purple[200]!),
          musicCard(context, 'Kursunada', 'Adie', Colors.blue[200]!),
          const SizedBox(height: 30),
          const Text('Recommended', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          musicCard(context, 'With a Smile', 'Eraserheads', Colors.orange[200]!),
          musicCard(context, 'Sino', 'Unique Salonga', Colors.pink[100]!),
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
