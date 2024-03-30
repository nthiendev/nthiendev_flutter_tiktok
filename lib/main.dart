import 'package:flutter/material.dart';
import 'package:nthiendev_flutter_tiktok/service_locator.dart';
import 'package:nthiendev_flutter_tiktok/views/feed_screen.dart';

Future<void> main() async {
  setUp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedScreen(),
  ));
}
