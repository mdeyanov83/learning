import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Mapp'),
          centerTitle: true,
          leading: Icon(Icons.login),
          actions: [
            Text('action1'),
            Icon(Icons.local_activity_outlined),
          ],
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
