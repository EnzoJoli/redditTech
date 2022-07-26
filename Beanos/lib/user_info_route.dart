import 'dart:io';
import 'dart:convert';
import 'package:beanos/user_class.dart';
import 'access_token_uses.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<AccountInfo> getUserInfo() async {
  var headers = {
    'Authorization': 'Bearer ' + token.accessToken
  };
  var request = http.Request('GET', Uri.parse('https://oauth.reddit.com/api/v1/me/'));

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return AccountInfo.fromJson(jsonDecode(await response.stream.bytesToString()));
  }
  else {
    throw Exception('Failed to get user info');;
  }
}
