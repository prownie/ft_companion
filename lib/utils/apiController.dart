import 'package:http/http.dart' as http;

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
    var json = await http.post(Uri.https(url42 + 'oauth/token'), body: {
      "grant_type": "client_credentials",
      "client_id": this.uid,
      "client_secret": this.secret
    });
  }

  searchProfile(String value) {}
}
