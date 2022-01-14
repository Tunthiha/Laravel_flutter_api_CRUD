// To parse this JSON data, do
//
//     final type = typeFromJson(jsonString);

import 'dart:convert';

Type typeFromJson(String str) => Type.fromJson(json.decode(str));

String typeToJson(Type data) => json.encode(data.toJson());

class Type {
  Type({
    required this.types,
  });

  List<TypeElement> types;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        types: List<TypeElement>.from(
            json["types"].map((x) => TypeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
  @override
  toString() => 'types: $types';
}

class TypeElement {
  TypeElement({
    required this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        id: json["id"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
  @override
  toString() => 'type: $type' ',' 'created_at:$createdAt' ',' 'id:$id';
}
