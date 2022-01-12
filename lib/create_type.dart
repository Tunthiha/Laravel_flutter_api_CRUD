import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/type.dart';
import 'package:http/http.dart' as http;

class createType extends StatefulWidget {
  const createType({Key? key}) : super(key: key);

  @override
  _createTypeState createState() => _createTypeState();
}

Future<Type> submitType(String type) async {
  var response = await http.post(
      Uri.https('testing-hero-laravel.herokuapp.com', 'api/type/store'),
      body: {"type": type});
  final data = json.decode(response.body);

  print(data);
  if (response.statusCode == 200) {
    return Type.fromJson(data);
  } else {
    throw Exception('Failed to load album');
  }
}

class _createTypeState extends State<createType> {
  // void addData() {
  //   var url = "http://testing-hero-laravel.herokuapp.com/api/type/store";

  //   http.post(Uri.parse(url), body: {
  //     "type": typeController.text,
  //   });
  // }

  TextEditingController typeController = TextEditingController();
  TypeElement? _typeElement;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crate"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                      hintText: "Employee Type", labelText: "Employee type"),
                ),
                TextButton(
                    onPressed: () async {
                      String type = typeController.text;
                      await submitType(type);
                      //addData();
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text("Add Type"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
