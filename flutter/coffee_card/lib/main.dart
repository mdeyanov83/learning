import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Coffee Id'),
          backgroundColor: Colors.brown[700],
          centerTitle: true,
        ),
        body: Center(
          child: Text('Hello, Ninjas'),
        ),
      ),
    ),
  );
}
