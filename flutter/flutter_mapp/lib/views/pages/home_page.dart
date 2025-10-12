import 'package:flutter/material.dart';
import 'package:flutter_mapp/views/widgets/container_widget.dart';
import 'package:flutter_mapp/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(title: 'Flutter Mapp'),
            List.generate(
              5,
              ContainerWidget(
                title: 'Basic Layout',
                description: 'This is a description',
              ),
            ),

            
            ContainerWidget(
              title: 'Basic Layout',
              description: 'This is a description',
            ),
          ],
        ),
      ),
    );
  }
}
