var headers = {
  'Authorization': 'Bearer 665437477327-i9kEoecSWtSnN52wl47ISVITr6McsQ'
};
var request = http.Request('GET', Uri.parse('https://oauth.reddit.com/api/v1/me/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
print(await response.stream.bytesToString());
}
else {
print(response.reasonPhrase);
}


final response = await http.get(
Uri.parse('https://oauth.reddit.com/api/v1/me/'),
headers: {
"Authorization": 'Bearer ' + token.accessToken,
'Content-Type': 'application/x-www-form-urlencoded',
},
);
print("biteepzaheza " + token.accessToken);
print(response.body);

if (response.statusCode == 200) {
return AccountInfo.fromJson(jsonDecode(response.body));
} else {
throw Exception('Failed to get user info');
}