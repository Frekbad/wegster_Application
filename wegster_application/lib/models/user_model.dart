// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, avoid_print, unused_import
import 'package:flutter/material.dart';

class User {
  int? id;
  String? token;
  String? username;
  String? email, name, address;
  int? is_user;
  User({this.id, this.name, this.email, this.address, this.is_user
      //this.phone,
      });

  factory User.fromJson(json) {
    print(json);
    return User(
      id: json["pk"],
      name: json["name"],
      email: json["email"],
      address: json["address"],
      is_user: json["user_type"],
    );
    //phone: json["phone"]);
  }
}

class Hotel {
  int? Hotel_ID;
  String? Hotel_Token;
  String? Hotel_Email;
  String? Hotel_Name;
  String? Hotel_Location;
  String? Hotel_Image;

  String? Hotel_Description;

  Hotel(
      {this.Hotel_ID,
      this.Hotel_Token,
      this.Hotel_Email,
      this.Hotel_Name,
      this.Hotel_Location,
      this.Hotel_Image,
      this.Hotel_Description});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        Hotel_ID: json["Hotel_ID"],
        Hotel_Token: json["Hotel_Token"],
        Hotel_Email: json["Hotel_email"],
        Hotel_Name: json["HotelName"],
        Hotel_Location: json["Hotel_Location"],
        Hotel_Image: json["Hotel_Image"],
        Hotel_Description: json["Hotel_Description"]
        //Hotel_Price: json["Hotel_Image"],
        );
  }
}

class Rooms {
  final int? Hotel_ID;

  final int? Room_ID;
  final String? Room_Type;
  final String? Bed_Type;
  final String? Refundable_Option;
  final String? price_per_night;

  Rooms({
    this.Hotel_ID,
    this.Room_ID,
    this.Room_Type,
    this.Bed_Type,
    this.Refundable_Option,
    this.price_per_night,
  });

  factory Rooms.fromJson(Map<String, dynamic> json) {
    return Rooms(
      Hotel_ID: json["Hotel_ID"],
      price_per_night: json["price_per_night"],
      Room_Type: json["Room_Type"],
      Room_ID: json["Room_ID"],
      Bed_Type: json["Bed_Type"],
      Refundable_Option: json["Refundable_Option"],
    );
  }
}

class Bus {
  int? Bus_ID;
  String? Busname;

  String? source;
  String? dest;
  double? price;
  int? totalSeats;
  String? email;

  Bus(
      {this.Bus_ID,
      this.Busname,
      this.source,
      this.dest,
      this.price,
      this.totalSeats,
      this.email});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
        Bus_ID: json['Bus_ID'],
        Busname: json['Busname'],
        source: json['source'],
        dest: json['dest'],
        price: double.parse(json['price']),
        totalSeats: json['totalSeats'],
        email: json['email']);
  }
}

class Busbooking {
  int? id;
  int? Bus_ID;
  String? name;
  String? address;
  String? price;
  String? Order_Status;
  String? source;
  String? dest;
  bool? Payment_Completed;
  String? Payment;
  int? user;
  String? Busname;
  int? Seat_ID;
  String? email;

  Busbooking(
      {this.id,
      this.Bus_ID,
      this.name,
      this.address,
      this.price,
      this.Order_Status,
      this.source,
      this.dest,
      this.Payment_Completed,
      this.Payment,
      this.user,
      this.Busname,
      this.Seat_ID,
      this.email});

  factory Busbooking.fromJson(Map<String, dynamic> json) {
    return Busbooking(
        id: json['id'],
        Bus_ID: json['Bus_ID'],
        name: json['name'],
        price: json['price'],
        Order_Status: json['Order_Status'],
        source: json['source'],
        dest: json['dest'],
        Payment: json['Payment'],
        Payment_Completed: json['Payment_Completed'],
        user: json["user"],
        address: json['address'],
        Busname: json['Busname'],
        Seat_ID: json['Seat_ID'],
        email: json['email']);
  }
}

class HotelBooking {
  int? id;
  String? Room_Type;
  String? Bed_Type;
  String? price_per_night;
  String? Refundable_Option;
  int? user;
  String? name;
  String? address;
  String? Hotel_Email;
  String? HotelName;
  String? Hotel_Location;
  int? Hotel_ID;
  String? Payment;
  String? Order_Status;
  bool? Payment_Completed;

  HotelBooking({
    this.id,
    this.Room_Type,
    this.Bed_Type,
    this.price_per_night,
    this.Refundable_Option,
    this.user,
    this.name,
    this.address,
    this.Hotel_Email,
    this.HotelName,
    this.Hotel_Location,
    this.Hotel_ID,
    this.Payment,
    this.Order_Status,
    this.Payment_Completed,
  });

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
        id: json["id"],
        Room_Type: json["Room_Type"],
        Bed_Type: json["Bed_Type"],
        price_per_night: json["price_per_night"],
        Refundable_Option: json["Refundable_Option"],
        user: json["user"],
        name: json["name"],
        address: json["address"],
        Hotel_Email: json["Hotel_email"],
        HotelName: json["HotelName"],
        Hotel_Location: json["Hotel_Location"],
        Hotel_ID: json["Hotel_ID"],
        Payment: json["Payment"],
        Order_Status: json["Order_Status"],
        Payment_Completed: json["Payment_Completed"]);
  }
}

class Seat {
  int? Seat_ID;
  int? Bus_ID;
  String? Seat_number;
  bool? available;

  Seat({
    this.Seat_ID,
    this.Bus_ID,
    this.Seat_number,
    this.available,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      Seat_ID: json['Seat_ID'],
      Bus_ID: json['Bus_ID'],
      Seat_number: json['Seat_number'],
      available: json['available'],
    );
  }
}

class Reviews {
  int? id;
  double? rating;
  String? Review;
  String? Customer_Name;
  int? Hotel_ID;
  String? Hotelname;

  Reviews({
    this.id,
    this.rating,
    this.Review,
    this.Customer_Name,
    this.Hotel_ID,
    this.Hotelname,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['id'],
      rating: json['Rating'],
      Review: json['Review'],
      Hotelname: json['Hotelname'],
      Customer_Name: json['Customer_Name'],
      Hotel_ID: json['Hotel_ID'],
    );
  }
}
