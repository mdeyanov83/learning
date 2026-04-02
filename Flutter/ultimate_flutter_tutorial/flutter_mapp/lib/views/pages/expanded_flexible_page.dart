import 'package:flutter/material.dart';

class ExpandedFlexiblePage extends StatelessWidget {
  const ExpandedFlexiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 20,
                  child: Text('Hello'),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.orange,
                  height: 20,
                  child: Text('Hello'),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.orange,
                  height: 20,
                  child: Text('Hello'),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 20,
                  child: Text('Hello'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
