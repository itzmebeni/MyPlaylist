import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(home: Profile()));
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 125,
                    color: Colors.pinkAccent[100],
                  ),
                ),
                SizedBox(height: 30),

                Text(
                  'Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Vincent Bagunas',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(height: 20),

                Text(
                  'Email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '22-10506@g.batstate-u.edu.ph',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(height: 20),

                Text(
                  'Company',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Batangas State University',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(height: 20),

                Text(
                  'Contact Number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '09269831084',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Logout button at bottom center with icon
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logout logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent[100],
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                icon: Icon(Icons.logout, color: Colors.white, size: 20),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
