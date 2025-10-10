import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onEditingComplete: () {
              setState(() {});
            },
          ),
          Text(controller.text),
          Checkbox(
            tristate: true,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
          CheckboxListTile.adaptive(
            tristate: true,
            title: Text('Click me'),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
          Switch(
            value: isSwitched,
            onChanged: (bool value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
          SwitchListTile.adaptive(
            title: Text('Switch me'),
            value: isSwitched,
            onChanged: (bool value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
