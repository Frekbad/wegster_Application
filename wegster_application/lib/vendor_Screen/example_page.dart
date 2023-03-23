// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_model.dart';

class ExamplePage extends StatefulWidget {
  final int? id;
  const ExamplePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late Future<Hotel> hotelData;

  @override
  void initState() {
    int id = widget.id!;
    super.initState();
    hotelData = getVendor(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      backgroundColor: DMColors.backgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: FutureBuilder<Hotel>(
              future: hotelData,
              //initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data!.Hotel_Email}");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        ],
      )),
    );
  }
}
