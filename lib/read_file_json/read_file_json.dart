import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:responsive_login_ui/data/model/district.dart';
import 'package:responsive_login_ui/data/model/province.dart';
import '../data/model/wards.dart';

Future<List<Province>?> readFileProvinceJson(String path) async {
  String response = await rootBundle.loadString(path);
  Map<String, dynamic> mapData = json.decode(response) as Map<String, dynamic>;
  mapData.values.forEach((element) {
    element['code'] = int.parse(element["code"]);
  });
  return mapData.values.map((element) => Province.fromJson(element)).toList();
}

Future<List<District>?> readFileDistrictJson(String path) async {
  String response = await rootBundle.loadString(path);
  Map<String, dynamic> mapData = json.decode(response) as Map<String, dynamic>;
  mapData.values.forEach((element) {
    element['code'] = int.parse(element["code"]);
    element['parent_code'] = int.parse(element['parent_code']);
  });
  return mapData.values.map((element) => District.fromJson(element)).toList();
}

Future<List<Ward>?> readFileWardJson(String path) async {
  String response = await rootBundle.loadString(path);
  Map<String, dynamic> mapData = json.decode(response) as Map<String, dynamic>;
  mapData.values.forEach((element) {
    element['code'] = int.parse(element["code"]);
    element['parent_code'] = int.parse(element['parent_code']);
  });
  return mapData.values.map((element) => Ward.fromJson(element)).toList();
}
