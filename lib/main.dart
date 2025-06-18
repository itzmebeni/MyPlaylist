import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          'MyPlaylist',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.yellowAccent[100],
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,  // Ensure texts are centered horizontally
          children: [
            // Text directly without container
            Text(
              'Demonyo - Juan Carlos',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.pink[200],  // Color to match previous container color
              ),
              textAlign: TextAlign.center,  // Center the text
            ),
            SizedBox(height: 10),
            // Another text widget
            Text(
              'Sino - Unique Salonga',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.purple[200],  // Color to match previous container color
              ),
              textAlign: TextAlign.center,  // Center the text
            ),
            SizedBox(height: 10),
            // Another text widget
            Text(
              'Beer - Itchyworms',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.pink[100],  // Color to match previous container color
              ),
              textAlign: TextAlign.center,  // Center the text
            ),
          ],
        ),
      ),
    ),
  ));
}
