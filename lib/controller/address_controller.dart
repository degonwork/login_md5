import 'dart:async';
import 'package:get/get.dart';
import 'package:responsive_login_ui/data/model/district.dart';
import 'package:responsive_login_ui/data/model/province.dart';
import 'package:responsive_login_ui/data/repository/address_repo.dart';
import 'package:responsive_login_ui/read_file_json/read_file_json.dart';
import '../data/model/wards.dart';
import '../data/provider/db/address_database.dart';

class AddressController extends GetxController {
  final AddressRepo addressRepo;

  AddressController({required this.addressRepo});

  int? _provinceCode;
  set provinceCode(int code) {
    _provinceCode = code;
    update();
  }

  int? _districtCode;
  set districtCode(int code) {
    _districtCode = code;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    AddressDatabase.instance.close();
  }

  // Processed database
  Future provinceDBProcessed() async {
    final List<Province>? provinces =
        await readFileProvinceJson("lib/json_file/tinh_tp.json");
    if (provinces!.isNotEmpty) {
      await addressRepo.createProvincesToDB(provinces: provinces);
      print("Created provinces to DB");
    }
  }

  Future districtDBProcessed() async {
    String? provinceCodeString =
        convertCodeToString(provinceCode: _provinceCode);
    final List<District>? districts = await readFileDistrictJson(
        "lib/json_file/quan-huyen/$provinceCodeString.json");
    if (districts!.isNotEmpty) {
      await addressRepo.createDistrictToDB(districts: districts);
      print("Created district to DB");
    }
  }

  Future wardDBProcessed() async {
    String? districtCodeString =
        convertCodeToString(districtCode: _districtCode);
    final List<Ward>? wards = await readFileWardJson(
        "lib/json_file/xa-phuong/$districtCodeString.json");
    if (wards!.isNotEmpty) {
      await addressRepo.createWardToDB(wards: wards);
      print("Created ward to DB");
    }
  }

  // Province
  Future<List<Province>> getProvinceSuggestions(String query) async {
    List<Province> results = [];
    List<Province> provinces = await addressRepo.readAllProvincesFromDB();
    if (provinces.isNotEmpty) {
      results = provinces;
    }
    return results
        .where(
          (Province province) => province.name!.toLowerCase().startsWith(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  // District
  Future<List<District>> getDistrictSuggestions(String query) async {
    List<District> results = [];
    List<District> districts = await addressRepo.readAllDistrictFromDB();
    if (districts.isNotEmpty) {
      results = districts;
    }
    return results
        .where(
          (District district) => district.name!.toLowerCase().startsWith(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  Future<void> deleteDistrict() async {
    await addressRepo.deleteDistrictTable();
  }

  // Ward
  Future<List<Ward>> getWardSuggestions(String query) async {
    List<Ward> results = [];
    List<Ward> wards = await addressRepo.readAllWardFromDB();
    if (wards.isNotEmpty) {
      results = wards;
    }
    return results
        .where(
          (Ward ward) => ward.name!.toLowerCase().startsWith(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  Future<void> deleteWard() async {
    await addressRepo.deleteWardTable();
  }

  // Convert
  String? convertCodeToString({int? provinceCode, int? districtCode}) {
    if (provinceCode != null) {
      if (provinceCode < 10) {
        return "0$provinceCode";
      } else {
        return "$provinceCode";
      }
    } else if (districtCode != null) {
      if (districtCode < 10) {
        return "00$districtCode";
      } else if (districtCode < 100) {
        return "0$districtCode";
      } else {
        return "$districtCode";
      }
    } else {
      return null;
    }
  }
}
