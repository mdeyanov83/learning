import 'package:coffee_card/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      // home: Sandbox(),
    ),
  );
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        backgroundColor: Colors.grey,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            color: Colors.red,
            child: const Text('one'),
          ),
          Container(
            height: 200,
            color: Colors.green,
            child: const Text('two'),
          ),
          Container(
            height: 300,
            color: Colors.blue,
            child: const Text('three'),
          ),
          Image.asset('assets/img/coffee_bg - orig.jpg'),
        ],
      ),
    );
  }
}
