import 'package:flutter/material.dart';

void main() {
  runApp(const MySpotifyApp());
}

class MySpotifyApp extends StatelessWidget {
  const MySpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      theme: ThemeData.dark(),
      home: const SpotifyHomePage(),
    );
  }
}

class SpotifyHomePage extends StatefulWidget {
  const SpotifyHomePage({super.key});

  @override
  State<SpotifyHomePage> createState() => _SpotifyHomePageState();
}

class _SpotifyHomePageState extends State<SpotifyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          _currentIndex == 0
              ? 'Home'
              : _currentIndex == 1
              ? 'Search'
              : 'Your Library',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget musicCard(String title, String artist, Color color) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.music_note, color: Colors.white, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          artist,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.more_vert, color: Colors.white),
        onTap: () {
          debugPrint('Playing $title by $artist');
          // You can navigate to a "Now Playing" screen here
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Recently Played',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        musicCard('Demonyo', 'Juan Karlos', Colors.purple),
        musicCard('Sino', 'Unique Salonga', Colors.green),
        musicCard('Beer', 'Itchyworms', Colors.blue),
        const SizedBox(height: 30),
        const Text(
          'Made for You',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 16),
        musicCard('Buwan', 'Juan Karlos', Colors.orange),
        musicCard('Mundo', 'IV of Spades', Colors.redAccent),
      ],
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search your favorite music',
        style: TextStyle(fontSize: 18, color: Colors.white70),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Your saved playlists and albums',
        style: TextStyle(fontSize: 18, color: Colors.white70),
      ),
    );
  }
}
