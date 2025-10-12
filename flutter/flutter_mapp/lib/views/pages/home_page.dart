import 'package:flutter/material.dart';
import 'package:flutter_mapp/data/constants.dart';
import 'package:flutter_mapp/views/widgets/container_widget.dart';
import 'package:flutter_mapp/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List list = [
      KValue.basicLayout,
      KValue.cleanUi,
      KValue.fixBugs,
      KValue.keyConcepts,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(title: 'Flutter Mapp'),
            ...List.generate(
              list.length,
              (index) => ContainerWidget(
                title: list.elementAt(index),
                description: 'This is a description',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
