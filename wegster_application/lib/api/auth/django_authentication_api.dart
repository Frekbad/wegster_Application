// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:wegster_application/exports/exports.dart';
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
) async {
  Map<String, dynamic> data = {
    "email": email,
    "password1": password,
    "password2": confirm_password,
    "name": name,
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

Future<List<Hotel>> VendorData() async {
  List<Hotel> myTodos = [];
  const String api = 'http://10.0.2.2:8000/user/Hotel/';
  var res = await http.get(Uri.parse(api));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      Hotel t = Hotel(
          Hotel_Name: todo['HotelName'],
          Hotel_Email: todo['Hotel_email'],
          Hotel_ID: todo['Hotel_ID'],
          Hotel_Location: todo['Hotel_Location'],
          Hotel_Token: todo['Hotel_Token'],
          Hotel_Image: todo['Hotel_Image'],
          Hotel_Price: todo['Hotel_Price'],
          Hotel_Description: todo['Hotel_Description']);
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}

Future<Hotel> getVendor(int pk) async {
  const String api = 'http://10.0.2.2:8000/user/Hotel/';
  String PK = pk.toString();
  var res = await http.get(Uri.parse(api + PK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var json = jsonDecode(res.body);
    Hotel restaurant = Hotel.fromJson(json);
    return restaurant;
  } else {
    throw Exception("Error");
  }
}

Future<dynamic> postHotelDetails(int pk, String BusinessName, String Email,
    String Token, String Location) async {
  var url = Uri.parse("$baseUrl/user/Hotel/");
  var res = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "Hotel_ID": pk,
        "HotelName": BusinessName,
        "Hotel_email": Email,
        "Hotel_Location": Location,
        "Hotel_Token": Token,
        //"Hotel_Price":
      }));
  print(res.body);
  print(res.statusCode);
}

Future<dynamic> postRoomDetails(
  String Bed_Type,
  String Room_Type,
  String price_per_night,
  String Refundable_Option,
  String Hotel_ID,
) async {
  var url = Uri.parse("$baseUrl/user/Room/");
  var res = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "Bed_Type": Bed_Type,
        "Room_Type": Room_Type,

        "price_per_night": price_per_night,
        "Refundable_Option": Refundable_Option,
        "Hotel_ID": Hotel_ID
        //"Hotel_Price":
      }));
  print(res.body);
  print(res.statusCode);
}

Future<List<Rooms>> RoomsData(int id) async {
  List<Rooms> roomData = [];
  String FK = id.toString();
  const String api = '$baseUrl/user/Room/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      Rooms t = Rooms(
        Hotel_ID: todo["Hotel_ID"],
        price_per_night: todo["price_per_night"],
        Room_Type: todo["Room_Type"],
        Room_ID: todo["Room_ID"],
        Bed_Type: todo["Bed_Type"],
        Refundable_Option: todo["Refundable_Option"],
      );
      roomData.add(t);
    });
    return roomData;
  } else {
    throw Exception("Error");
  }
}

Future<List<HotelBooking>> GetCustomerOrder(int id) async {
  List<HotelBooking> myTodos = [];
  String FK = id.toString();
  const String api = 'http://10.0.2.2:8000/user/RoomBookUser/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      HotelBooking t = HotelBooking(
          Room_Type: todo["Room_Type"],
          Bed_Type: todo["Bed_Type"],
          price_per_night: todo["price_per_night"],
          Refundable_Option: todo["Refundable_Option"],
          user: todo["user"],
          name: todo["name"],
          address: todo["address"],
          Hotel_Email: todo["Hotel_email"],
          HotelName: todo["HotelName"],
          Hotel_Location: todo["Hotel_Location"],
          Hotel_ID: todo["Hotel_ID"],
          Order_Status: todo["Order_Status"]);
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}

