import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_map_practice_app/homepage.dart';
import 'package:google_map_practice_app/map_sample.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: HomePage(),
    );
  }
}
