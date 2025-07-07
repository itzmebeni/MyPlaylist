import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  Future<void> _editLocation() async {
    final result = await Navigator.pushNamed(
      context,
      '/location',
    );


    if (!mounted || result == null) return;

    setState(() {
      data = Map<String, dynamic>.from(result as Map);
    });

  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : Map<String, dynamic>.from(
      ModalRoute.of(context)?.settings.arguments as Map? ?? {},
    );

    final bool isDaytime = data['isDaytime'] ?? true;
    final String bgImage = isDaytime ? 'day.png' : 'night.png';
    final Color? bgColor = isDaytime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: _HomeContent(
          data: data,
          bgImage: bgImage,
          onEdit: _editLocation,
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final Map data;
  final String bgImage;
  final VoidCallback onEdit;

  const _HomeContent({
    required this.data,
    required this.bgImage,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
        child: Column(
          children: <Widget>[
            TextButton.icon(
              onPressed: onEdit,
              icon: Icon(Icons.edit_location, color: Colors.grey[300]),
              label: Text(
                'Edit Location',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data['location'] ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              data['time'] ?? '',
              style: const TextStyle(
                fontSize: 66.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}