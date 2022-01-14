import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_test/edit.dart';
import 'package:rest_test/services/services.dart';
import 'package:rest_test/models/type.dart';

import 'create_type.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<TypeElement> _types = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    getType();
  }

  getType() {
    Services.getTypes().then((types) {
      _types = types;
      setState(() {
        _loading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'loading..' : 'Types'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (BuildContext context) => createType(),
              ),
            )
            .then((value) => getType()),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: _types.length,
            itemBuilder: (context, index) {
              TypeElement typelist = _types[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => edit_Type(
                            onetype: typelist,
                          ),
                        ),
                      )
                      .then((value) => {_loading = false, getType()});
                },
                title: Text(typelist.type.toString()),
              );
            }),
      ),
    );
  }
}
