import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mapp/data/classes/activity_class.dart';
import 'package:flutter_mapp/views/widgets/hero_widget.dart';
import 'package:http/http.dart' as http;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Future _activityFuture;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    _activityFuture = getData();
  }

  Future getData() async {
    var url = Uri.https(
      'bored-api.appbrewery.com',
      '/random',
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return Activity.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFirst = !isFirst;
              });
            },
            icon: Icon(Icons.switch_access_shortcut),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _activityFuture,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            Activity activity = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: AnimatedCrossFade(
                  firstChild: Column(
                    children: [
                      HeroWidget(
                        title: activity.activity,
                      ),
                      Text(
                        'Activity: ${activity.activity}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Text('Type: ${activity.type}'),
                      Text('Participants: ${activity.participants}'),
                      Text('Price: ${activity.price}'),
                      Text('Availability: ${activity.availability}'),
                      Text('Accessibility: ${activity.accessibility}'),
                      Text('Duration: ${activity.duration}'),
                      Text(
                        'Kid-Friendly: ${activity.kidFriendly ? 'Yes' : 'No'}',
                      ),
                    ],
                  ),
                  secondChild: Center(
                    child: Image.asset('assets/images/background.jpg'),
                  ),
                  crossFadeState: isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 700),
                ),
              ),
            );
          } else {
            return Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
