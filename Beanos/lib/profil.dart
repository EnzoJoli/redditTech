import 'package:beanos/settings.dart';
import 'package:beanos/subreddit.dart';
import 'package:beanos/user_class.dart';
import 'package:beanos/user_info_route.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'my_sub_reddit.dart';
import 'user_class.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}): super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<AccountInfo> accountInfo;

  @override
  void initState() {
    super.initState();
    accountInfo = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder<AccountInfo>(
                future: accountInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        Container(child: Center(child: Image(
                            image: NetworkImage(
                                snapshot.data!.userInfo.profilePicture.split('?')[0])))),
                        Container(
                            child: Center(
                                child: Text(snapshot.data!.userInfo.name))),
                        const SizedBox(height: 30),
                        Container(
                            child: Center(
                                child: Text(
                                    snapshot.data!.userInfo.description)))
                      ],
                    );
                  }
                  else {
                    return Text('${snapshot.error}');
                  }
                }

            ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: IconButton(icon: Icon(Icons.home), onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage()));},),),
              Expanded(child: IconButton(icon: Icon(Icons.tab), onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SubRedditSearch()));  },),),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.book),
                  onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MySubReddit()));},
                ),
              ),
               Expanded(child: IconButton(icon: Icon(Icons.settings), onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));  },),),
            ],
          ),
        )
    );
  }
}