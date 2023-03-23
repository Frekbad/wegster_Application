// import 'package:flutter/material.dart';
// import 'package:wegster_application/api/auth/django_authentication_api.dart';
// import 'package:wegster_application/widgets/constants.dart';
// import 'package:http/http.dart' as http;

// class Update extends StatefulWidget {
//   const Update({super.key});

//   @override
//   State<Update> createState() => _UpdateState();
// }

// class _UpdateState extends State<Update> {
//   @override

//   Widget build(BuildContext context) {
//     Future<dynamic> updateDetails(
//         String key, String fullName, String phoneNumber) async {
//       Map body = {"full_name": fullName, "phonenumber": phoneNumber};
//       var url = Uri.parse("$baseUrl/auth/details/");
//       var res = await http.put(url,
//           headers: {'Authorization': 'Token ${key}'}, body: body);
//       getUser(key);

//       print(res.body);
//       print(res.statusCode);

//       if (res.statusCode == 200 || res.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             backgroundColor: Colors.green,
//             content: Text(
//               "Login Successfull",
//               textAlign: TextAlign.center,
//             )));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             backgroundColor: Colors.green,
//             content: Text(
//               "Login Successfull",
//               textAlign: TextAlign.center,
//             )));
//       }
//     }
//   }
// }
