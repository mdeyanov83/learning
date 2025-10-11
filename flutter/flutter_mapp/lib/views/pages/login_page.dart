import 'package:flutter/material.dart';
import 'package:flutter_mapp/views/widget_tree.dart';
import 'package:flutter_mapp/views/widgets/hero_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPw = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            HeroWidget(
              title: 'Login',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: controllerEmail,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onEditingComplete: () {
                setState(() {});
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: controllerPw,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onEditingComplete: () {
                setState(() {});
              },
            ),
            SizedBox(height: 20.0),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WidgetTree();
                    },
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
