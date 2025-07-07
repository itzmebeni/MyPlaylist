import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class WorldTime {
  final String location;
  final String flag;
  final String url;

  late String time;
  late bool isDaytime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      final res = await http.get(
        Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'),
      );

      final data = jsonDecode(res.body);
      final datetime = DateTime.parse(data['dateTime']);

      isDaytime = datetime.hour >= 6 && datetime.hour < 18;
      time = DateFormat.jm().format(datetime);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error fetching time: $e');
      }
      time = 'failed';
      isDaytime = true;
    }
  }
}