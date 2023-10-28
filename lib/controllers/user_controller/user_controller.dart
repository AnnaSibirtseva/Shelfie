import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/user.dart';

class UserController{

  static Future<int> postUserLogin(String email, String password) async {
    var client = http.Client();
    final jsonString = json.encode({
      "email": email,
      "password": password,
    });
    try {
      var response = await client.post(Uri.https(url, '/users/user/login'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode == 200) {
        return User.userIdFromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .getId();
      } else {
        throw Exception('Не удалось зайти в приложение');
      }
    } finally {
      client.close();
    }
  }

  static Future<bool> postAddUser(String email, String password, String name) async {
    var client = http.Client();
    final jsonString = json.encode({
      "email": email,
      "password": password,
      "name": name
    });
    try {
      var response = await client.post(Uri.https(url, '/users/user/add'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } finally {
      client.close();
    }
  }
}