Future<dynamic> posthotelbooking(
  String Room_Type,
  String Bed_Type,
  String price_per_night,
  String Refundable_Option,
  int user,
  String name,
  String address,
  String Hotel_email,
  String HotelName,
  String Hotel_Location,
  int Hotel_ID,
) async {
  var url = Uri.parse("$baseUrl/user/RoomBook/");
  String Payment = "cash_Indoor";
  String Order_Status = "Pending";
  bool Payment_Complete = false;
  var res = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "Room_Type": Room_Type,
        "Bed_Type": Bed_Type,
        "price_per_night": price_per_night,
        "Refundable_Option": Refundable_Option,
        "user": user,
        "name": name,
        "address": address,
        "Hotel_email": Hotel_email,
        "HotelName": HotelName,
        "Hotel_Location": Hotel_Location,
        "Hotel_ID": Hotel_ID,
        "Payment": Payment,
        "Order_Status": Order_Status,
        "Payment_Complete": Payment_Complete,
      }));
  print(res.body);
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    Fluttertoast.showToast(
        msg: "Room Has Been Added For Booking",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: DMColors.greenColor,
        textColor: Colors.white);
  } else {
    Fluttertoast.showToast(
        msg: "Sorry! Something went wrong",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: DMColors.redColor,
        textColor: Colors.white);
    print("Sorry");
  }
}

// class BusRepository {
//   static const String baseUrl = 'http://localhost:8000/user/buses/';

Future<List<Bus>> GetBus() async {
  List<Bus> myTodos = [];
  const String api = 'http://10.0.2.2:8000/user/Bus/';
  var res = await http.get(Uri.parse(api));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    print(res.body);
    data.forEach((todo) {
      Bus t = Bus(
          Bus_ID: todo['Bus_ID'],
          Busname: todo['Busname'],
          source: todo['source'],
          dest: todo['dest'],
          price: double.parse(todo['price']),
          totalSeats: todo['totalSeats']);
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}

Future<List<Seat>> seatsData(int id) async {
  List<Seat> seatData = [];
  String FK = id.toString();
  const String api = '$baseUrl/user/Seat/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      bool available = todo['available'].toString().toLowerCase() == "true";
      Seat t = Seat(
        Seat_ID: todo['Seat_ID'],
        Bus_ID: todo['Bus_ID'],
        Seat_number: todo['Seat_number'],
        available: available,
      );
      seatData.add(t);
    });

    return seatData;
  } else {
    throw Exception("Error");
  }
}

class FetchUser {
  var data = [];
  List<Hotel> results = [];
  String api = '$baseUrl/user/Hotel/';
  Future<List<Hotel>> getUserList({String? query}) async {
    var url = Uri.parse(api);
    var res = await http.get(url);
    try {
      if (res.statusCode == 200) {
        data = json.decode(res.body);
        results = data.map((e) => Hotel.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.Hotel_Name!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}

Future<dynamic> postbusbooking(
    String name,
    String source,
    String dest,
    int user,
    double price,
    String address,
    int Bus_ID,
    String Busname,
    int Seat_ID) async {
  var url = Uri.parse("$baseUrl/user/BusBook/");
  String Payment = "cash_Indoor";
  String Order_Status = "Pending";
  bool Payment_Complete = false;
  var res = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "address": address,
        "source": source,
        "dest": dest,
        "price": price,
        "Payment": Payment,
        "Order_Status": Order_Status,
        "Payment_Completed": Payment_Complete,
        "Bus_ID": Bus_ID,
        "user": user,
        "Busname": Busname,
        "Seat_ID": Seat_ID
      }));
  print(res.body);
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    Fluttertoast.showToast(
        msg: "Bus Seat Has Been Added For Booking",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: DMColors.greenColor,
        textColor: Colors.white);
  } else {
    Fluttertoast.showToast(
        msg: "Sorry! Something went wrong",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: DMColors.redColor,
        textColor: Colors.white);
    print("Sorry");
  }
}

Future<List<Busbooking>> GetUserBusBooking(int id) async {
  List<Busbooking> myTodos = [];
  String FK = id.toString();
  const String api = 'http://10.0.2.2:8000/user/BusBookUser/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      Busbooking t = Busbooking(
          id: todo['id'],
          Bus_ID: todo['Bus_ID'],
          name: todo['name'],
          price: todo['price'],
          Order_Status: todo['Order_Status'],
          source: todo['source'],
          dest: todo['dest'],
          Payment: todo['Payment'],
          //Payment_Completed: todo['Payment_Completed'],
          user: todo["user"],
          address: todo['address'],
          Busname: todo['Busname'],
          Seat_ID: todo['Seat_ID']);
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}

