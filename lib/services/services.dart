import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_test/models/type.dart';

class Services {
  static List<TypeElement> type = [];
  static const String url =
      'https://testing-hero-laravel.herokuapp.com/api/types';
  static Future<List<TypeElement>> getTypes() async {
    final response = await http.get(Uri.parse(url));
    var responseJson = jsonDecode(response.body);
    if (200 == response.statusCode) {
      final List data = responseJson['types'];
      // Type typelist = Type.fromJson(data);
      // for (Map i in data) {
      //   type.add(TypeElement.fromJson(i));
      // }

      final List<TypeElement> type =
          data.map((e) => TypeElement.fromJson(e)).toList();

      print(type);
      // final List<Type> Types =
      //     data.map((e) => ProductModel.fromJson(e)).toList();
      // return products;

      return type;
    } else {
      return type;
    }
  }
}
