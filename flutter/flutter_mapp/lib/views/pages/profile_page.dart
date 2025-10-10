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
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text('Element 1'),
                ),
                DropdownMenuItem(
                  child: Text('Element 2'),
                ),
                DropdownMenuItem(
                  child: Text('Element 3'),
                ),
              ],
              onChanged: (value) {},
            ),
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
            Slider(
              max: 10.0,
              value: sliderValue,
              divisions: 10,
              label: '$sliderValue',
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            GestureDetector(
              child: Image.asset(
                'assets/images/background.jpg',
              ),
              onTap: () {
                print('tap');
              },
            ),
            InkWell(
              splashColor: Colors.teal,
              onTap: () {
                print('container tapped');
              },
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.white12,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: Text('Click me'),
            ),
            BackButton(
              onPressed: () {},
            ),
            CloseButton(
              onPressed: () {},
            ),
            FilledButton(
              onPressed: () {},
              child: Text('Click me'),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Click me'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
