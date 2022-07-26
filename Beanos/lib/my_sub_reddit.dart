import 'package:beanos/profil.dart';
import 'package:beanos/settings.dart';
import 'package:beanos/subReddit_template.dart';
import 'package:beanos/subreddit.dart';
import 'package:flutter/material.dart';

class MySubReddit extends StatefulWidget {
  const MySubReddit({Key? key}) : super(key: key);

  @override
  _MySubReddit createState() => _MySubReddit();
}

class _MySubReddit extends State<MySubReddit> {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          return component1(' ', 'Beanos', 'eskeitt', 'qweqweqwe', 2);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.tab),
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SubRedditSearch()));},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.book),
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MySubReddit()));},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}