import 'package:flutter/material.dart';
//worldtime


import 'choose_location.dart';
import 'home.dart';
import 'loading.dart';


void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes:{

        //worldtime
        '/': (context) => const Loading(),
        '/home': (context) => const Home(),
        '/location': (context) => const ChooseLocation(),
      }
  ));
}