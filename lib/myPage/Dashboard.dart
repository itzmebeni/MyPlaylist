import 'package:flutter/material.dart';
import 'ListItems.dart'; // Ensure path is correct
import 'beniPlaylist.dart'; // ✅ Import BeniPlaylist screen

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
            fontSize: 24, // smaller than 28
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
        '/beni': (context) => BeniPlaylist(), // ✅ Route for Beni's Playlist
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
    {'title': 'Bakit Pa', 'artist': 'Jessa Zaragoza'},
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

  Widget musicCard(String title, String artist, Color color) {
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
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(artist, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.more_horiz, color: Colors.black),
        onTap: () {
          debugPrint('Playing $title by $artist');
        },
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
            // Centered Search Bar
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

            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommended',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),

            // Song List
            Expanded(
              child: _filteredSongs.isEmpty
                  ? const Center(child: Text('No songs found', style: TextStyle(fontSize: 13)))
                  : ListView.builder(
                itemCount: _filteredSongs.length,
                itemBuilder: (context, index) {
                  final song = _filteredSongs[index];
                  return musicCard(
                    song['title']!,
                    song['artist']!,
                    _getColorForIndex(index),
                  );
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

  Widget musicCard(String title, String artist, Color color) {
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
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(artist, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.more_horiz, color: Colors.black),
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
          musicCard('Pangarap Lang Kita', 'Parokya ni Edgar', Colors.pinkAccent),
          musicCard('Buko', 'Jireh Lim', Colors.purple[200]!),
          musicCard('Kursunada', 'Adie', Colors.blue[200]!),
          const SizedBox(height: 30),
          const Text('Recommended', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          musicCard('With a Smile', 'Eraserheads', Colors.orange[200]!),
          musicCard('Sino', 'Unique Salonga', Colors.pink[100]!),
        ],
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListItems(); // ✅ List page
  }
}
