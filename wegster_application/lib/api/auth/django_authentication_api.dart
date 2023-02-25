// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/widgets/constants.dart';
import 'package:flutter/src/widgets/framework.dart';

Future<dynamic> userAuth(String email, String password) async {
  Map body = {
    //"username": "",
    "email": email,
    "password": password
  };
  var url = Uri.parse("$baseUrl/user/auth/login/");
  var res = await http.post(url, body: body);

  print(res.body);
  print(res.statusCode);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['key'];
    var box = await Hive.openBox(authBox);
    box.put("token", token);
    User? user = await getUser(token);
    return user;
  } else {
    Map json = jsonDecode(res.body);
    print(json);
    if (json.containsKey("email")) {
      return json["email"][0];
    }
    if (json.containsKey("password")) {
      return json["password"][0];
    }
    if (json.containsKey("non_field_errors")) {
      return json["non_field_errors"][0];
    }
  }
}

Future<User?> getUser(String token) async {
  var url = Uri.parse("$baseUrl/user/auth/user/");
  var res = await http.get(url, headers: {
    'Authorization': 'Token ${token}',
  });
  // print(res.body);
  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);
    User user = User.fromJson(json);
    user.token = token;
    return user;
  } else {
    return null;
  }
}

Future<void> logoutUser(String token) async {
  var url = Uri.parse("$baseUrl/user/auth/logout/");
  var res = await http.post(url, headers: {
    'Authorization': 'Token ${token}',
  });
  print(res.body);
}

Future<dynamic> registerUser(
  String email,
  String password,
  String confirm_password,
  String name,
  String address,
) async {
  Map<String, dynamic> data = {
    "email": email,
    "password1": password,
    "password2": confirm_password,
    "name": name,
    "address": address
  };

  var url = Uri.parse("$baseUrl/user/registration/customer/");
  var res = await http.post(url, body: data);

  // print(res.body);
  if (res.statusCode == 200 || res.statusCode == 201) {
    Map json = jsonDecode(res.body);

    if (json.containsKey("key")) {
      String token = json["key"];

      var box = await Hive.openBox(authBox);
      box.put("token", token);
      var a = await getUser(token);
      if (a != null) {
        User user = a;
        return user;
      } else {
        return null;
      }
    }
  } else if (res.statusCode == 400) {
    Map json = jsonDecode(res.body);
    if (json.containsKey('email')) {
      return json['email'][0];
    } else if (json.containsKey('password')) {
      return json['password'][0];
    }
  } else {
    print(res.body);
    print(res.statusCode);
    return null;
  }
}

Future<dynamic> VendorRequestSignUp(
    String hotel_name, String email, String address) async {
  Map<String, dynamic> data = {
    "email": email,
    "HotelName": hotel_name,
    "Address": address
  };
  var url = Uri.parse("$baseUrl/user/unverifiedvendor/");
  var res = await http.post(url, body: data);
}

Future<dynamic> RequestPasswordToken(
  String email,
) async {
  Map<String, dynamic> data = {"email": email};
  var url = Uri.parse("$baseUrl/user/auth/password-reset/");
  var res = await http.post(url, body: data);

  // print(res.body);
  if (res.statusCode == 200 || res.statusCode == 201) {
    Map json = jsonDecode(res.body);

    if (json.containsKey("key")) {
      String token = json["key"];

      var box = await Hive.openBox(authBox);
      box.put("token", token);
      var a = await getUser(token);
      if (a != null) {
        User user = a;
        return user;
      } else {
        return null;
      }
    }
  } else if (res.statusCode == 400) {
    Map json = jsonDecode(res.body);
  } else {
    print(res.body);
    print(res.statusCode);
    return null;
  }
}


// Future<dynamic> UserConfirmEmail(String key) async {
//   Map body = {"key": key};
//   var url = Uri.parse("$baseUrl/user/auth/confirm-email/");
//   var res = await http.post(
//     url,
//     body: body,
//   );
// }
