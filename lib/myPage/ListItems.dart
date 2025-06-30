import 'package:flutter/material.dart';
import 'Music.dart';
import 'ItemCard.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemState();
}

class _ListItemState extends State<ListItems> {
  List<Music> musics = [
    Music(name: 'Pangarap lang kita', artist: 'Parokya ni Edgar', rating: 10),
    Music(name: 'Buko', artist: 'Jireh Lim', rating: 10),
    Music(name: 'Kursunada', artist: 'Adie', rating: 10),
    Music(name: 'When I met you', artist: 'Apo Hiking Society', rating: 10),
    Music(name: 'Naiilang', artist: 'Le John', rating: 10),
    Music(name: 'Sino', artist: 'Unique Salonga', rating: 10),
    Music(name: 'With a Smile', artist: 'Eraserheads', rating: 10),
    Music(name: 'Borrowed Time', artist: 'Cueshé', rating: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Playlist',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: musics.map((music) {
            return Itemcard(musics: music);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          // Add your add-music logic here (e.g., show dialog, navigate to form, etc.)
        },
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Music',
      ),
    );
  }
}
