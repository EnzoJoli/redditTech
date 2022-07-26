import 'package:flutter/foundation.dart';

class AccessToken {
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  String scope;

  AccessToken(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.refreshToken,
      required this.scope});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
        accessToken: json['access_token'],
        tokenType: json['token_type'] as String,
        expiresIn: json['expires_in'] as int,
        refreshToken: json['refresh_token'] as String,
        scope: json['scope'] as String);
  }
  factory AccessToken.update(String accessTokenb, String tokenTypeb,
      int expiresInb, String refreshTokenb, String scopeb) {
    print("bite");
    return AccessToken(
        accessToken: accessTokenb,
        tokenType: tokenTypeb,
        expiresIn: expiresInb,
        refreshToken: refreshTokenb,
        scope: scopeb);
  }

  factory AccessToken.init() {
    return AccessToken(
        accessToken: "",
        tokenType: "",
        expiresIn: 0,
        refreshToken: "",
        scope: "");
  }
}
