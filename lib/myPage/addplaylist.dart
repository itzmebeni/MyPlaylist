import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
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
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  List<String> addedSongs = [];
  List<String> allRecommendedSongs = [
    'With a Smile - Eraserheads',
    'Buko - Jireh Lim',
    'Naiilang - Le John',
    'Sino - Unique Salonga',
    'Pangarap Lang Kita - Parokya ni Edgar',
    'Kursunada - Adie',
    'When I Met You - Apo Hiking Society',
    'Borrowed Time - Cueshé',
  ];

  List<String> filteredRecommendedSongs = [];

  @override
  void initState() {
    super.initState();
    filteredRecommendedSongs = List.from(allRecommendedSongs);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _webImage = bytes;
        });
      } else {
        setState(() {
          _playlistImage = File(picked.path);
        });
      }
    }
  }

  void addSong(String song) {
    if (!addedSongs.contains(song)) {
      setState(() {
        addedSongs.add(song);
      });
    }
  }

  void removeSong(String song) {
    setState(() => addedSongs.remove(song));
  }

  void _filterSongs(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRecommendedSongs = List.from(allRecommendedSongs);
      } else {
        filteredRecommendedSongs = allRecommendedSongs
            .where((song) => song.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _handleCreatePlaylist() async {
    String playlistName = _playlistNameController.text.trim();

    if (playlistName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a playlist name'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure you want to create this playlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
            ),
            child: const Text(
              'Create',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm) {
      Navigator.pop(context, {
        'name': playlistName,
        'count': addedSongs.length,
      });

      // Show success message after short delay (after returning to previous screen)
      Future.delayed(const Duration(milliseconds: 300), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Created Playlist'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
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
                  _playlistImage != null || _webImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: kIsWeb
                        ? Image.memory(
                      _webImage!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
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
                    child: const Icon(Icons.music_note,
                        size: 50, color: pink),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Add a Photo',
                      style:
                      TextStyle(color: pink, fontWeight: FontWeight.bold),
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

            // Search Song
            TextFormField(
              controller: _searchSongController,
              onChanged: _filterSongs,
              decoration: const InputDecoration(
                hintText: 'Search for a song',
                prefixIcon: Icon(Icons.search, color: pink),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: pink),
                ),
              ),
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
            ...filteredRecommendedSongs.map((song) {
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
                onPressed: _handleCreatePlaylist,
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
