import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.title,
    this.nextPage,
  });

  final String title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return nextPage!;
                  },
                ),
              );
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: 'hero1',
            child: AspectRatio(
              aspectRatio: 16/9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.cover,
                  color: Colors.teal,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 50.0,
                letterSpacing: 50.0,
                color: Colors.white30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
