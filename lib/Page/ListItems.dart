import 'package:flutter/material.dart';
import 'AddPlaylist.dart';
import 'Music.dart';
import 'ItemCard.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent, // changed to pink
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Playlist',
          style: TextStyle(
            color: Colors.white, // text now white for contrast
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> const AddPlaylist())
          );
          // Add your add-music logic here (e.g., show dialog, navigate to form, etc.)
        },
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Music',
      ),
    );
  }
}