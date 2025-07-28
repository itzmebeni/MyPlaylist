import 'package:flutter/material.dart';

// Screens from the myPage folder
import 'myPage/Dashboard.dart';
import 'myPage/ListItems.dart';
import 'myPage/beniPlaylist.dart';
import 'myPage/addplaylist.dart';
import 'myPage/liked_songs.dart'; // contains LikedSongsScreen

void main() {
  runApp(const MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  const MyMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.pinkAccent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.pinkAccent,
        ),
        fontFamily: 'Arial',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Dashboard(),
        '/list': (context) => const ListItems(),
        '/beni': (context) => BeniPlaylist(initialName: ''),
        '/likedsongs': (context) => const LikedSongsScreen(), // ✅ fixed
      },
    );
  }
}
