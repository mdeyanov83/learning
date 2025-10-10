import 'package:flutter/material.dart';
import 'package:flutter_mapp/data/notifiers.dart';
import 'package:flutter_mapp/views/pages/home_page.dart';
import 'package:flutter_mapp/views/pages/profile_page.dart';
import 'package:flutter_mapp/views/widgets/navbar_widget.dart';

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
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}
