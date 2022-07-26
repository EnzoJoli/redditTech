import 'dart:convert';
import 'package:beanos/my_sub_reddit.dart';
import 'package:beanos/profil.dart';
import 'package:beanos/settings.dart';
import 'package:beanos/subReddit_template.dart';
import 'package:beanos/subreddit_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'access_token_uses.dart';

class SubRedditSearch extends StatefulWidget {
  const SubRedditSearch({Key? key}) : super(key: key);

  @override
  _SubRedditSearch createState() => _SubRedditSearch();
}

class _SubRedditSearch extends State<SubRedditSearch> {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _controller.clear),
                          hintText: 'Search a Subreddit',
                          border: InputBorder.none),
                    )))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                    strSubReddit: _controller.text.toString(),
                  )),
            );
          },
          child: const Icon(Icons.navigate_next),
        ),
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

class Result extends StatefulWidget {
  late Future<SubReddit> subreddit;
  String strSubReddit = '';
  Result({Key? key, required this.strSubReddit}) : super(key: key);

  @override
  _Result createState() => _Result();
}

class _Result extends State<Result> {
  late Future<SubReddit> subRlist;
  final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );

  @override
  void initState() {
    super.initState();
    subRlist = _getSubRedditAbout(widget.strSubReddit);
  }
  Widget displaySubreddit(BuildContext context, Future<SubReddit> subreddit) {
    return Center(
        child: FutureBuilder<SubReddit>(
            future: subreddit,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return component1(snapshot.data!.headerImg, snapshot.data!.title, snapshot.data!.description, snapshot.data!.name, snapshot.data!.nbSub);
              }
              else {
                return const Text("TEst");
              }
            }
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: displaySubreddit(context, subRlist)
    );
  }
  static Future<SubReddit> _getSubRedditAbout(String subReddit) async {
    final response = await http.get(
      Uri.parse('https://oauth.reddit.com/r/' + subReddit + '/about'),
      headers: {
        "Authorization": 'bearer ' + token.accessToken,
      },
    );
    if (response.statusCode == 200) {
      return Data.fromJson(jsonDecode(response.body), "subscribe").subReddit;
    } else {
      throw Exception('Failed to get subreddit');
    }
  }
}

