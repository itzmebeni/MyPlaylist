import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_beni/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _setupWorldTime();
  }

  Future<void> _setupWorldTime() async {
    final instance = WorldTime(
      location: 'Berlin',
      flag: 'germany.png',
      url: 'Europe/Berlin',
    );

    await instance.getTime();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF002366),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}