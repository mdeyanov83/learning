import 'package:flutter/material.dart';
import 'package:flutter_mapp/data/constants.dart';
import 'package:flutter_mapp/views/widgets/container_widget.dart';
import 'package:flutter_mapp/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(title: 'Flutter Mapp'),
            ContainerWidget()
          ],
        ),
      ),
    );
  }
}
