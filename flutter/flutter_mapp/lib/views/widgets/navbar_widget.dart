import 'package:flutter/material.dart';
import 'package:flutter_mapp/data/notifiers.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: builder,
    );
  }
}

// class _NavBarWidgetState extends State<NavBarWidget> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: selectedPageNotifier,
//       builder: (context, value, child) {
//         return NavigationBar(
//               destinations: [
//                 NavigationDestination(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 NavigationDestination(
//                   icon: Icon(Icons.person),
//                   label: 'Profile',
//                 ),
//               ],
//               onDestinationSelected: (int value) {
//                 setState(() {
//                   selectedIndex = value;
//                 });
//               },
//               selectedIndex: selectedIndex,
//             );
//       }
//     );
//   }
// }