class FetchBus {
  var data = [];
  List<Bus> results = [];
  String api = '$baseUrl/user/Bus/';
  Future<List<Bus>> getBusList({String? query}) async {
    var url = Uri.parse(api);
    var res = await http.get(url);
    try {
      if (res.statusCode == 200) {
        data = json.decode(res.body);
        results = data.map((e) => Bus.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.Busname!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}

Future<dynamic> confirmPurchase(int id, String status) async {
  String ID = id.toString();
  Map body = {"Order_Status": status};
  var url = Uri.parse("$baseUrl/user/RoomBook/$ID");
  var res = await http.put(url, body: body);

  print(res.body);
  print(res.statusCode);
}

Future<List<HotelBooking>> GetVendorHotelOrder(int id) async {
  List<HotelBooking> myTodos = [];
  String FK = id.toString();
  const String api = 'http://10.0.2.2:8000/user/RoomBookVendor/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      HotelBooking t = HotelBooking(
          id: todo["id"],
          Room_Type: todo["Room_Type"],
          Bed_Type: todo["Bed_Type"],
          price_per_night: todo["price_per_night"],
          Refundable_Option: todo["Refundable_Option"],
          user: todo["user"],
          name: todo["name"],
          address: todo["address"],
          Hotel_Email: todo["Hotel_email"],
          HotelName: todo["HotelName"],
          Hotel_Location: todo["Hotel_Location"],
          Hotel_ID: todo["Hotel_ID"],
          Payment: todo["Payment"],
          Order_Status: todo["Order_Status"],
          Payment_Completed: todo["Payment_Completed"]);
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}

Future<dynamic> HotelBookingNotificationSend(
    String email, String message) async {
  Map<String, String> body = {"email": email, "message": message};
  var url = Uri.parse("$baseUrl/user/send-email-notification/");
  var res = await http.post(url, body: body);
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    return 'Notification Send Successfully';
  } else {
    throw Exception("error");
  }
}

Future<dynamic> postReview(double rating, String text) async {
  const url = '$baseUrl/user/reviews/';
  final response = await http.post(
    Uri.parse(url),
    body: {'rating': rating.toString(), 'text': text},
  );
  if (response.statusCode == 201) {
    print('Review posted successfully.');
  } else {
    print('Failed to post review.');
  }
}

Future<List<Reviews>> GetReviews(int id) async {
  List<Reviews> myTodos = [];
  String FK = id.toString();
  const String api = 'http://10.0.2.2:8000/user/Review/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);
  print(res.body);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      Reviews t = Reviews(
        id: todo['id'],
        rating: todo['Rating'],
        Review: todo['Review'],
        Hotelname: todo['Hotelname'],
        Customer_Name: todo['Customer_Name'],
        Hotel_ID: todo['Hotel_ID'],
      );
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}

Future<dynamic> registerAdmin(
  String email,
  String password,
  String confirm_password,
  String name,
) async {
  Map<String, dynamic> data = {
    "email": email,
    "password1": password,
    "password2": confirm_password,
    "name": name,
  };

  var url = Uri.parse("$baseUrl/user/registration/Admin/");
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

Future<List<Busbooking>> GetBusBooking(int id) async {
  List<Busbooking> myTodos = [];
  String FK = id.toString();
  const String api = 'http://10.0.2.2:8000/user/BusBookseat/';
  var res = await http.get(Uri.parse(api + FK));
  print(res.statusCode);

  if (res.statusCode == 200 || res.statusCode == 201) {
    var data = jsonDecode(res.body);
    data.forEach((todo) {
      Busbooking t = Busbooking(
          id: todo['id'],
          Bus_ID: todo['Bus_ID'],
          name: todo['name'],
          price: todo['price'],
          Order_Status: todo['Order_Status'],
          source: todo['source'],
          dest: todo['dest'],
          Payment: todo['Payment'],
          Payment_Completed: todo['Payment_Completed'],
          user: todo["user"],
          address: todo['address'],
          Busname: todo['Busname'],
          Seat_ID: todo['Seat_ID']);
      myTodos.add(t);
    });
    return myTodos;
  } else {
    throw Exception("Error");
  }
}
