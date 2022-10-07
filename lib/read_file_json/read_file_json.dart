import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:responsive_login_ui/data/model/district.dart';
import 'package:responsive_login_ui/data/model/province.dart';
import '../data/model/ward.dart';

Future<List<Province>?> readFileProvinceJson(String path) async {
  String response = await rootBundle.loadString(path);
  Map<String, dynamic> mapData = json.decode(response) as Map<String, dynamic>;
  return mapData.values.map((element) => Province.fromJson(element)).toList();
}

Future<List<District>?> readFileDistrictJson(String path) async {
  String response = await rootBundle.loadString(path);
  Map<String, dynamic> mapData = json.decode(response) as Map<String, dynamic>;
  return mapData.values.map((element) => District.fromJson(element)).toList();
}

Future<List<Ward>?> readFileWardJson(String path) async {
  String response = await rootBundle.loadString(path);
  Map<String, dynamic> mapData = json.decode(response) as Map<String, dynamic>;
  return mapData.values.map((element) => Ward.fromJson(element)).toList();
}
