import 'package:flutter/material.dart';

Widget component1(
    String icon, String title, String description, String subTitle, int subscribed) {
  return Container(
      child: Card (
        child: SingleChildScrollView(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Image.network(icon), // no matter how big it is, it won't overflow
              ),
              title: Text(title),
              subtitle: Text(description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(subTitle),
                SizedBox(width: 8),
                Text("$subscribed"),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
  ));
}