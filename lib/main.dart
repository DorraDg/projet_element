import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/affichageelementviews.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet Element',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AffichageElementViews(),
    );
  }
}
