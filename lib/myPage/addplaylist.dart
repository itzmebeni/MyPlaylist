import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPlaylist extends StatefulWidget {
  const AddPlaylist({super.key});

  @override
  State<AddPlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<AddPlaylist> {
  final TextEditingController _playlistNameController = TextEditingController();
  final TextEditingController _searchSongController = TextEditingController();

  File? _playlistImage;
  final ImagePicker _picker = ImagePicker();

  List<String> addedSongs = [];
  List<String> recommendedSongs = [
    'With a Smile - Eraserheads',
    'Buko - Jireh Lim',
    'Naiilang - Le John',
    'Sino - Unique Salonga',
  ];
  List<String> favoriteSongs = [
    'Pangarap Lang Kita - Parokya ni Edgar',
    'Kursunada - Adie',
    'When I Met You - Apo Hiking Society',
    'Borrowed Time - Cueshé',
  ];
  String? selectedFavorite;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _playlistImage = File(picked.path));
    }
  }

  void addSong(String song) {
    if (!addedSongs.contains(song)) {
      setState(() => addedSongs.add(song));
    }
  }

  void removeSong(String song) {
    setState(() => addedSongs.remove(song));
  }

  @override
  Widget build(BuildContext context) {
    const pink = Colors.pinkAccent;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Playlist',
          style: TextStyle(
            color: pink,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: pink),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Picker
            Center(
              child: Column(
                children: [
                  _playlistImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _playlistImage!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: pink),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.music_note, size: 50, color: pink),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Add a Photo',
                      style: TextStyle(color: pink, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Playlist Name
            TextFormField(
              controller: _playlistNameController,
              decoration: const InputDecoration(
                labelText: 'Playlist Name',
                labelStyle: TextStyle(color: Colors.pink),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: pink),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Favorite Dropdown
            DropdownButtonFormField<String>(
              value: selectedFavorite,
              items: favoriteSongs
                  .map((song) => DropdownMenuItem(
                value: song,
                child: Text(song),
              ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Add a song from your favorites',
                labelStyle: TextStyle(color: Colors.pink),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: pink),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  addSong(value);
                  setState(() => selectedFavorite = null);
                }
              },
            ),
            const SizedBox(height: 16),

            // Search Song
            TextFormField(
              controller: _searchSongController,
              decoration: const InputDecoration(
                hintText: 'Search for a song',
                prefixIcon: Icon(Icons.search, color: pink),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: pink),
                ),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  addSong(value);
                  _searchSongController.clear();
                }
              },
            ),
            const SizedBox(height: 16),

            // Added Songs Box
            if (addedSongs.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: pink),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Added Songs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: pink,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...addedSongs.map(
                          (song) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.music_note, color: pink),
                        title: Text(song),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: pink),
                          onPressed: () => removeSong(song),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Recommended Header
            const Text(
              'Recommended',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Recommended Songs
            ...recommendedSongs.map((song) {
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.music_note, color: pink),
                  title: Text(song.split(' - ')[0]),
                  subtitle: Text(song.split(' - ')[1]),
                  trailing: TextButton(
                    onPressed: () => addSong(song),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: pink),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 30),

            // Create Playlist Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save the playlist logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Create Playlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
