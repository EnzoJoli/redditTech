import 'dart:convert';
import 'package:beanos/profil.dart';
import 'package:beanos/subreddit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'my_sub_reddit.dart';
import 'settings_class.dart';
import 'access_token_uses.dart';

//void main() => runApp(MyApp());
class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  late Future<Settings> accountSettings = _getSettingsInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Beanos"),
      ),
      body: Center(
          child: FutureBuilder<Settings>(
              future: accountSettings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      SwitchListTile(
                        value: snapshot.data!.over_18,
                        onChanged: (value) {
                          setState(() {
                            _setUserSettings({"over_18": value.toString()});
                            accountSettings = _getSettingsInfo();
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        title: const Text("+18 contents"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile(
                        value: snapshot.data!.emailCommentReply,
                        onChanged: (value) {
                          setState(() {
                            _setUserSettings({"email_content_reply": value.toString()});
                            accountSettings = _getSettingsInfo();
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        title: const Text("Email Content Reply"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile(
                        value: snapshot.data!.enableFollowers,
                        onChanged: (value) {
                          setState(() {
                            _setUserSettings({"enable_followers": value.toString()});
                            accountSettings = _getSettingsInfo();
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        title: const Text("Enable Followers"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile(
                        value: snapshot.data!.legacySearch,
                        onChanged: (value) {
                          setState(() {
                            _setUserSettings({"legacy_search": value.toString()});
                            accountSettings = _getSettingsInfo();
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        title: const Text("Legacy Search"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile(
                        value: snapshot.data!.monitorMentions,
                        onChanged: (value) {
                          setState(() {
                            _setUserSettings({"monitor_mentions": value.toString()});
                            accountSettings = _getSettingsInfo();
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        title: const Text("Monitor Mentions"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile(
                        value: snapshot.data!.videoAutoplay,
                        onChanged: (value) {
                          setState(() {
                            _setUserSettings({"video_auto_replay": value.toString()});
                            accountSettings = _getSettingsInfo();
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        title: const Text("Video Auto Replay"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator(
                  color: Colors.deepOrange,
                );
              })),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<Settings> _getSettingsInfo() async {
    final response = await http.get(
      Uri.parse('https://oauth.reddit.com/api/v1/me/prefs'),
      headers: {
        "Authorization": 'bearer ' + token.accessToken,
      },
    );

    if (response.statusCode == 200) {
      return Settings.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user info');
    }
  }
  void _setUserSettings(final Map<String, String> value) async {
    final response = await http.patch(
      Uri.parse('https://oauth.reddit.com/api/v1/me/prefs'),
      headers: {
        "authorization": 'bearer ' + token.accessToken,
        "content-type": 'application/json',
      },
      body: json.encode(value),
    );
    print(response.body);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to set user settings');
    }
  }
}
