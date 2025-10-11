import 'package:flutter/material.dart';
import 'package:flutter_mapp/views/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Flutter Mapp', style: KTextStyle.titleTealText,),
            FittedBox(
              child: Text(
                'Flutter Mapp',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 50,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Lottie.asset('assets/lotties/welcome.json'),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  40.0,
                ),
              ),
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  40.0,
                ),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
