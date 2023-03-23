// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Hotels {
//   final int id;
//   final String name;
//   final String location;
//   final String checkInDate;
//   final String checkOutDate;
//   final double price;

//   Hotels({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.checkInDate,
//     required this.checkOutDate,
//     required this.price,
//   });

//   factory Hotels.fromJson(Map<String, dynamic> json) {
//     return Hotels(
//       id: json['id'],
//       name: json['name'],
//       location: json['location'],
//       checkInDate: json['check_in_date'],
//       checkOutDate: json['check_out_date'],
//       price: json['price'].toDouble(),
//     );
//   }
// }

// class HotelSearchForm extends StatefulWidget {
//   @override
//   _HotelSearchFormState createState() => _HotelSearchFormState();
// }

// class _HotelSearchFormState extends State<HotelSearchForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _locationController = TextEditingController();
//   final _checkInDateController = TextEditingController();
//   final _checkOutDateController = TextEditingController();
//   final _priceMinController = TextEditingController();
//   final _priceMaxController = TextEditingController();
//   List<Hotels> _hotels = [];

//   Future<void> _searchHotels() async {
//     final url = Uri.parse('http://example.com/api/hotels/');
//     final response = await http.get(url, headers: {
//       'Accept': 'application/json',
//     }, queryParameters: {
//       'location': _locationController.text,
//       'check_in_date': _checkInDateController.text,
//       'check_out_date': _checkOutDateController.text,
//       'price_min': _priceMinController.text,
//       'price_max': _priceMaxController.text,
//     });
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       final List<Hotels> hotels =
//           data.map((json) => Hotels.fromJson(json)).toList();
//       setState(() {
//         _hotels = hotels;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search for hotels'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _locationController,
//               decoration: InputDecoration(
//                 labelText: 'Location',
//               ),
//             ),
//             TextFormField(
//               controller: _checkInDateController,
//               decoration: InputDecoration(
//                 labelText: 'Check-in date',
//               ),
//             ),
//             TextFormField(
//               controller: _checkOutDateController,
//               decoration: InputDecoration(
//                 labelText: 'Check-out date',
//               ),
//             ),
//             TextFormField(
//               controller: _priceMinController,
//               decoration: InputDecoration(
//                 labelText: 'Price min',
//               ),
//             ),
//             TextFormField(
//               controller: _priceMaxController,
//               decoration: InputDecoration(
//                 labelText: 'Price max',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: _searchHotels,
//               child: Text('Search'),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _hotels.length,
//                 itemBuilder: (context, index) {
//                   final hotel = _hotels[index];
//                   return ListTile(
//                     title: Text(hotel.name),
//                     subtitle: Text(
//                         '${hotel.location} - ${hotel.checkInDate} to ${hotel.checkOutDate}'),
//                     trailing: Text('${hotel.price}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
