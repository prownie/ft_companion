import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class apiController {
  late String uid;
  late String secret;
  late String url42;
  late String token = '';
  static final apiController instance = apiController._internal();

  apiController._internal();

  initValues(String uid, String secret, String url42) {
    this.uid = uid;
    this.secret = secret;
    this.url42 = url42;
  }

  factory apiController() {
    return instance;
  }

  getToken() async {
    try {
      var response = await http.post(Uri.https(url42, '/oauth/token'), body: {
        "grant_type": "client_credentials",
        "client_id": uid,
        "client_secret": secret
      });
      if (response.statusCode == 200) {
        token = jsonDecode(response.body)['access_token'];
      }
    } catch (e) {
      print('error caught: $e.toString()');
    }
  }

  Future<List<dynamic>> searchProfilesAutoCompletion(String value) async {
    //retrieve all users whose login starts with "value"
    var response = await http.get(
      Uri.https(url42, '/v2/users', {'range[login]': '$value,${value}z'}),
      headers: {
        "Authorization": "bearer  $token",
      },
    );
    if (response.statusCode == 200) {
      return await jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      await getToken();
      return await searchProfilesAutoCompletion(value);
    } else if (response.statusCode == 429) {
      sleep(const Duration(seconds: 1));
      return await searchProfilesAutoCompletion(value);
    } else {
      return [];
    }
  }

  Future<dynamic> searchUser(String value, {int retry = 0}) async {
    //retrieve all users whose login starts with "value"
    sleep(const Duration(milliseconds: 500));
    var response = await http.get(
      Uri.https(url42, '/v2/users/' + value),
      headers: {
        "Authorization": 'bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return await jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      await getToken();
      return await searchUser(value);
    } else if (response.statusCode == 429) {
      if (retry < 5) {
        print('retrySearchUser');
        sleep(const Duration(seconds: 1));
        return await searchUser(value, retry: retry + 1);
      } else {
        return {'id': 0};
      }
    } else {
      return {'id': 0};
    }
  }

  Future<dynamic> getCoalitionsData(String value, {int retry = 0}) async {
    //retrieve all users whose login starts with "value"
    sleep(const Duration(milliseconds: 500));
    var response = await http.get(
      Uri.https(url42, '/v2/users/$value/coalitions'),
      headers: {
        "Authorization": 'bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return await jsonDecode(response.body)[0];
    } else if (response.statusCode == 401) {
      await getToken();
      return await getCoalitionsData(value);
    } else if (response.statusCode == 429) {
      if (retry < 5) {
        sleep(const Duration(seconds: 1));
        // return await getCoalitionsData(value, retry: retry + 1);
      } else {
        return {'name': null};
      }
    } else {
      return {'name': null};
    }
  }
}
