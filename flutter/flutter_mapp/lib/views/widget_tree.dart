import 'package:flutter/material.dart';
import 'package:flutter_mapp/widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Mapp'),
        ),
        bottomNavigationBar: NavBarWidget(),
      );
  }
}
