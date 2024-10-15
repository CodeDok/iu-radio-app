import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:radio_app/screens/home/home_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iu-radio-app',
      home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Chip(
          label: Text(
            'Radio Station',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          side: BorderSide.none,
        ),
      ),
      body: HomeScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
    );
  }
}
