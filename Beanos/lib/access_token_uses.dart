import 'dart:async';
import 'dart:convert';
import 'package:beanos/profil.dart';
import 'package:flutter/material.dart';
import 'access_token_class.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

AccessToken token = AccessToken.init();

class AuthWebView extends StatefulWidget {
  const AuthWebView({Key? key}) : super(key: key);

  @override
  _AuthWebView createState() => _AuthWebView();
}

class _AuthWebView extends State<AuthWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text('Connect to Reddit')),
          backgroundColor: Colors.deepOrange),
      body: WebView(
        userAgent: "random",
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: _getTokenUrl(),
        onPageFinished: (url) async {
          if (url.startsWith("http://localhost:42420/")) {
            await _stockAccessToken(_getTokenId(url));
            Navigator.pop(context, "");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const ProfilePage()));
          }
        },
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }

  _stockAccessToken(final String idToken) async {
    AccessToken tokenBuffer = await _getAccessToken(idToken);
    token = AccessToken.update(tokenBuffer.accessToken, tokenBuffer.tokenType,
        tokenBuffer.expiresIn, tokenBuffer.refreshToken, tokenBuffer.scope);
    print("token ${token.accessToken}, ${token.expiresIn}");
  }

  static Future<AccessToken> _getAccessToken(String idToken) async {
    String username = '6dDuuMTSQbhDHMhJjvnuFQ';
    String password = '';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.post(
      Uri.parse('https://www.reddit.com/api/v1/access_token'),
      headers: {
        'Authorization': basicAuth,
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "grant_type": "authorization_code",
        "code": idToken,
        "redirect_uri": "http://localhost:42420/"
      },
    );
    if (response.statusCode == 200) {
      return AccessToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get access token');
    }
  }

  static String _getTokenId(String url) {
    List<String> list = url.split("=");
    list.last = list.last.substring(0, list.last.length - 2);
    return list.last;
  }

  static String _getTokenUrl() {
    const clientId = "6dDuuMTSQbhDHMhJjvnuFQ";
    const randomStr = "randomString";
    const redirectUri = "http://localhost:42420/";
    const scope = "*";
    return ('https://www.reddit.com/api/v1/authorize.compact?client_id=' +
        clientId +
        '&response_type=code&state=' +
        randomStr +
        '&redirect_uri=' +
        redirectUri +
        '&duration=permanent&scope=' +
        scope);
  }
}
