import 'package:flutter/material.dart';
import 'Page/AddPlaylist.dart';
import 'Page/Dashboard.dart';
import 'Page/ListItems.dart';

void main() {
  runApp(MaterialApp(
    title: 'My Music App', // App title for consistency
    initialRoute: '/', // Setting the initial route
    routes: {
      '/': (context) => ListItems(),
      '/add': (context) => AddPlaylist(),
      //'/list': (context) => ListItems(), // Added the ListItems route
    },
  ));
}
