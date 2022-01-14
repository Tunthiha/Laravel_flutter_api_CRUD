import 'package:flutter/material.dart';
import 'package:rest_test/models/type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class edit_Type extends StatefulWidget {
  final TypeElement onetype;

  const edit_Type({
    Key? key,
    required this.onetype,
  }) : super(key: key);

  @override
  _edit_TypeState createState() => _edit_TypeState();
}

class _edit_TypeState extends State<edit_Type> {
  TextEditingController typeController = TextEditingController();
  String type_id = "";

  void initState() {
    typeController = TextEditingController(text: widget.onetype.type);
    type_id = widget.onetype.id.toString();
    //print(widget.onetype.type);
    super.initState();
  }

  Future<Type> submitType(String type) async {
    var response = await http.put(
        Uri.https(
            'testing-hero-laravel.herokuapp.com', 'api/type/update/{$type_id}'),
        body: {
          "id": widget.onetype.id.toString(),
          "type": type,
        });
    final data = json.decode(response.body);

    print(data);
    if (response.statusCode == 200) {
      return Type.fromJson(data);
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<TypeElement> submitType(String type) async {
  //   TypeElement data = TypeElement(id: widget.onetype.id);
  //   var response = await http.put(
  //       Uri.https(
  //           'testing-hero-laravel.herokuapp.com', 'api/type/update/{$type_id}'),
  //       body: {
  //         "id": widget.onetype.id.toString(),
  //         "type": type,
  //       }).then((http.Response response) => {
  //         print(jsonDecode(response.body)),
  //         if (response.statusCode == 200)
  //           {data = TypeElement.fromJson(jsonDecode(response.body))}
  //         else
  //           {throw Exception('Failed to load album')}
  //       });

  //   return data;
  //   //print(response.body);
  //   // final data = json.decode(response.body);

  //   //debugPrint(data);
  //   // if (response.statusCode == 200) {
  //   //   return Type.fromJson(data);
  //   // } else {
  //   //   throw Exception('Failed to load album');
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(
                      hintText: "Employee Type", labelText: "Employee type"),
                ),
                TextButton(
                    onPressed: () async {
                      String type = typeController.text;
                      await submitType(type);
                      //addData();
                      //print(typeController.text);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text("Update Type"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
